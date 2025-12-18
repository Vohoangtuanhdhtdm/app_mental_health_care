import 'package:flutter/material.dart';

class FullTimelineModal extends StatelessWidget {
  const FullTimelineModal({super.key, required this.timeline});

  final List<dynamic> timeline;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children: [
            // Thanh kéo nhỏ
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Tiêu đề Modal
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 10, 24, 20),
              child: Row(
                children: const [
                  Text(
                    "Lịch trình chi tiết",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // List Scroll
            Expanded(
              child: ListView.builder(
                controller: controller,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 0,
                ),
                itemCount: timeline.length,
                itemBuilder: (context, index) {
                  final item = timeline[index];
                  // Logic màu sắc
                  Color baseColor = Colors.grey;
                  IconData icon = Icons.circle;

                  if (item['type'] == 'focus_block') {
                    baseColor = Colors.orange;
                    icon = Icons.bolt;
                  }
                  if (item['type'] == 'physical_block') {
                    baseColor = Colors.blue;
                    icon = Icons.fitness_center;
                  }
                  if (item['type'] == 'recharge_block') {
                    baseColor = Colors.green;
                    icon = Icons.spa;
                  }
                  if (item['type'] == 'nutrition_block') {
                    baseColor = Colors.teal;
                    icon = Icons.restaurant;
                  }

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Cột thời gian
                        SizedBox(
                          width: 50,
                          child: Column(
                            children: [
                              Text(
                                item['time_range']
                                    .toString()
                                    .split('-')[0]
                                    .trim(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.grey[800],
                                ),
                              ),
                              if (index != timeline.length - 1)
                                Container(
                                  width: 2,
                                  height: 40,
                                  margin: const EdgeInsets.only(top: 8),
                                  color: Colors.grey[200],
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Nội dung Card
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: baseColor.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(icon, size: 16, color: baseColor),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        item['activity'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (item['note'] != null &&
                                    item['note'].toString().isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(
                                      item['note'],
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[700],
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
