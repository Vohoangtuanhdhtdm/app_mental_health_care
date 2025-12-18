import 'package:app_mental_health_care/app/features/generate_program/generate_program_page.dart';
import 'package:flutter/material.dart';

class CreatePlanCard extends StatelessWidget {
  const CreatePlanCard({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => GenerateProgramPage(userId: userId),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24), // Tăng padding bên trong
        decoration: BoxDecoration(
          // Gradient nhẹ nhàng hơn
          gradient: LinearGradient(
            colors: [const Color(0xFF4A90E2), const Color(0xFF007AFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28), // Bo góc tròn hơn
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF007AFF).withOpacity(0.25),
              blurRadius: 20,
              offset: const Offset(0, 8), // Shadow đổ xuống dưới nhiều hơn
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Thiết lập Giao thức",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "AI sẽ tối ưu hóa lịch trình cho riêng bạn.",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white70,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
