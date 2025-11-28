import 'package:app_mental_health_care/app/widgets/container_widget.dart';
import 'package:app_mental_health_care/app/widgets/time_line.dart';
import 'package:flutter/material.dart';

class TestHome extends StatelessWidget {
  const TestHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        // Thêm padding tổng thể cho toàn màn hình để nội dung không dính sát mép
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- PHẦN 1: HEADER CHÀO HỎI ---
            const Text(
              "Xin chào,",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Text(
              "Võ Hoàng Tuấn!",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.teal, // Màu điểm nhấn
              ),
            ),

            const SizedBox(height: 30), // Khoảng cách lớn
            // --- PHẦN 2: BUỔI SÁNG ---
            _buildSectionTitle("Start Your Day", Icons.wb_sunny_outlined),

            _buildTaskItem(
              isActive: true,
              title: 'Welcome to Test Home',
              description: 'This is the description for the Test Home page.',
              duration: "5min",
              imageUrl:
                  "https://i.pinimg.com/736x/40/a8/2c/40a82c9175f6cd4cee52b415a1251f5d.jpg",
            ),

            _buildTaskItem(
              isActive: false,
              isLast: true, // Ngắt dòng kẻ tại đây để phân biệt sáng/tối
              title: 'Meditation Practice',
              description: 'Focus on your breath and relax.',
              duration: "10min",
            ),

            const SizedBox(height: 20), // Khoảng cách giữa 2 buổi
            // --- PHẦN 3: BUỔI TỐI ---
            _buildSectionTitle("Tonight Meditation", Icons.nightlight_round),

            _buildTaskItem(
              isActive: true,
              title: 'Relaxing Music',
              description: 'Deep sleep sounds.',
              duration: "30min",
            ),
            _buildTaskItem(
              isActive: true,
              title: 'Sleep Story',
              description: 'A story about the forest.',
              duration: "20min",
            ),
            _buildTaskItem(
              isActive: true,
              isLast: true, // Item cuối cùng của danh sách
              title: 'Breathing for Sleep',
              description: '4-7-8 Breathing technique.',
              duration: "10min",
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET CON: TIÊU ĐỀ SECTION ---
  Widget _buildSectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange, size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // --- HÀM TẠO ITEM ĐỂ TRÁNH LẶP CODE ---
  Widget _buildTaskItem({
    required String title,
    required String description,
    required String duration,
    String? imageUrl,
    bool isActive = false,
    bool isLast = false,
  }) {
    return TimelineItem(
      isActive: isActive,
      isLast: isLast,
      child: ContainerWidget(
        title: title,
        description: description,
        duration: duration,
        imageUrl: imageUrl,
      ),
    );
  }
}
