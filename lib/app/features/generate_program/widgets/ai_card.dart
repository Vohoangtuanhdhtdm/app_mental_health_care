import 'package:app_mental_health_care/data/providers/vapi_ai/vapi_controller.dart';
import 'package:flutter/material.dart';

class AiCard extends StatelessWidget {
  const AiCard({super.key, required this.state, required this.controller});

  final dynamic state;
  final VapiController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[100]!),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar + Pulse Effect
          Stack(
            alignment: Alignment.center,
            children: [
              // Vòng tròn hiệu ứng khi đang nói
              if (state.isSpeaking)
                SizedBox(
                  width: 110,
                  height: 110,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue.withOpacity(0.5),
                    ),
                  ),
                ),

              // Avatar hình ảnh
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.blue.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.psychology,
                  size: 50,
                  color: Colors.white,
                ),
              ),

              // Icon Mute nhỏ góc avatar (nếu đang mute)
              if (state.isMuted)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.mic_off,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          const Text(
            "Tuan AI Coach",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            "Chuyên gia sức khỏe tinh thần",
            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
          ),

          const SizedBox(height: 20),

          // Row hiển thị trạng thái + Nút Mute
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Badge trạng thái
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: state.isSpeaking
                      ? Colors.blue.withOpacity(0.1)
                      : Colors.grey[100],
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: state.isSpeaking
                        ? Colors.blue.withOpacity(0.3)
                        : Colors.transparent,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (state.isSpeaking)
                      const Icon(Icons.graphic_eq, size: 16, color: Colors.blue)
                    else
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: state.isCallActive
                              ? Colors.green
                              : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    const SizedBox(width: 8),
                    Text(
                      _getStatusText(state),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: state.isSpeaking
                            ? Colors.blue
                            : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),

              // Nút Mute (Chỉ hiện khi đang gọi)
              if (state.isCallActive) ...[
                const SizedBox(width: 12),
                IconButton.filledTonal(
                  onPressed: () => controller.toggleMute(),
                  icon: Icon(
                    state.isMuted ? Icons.mic_off : Icons.mic,
                    color: state.isMuted ? Colors.red : Colors.black87,
                  ),
                  tooltip: "Bật/Tắt Mic",
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  String _getStatusText(dynamic state) {
    if (state.isSpeaking) return "Đang nói...";
    if (state.isCallActive) return "Đang lắng nghe...";
    if (state.isConnecting) return "Đang kết nối...";
    return "Sẵn sàng";
  }
}
