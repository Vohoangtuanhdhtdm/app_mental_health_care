import 'package:flutter/material.dart';

class TestProfile extends StatelessWidget {
  const TestProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),

          // 1. Avatar đơn giản, không viền cầu kỳ
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              'https://i.pinimg.com/736x/2a/72/9e/2a729ec22988b2a284a7fdf37f1847fd.jpg',
            ),
            backgroundColor: Colors.grey,
          ),

          const SizedBox(height: 16),

          const Text(
            "Võ Hoàng Tuấn",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text("hoangtuan@email.com", style: TextStyle(fontSize: 14)),

          const SizedBox(height: 32),

          const SizedBox(height: 32),
          const Divider(height: 1),

          _buildMinimalListTile(
            icon: Icons.person_outline,
            title: "Cập nhật thông tin ",
          ),
          _buildMinimalListTile(icon: Icons.book, title: "Nhật ký của tôi"),

          _buildMinimalListTile(
            icon: Icons.lock_outline,
            title: "Đổi mật khẩu",
          ),

          const SizedBox(height: 20),

          TextButton(
            onPressed: () {},
            child: Text("Đăng xuất", style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }

  Widget _buildMinimalListTile({
    required IconData icon,
    required String title,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 4,
          ),
          leading: Icon(icon, size: 22),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          trailing: const Icon(Icons.chevron_right, size: 18),
          onTap: () {},
        ),
        const Divider(height: 1, indent: 24, endIndent: 24),
      ],
    );
  }
}
