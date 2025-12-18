import 'package:app_mental_health_care/config/api_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vapi/vapi.dart';
import 'package:app_mental_health_care/data/providers/vapi_ai/vapi_state.dart'; // Import file State của bạn

// Thay StateNotifier bằng Notifier
class VapiController extends Notifier<VapiState> {
  VapiClient? _vapiClient;
  VapiCall? _currentCall;

  @override
  VapiState build() {
    // Khởi tạo Client ngay lúc build
    _vapiClient = VapiClient(ApiConfig.apiVapiKey);

    ref.onDispose(() {
      print("VapiController: Disposing resources...");
      _currentCall?.stop();
      _vapiClient?.dispose();
    });

    return const VapiState(
      isCallActive: false,
      isConnecting: false,
      isSpeaking: false,
      isCallEnded: false,
      messages: [],
    );
  }

  Future<void> toggleCall(String userId, String assistantId) async {
    // 1. Nếu đang gọi thì tắt
    if (state.isCallActive) {
      await _currentCall?.stop();
      // State sẽ được cập nhật trong listener 'call-end'
      return;
    }

    // 2. Xin quyền Micro
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) return;

    // 3. Bắt đầu gọi
    try {
      state = state.copyWith(
        isConnecting: true,
        messages: [],
        isCallEnded: false,
      );

      // --- SỰ KHÁC BIỆT LỚN Ở ĐÂY ---
      // Hàm start trả về một object VapiCall
      _currentCall = await _vapiClient!.start(
        assistantId: assistantId,
        assistantOverrides: {
          "variableValues": {"user_id": userId},
        },
      );

      // Lắng nghe sự kiện TRÊN CUỘC GỌI (chứ không phải trên client)
      _currentCall!.onEvent.listen((event) {
        _handleCallEvents(event);
      });
    } catch (e) {
      print("Error starting call: $e");
      state = state.copyWith(isConnecting: false);
    }
  }

  void _handleCallEvents(VapiEvent event) {
    print("Vapi Event: ${event.label}"); // Debug

    switch (event.label) {
      case "call-start":
        state = state.copyWith(
          isConnecting: false,
          isCallActive: true,
          isCallEnded: false,
        );
        break;

      case "call-end":
        state = state.copyWith(
          isCallActive: false,
          isConnecting: false,
          isSpeaking: false,
          isCallEnded: true,
        );
        _currentCall = null; // Reset call object
        break;

      case "speech-start":
        state = state.copyWith(isSpeaking: true);
        break;

      case "speech-end":
        state = state.copyWith(isSpeaking: false);
        break;

      case "message":
        // Code mẫu mới dùng event.value hoặc event.data tùy version,
        // hãy kiểm tra log để parse đúng JSON
        final data = event.value; // Hoặc event.data
        print("Message Data: $data");

        // Logic parse tin nhắn giữ nguyên như cũ (kiểm tra type=transcript)
        if (data is Map &&
            data['type'] == 'transcript' &&
            data['transcriptType'] == 'final') {
          final newMessage = {
            'role': data['role'].toString(),
            'content': data['transcript'].toString(),
          };
          state = state.copyWith(messages: [...state.messages, newMessage]);
        }
        break;
    }
  }

  // Chức năng Mute (Mới có)
  void toggleMute() {
    if (_currentCall != null) {
      final currentStatus = _currentCall!.isMuted;
      _currentCall!.setMuted(!currentStatus);
      // Bạn có thể thêm biến isMuted vào VapiState để UI cập nhật icon Mic

      // 3. CẬP NHẬT STATE ĐỂ UI VẼ LẠI ICON
      state = state.copyWith(isMuted: !currentStatus);
    }
  }
}

final vapiProvider = NotifierProvider<VapiController, VapiState>(() {
  return VapiController();
});
