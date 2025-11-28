import 'package:app_mental_health_care/data/constants.dart';
import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({
    super.key,
    required this.title,
    required this.description,
    required this.duration, // Thêm tham số thời lượng
    this.imageUrl, // Thêm tham số hình ảnh (nếu có)
  });

  final String title;
  final String description;
  final String duration;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // Bo góc toàn bộ thẻ
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1), // Đổ bóng nhẹ nhàng
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Modal Bottom Sheet
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,

                          style: KTextStyle.titleTealText,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          // TODO: Hiện BottomSheet hoặc Drawer "Lưu vào yêu thích" tại đây
                          _showMoreOption(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
                          child: Icon(
                            Icons.more_vert,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    description,
                    style: KTextStyle.descriptionText,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: Colors.teal,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        duration,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.teal,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 16),
            //Media
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.teal.shade50,
                image: imageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(imageUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: imageUrl == null
                  ? const Icon(
                      Icons.play_circle_fill,
                      color: Colors.teal,
                      size: 40,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // Modal Bottom Sheet Function
  void _showMoreOption(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 150,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.favorite_border, color: Colors.red),
                title: const Text("Lưu vào danh sách yêu thích"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
