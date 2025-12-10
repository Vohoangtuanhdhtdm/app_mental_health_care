import 'package:app_mental_health_care/data/database/models/user/user_model.dart';
import 'package:app_mental_health_care/util/update_name_fuc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget buildProfileHeader(BuildContext context, WidgetRef ref, UserModel user) {
  return Row(
    children: [
      CircleAvatar(
        radius: 40,
        backgroundColor: Colors.teal.shade100,
        backgroundImage: user.photoUrl.isNotEmpty
            ? NetworkImage(user.photoUrl)
            : null,
        child: user.photoUrl.isEmpty
            ? Text(
                user.name.isNotEmpty ? user.name[0].toUpperCase() : "U",
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
      ),
      const SizedBox(width: 20),
      Expanded(
        // Dùng Expanded để tránh lỗi tràn màn hình nếu tên quá dài
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row chứa Tên và Nút Edit
            Row(
              children: [
                Flexible(
                  child: Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis, // Cắt bớt nếu tên quá dài
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 20, color: Colors.teal),
                  tooltip: "Chỉnh sửa tên",
                  onPressed: () {
                    showEditNameDialog(context, ref, user.name);
                  },
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "Hội viên miễn phí",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    ],
  );
}
