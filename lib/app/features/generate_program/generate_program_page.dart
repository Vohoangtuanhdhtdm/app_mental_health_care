import 'package:app_mental_health_care/app/features/generate_program/widgets/ai_card.dart';
import 'package:app_mental_health_care/app/features/generate_program/widgets/button_content.dart';
import 'package:app_mental_health_care/app/features/generate_program/widgets/message_item.dart';
import 'package:app_mental_health_care/app/features/home/view/profile/profile_page.dart';
import 'package:app_mental_health_care/config/api_config.dart';
import 'package:app_mental_health_care/data/providers/vapi_ai/vapi_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenerateProgramPage extends ConsumerWidget {
  const GenerateProgramPage({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vapiState = ref.watch(vapiProvider);
    final vapiController = ref.read(vapiProvider.notifier);

    // 2. Xử lý điều hướng (Side Effect)
    ref.listen(vapiProvider, (previous, next) {
      if (next.isCallEnded && !(previous?.isCallEnded ?? false)) {
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (!context.mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Đã xong! Đang chuyển hướng đến hồ sơ..."),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ProfilePage();
              },
            ),
          );
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tạo Kế Hoạch Chăm Sóc Sức Khỏe",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "Trò chuyện với AI Coach để xây dựng lộ trình sức khỏe cá nhân hóa cho bạn.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 30),
            AiCard(state: vapiState, controller: vapiController),

            const SizedBox(height: 20),

            Expanded(
              child: vapiState.messages.isEmpty
                  ? Center(
                      child: Text(
                        "Nhấn 'Bắt đầu' để trò chuyện",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 192, 188, 188),
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: vapiState.messages.length,
                        separatorBuilder: (c, i) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final msg = vapiState.messages[index];
                          final isAi = msg['role'] == 'assistant';
                          return MessageItem(
                            isAi: isAi,
                            content: msg['content'] ?? "",
                          );
                        },
                      ),
                    ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getButtonColor(vapiState),
                  elevation: vapiState.isCallActive ? 4 : 0,
                  shadowColor: Colors.redAccent.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: (vapiState.isConnecting || vapiState.isCallEnded)
                    ? null
                    : () => vapiController.toggleCall(
                        userId,
                        ApiConfig.assistantKey,
                      ),
                child: ButtonContent(state: vapiState),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Color _getButtonColor(dynamic state) {
    if (state.isCallActive) return Colors.red.shade400;
    if (state.isCallEnded) return Colors.green.shade600;
    return const Color.fromARGB(221, 26, 26, 26);
  }
}
