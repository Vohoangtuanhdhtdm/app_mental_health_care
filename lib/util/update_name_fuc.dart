import 'package:app_mental_health_care/data/providers/auth/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> updateUserName(WidgetRef ref, String name) async {
  try {
    final repo = ref.read(authRepositoryProvider);
    await repo.updateUsername(username: name);
  } catch (e) {
    debugPrint("Lỗi cập nhật tên: $e");
  }
}

void showEditNameDialog(
  BuildContext context,
  WidgetRef ref,
  String currentName,
) {
  final TextEditingController nameController = TextEditingController(
    text: currentName,
  );

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Đổi tên hiển thị"),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            hintText: "Nhập tên mới",
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
            ),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Hủy", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              final newName = nameController.text.trim();
              if (newName.isNotEmpty) {
                updateUserName(ref, newName);
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Đã cập nhật tên thành công!")),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            child: const Text("Lưu", style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}
