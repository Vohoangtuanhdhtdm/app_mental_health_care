import 'package:app_mental_health_care/app/features/home/view/profile/widgets/create_plan_card.dart';
import 'package:app_mental_health_care/app/features/home/view/profile/widgets/plan_detail_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ApiPlanSection extends StatelessWidget {
  const ApiPlanSection({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tiêu đề section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Kế Hoạch Của Bạn",
              style: TextStyle(
                fontSize: 20, // Tăng kích thước tiêu đề
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5, // Kéo chữ lại gần nhau xíu cho hiện đại
                color: Colors.black87,
              ),
            ),
            // Nút refresh nhỏ gọn hơn
            IconButton(
              onPressed: () {
                /* Logic reload nếu cần */
              },
              icon: Icon(Icons.refresh, size: 20, color: Colors.grey[400]),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
        const SizedBox(height: 16), // Tăng khoảng cách giữa tiêu đề và card

        StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('user_protocols')
              .doc(userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return CreatePlanCard(userId: userId);
            }

            try {
              final data = snapshot.data!.data() as Map<String, dynamic>;
              final protocol = data['protocol'] as Map<String, dynamic>;
              return PlanDetailCard(protocol: protocol);
            } catch (e) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "Lỗi dữ liệu: $e",
                  style: TextStyle(color: Colors.red[800]),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
