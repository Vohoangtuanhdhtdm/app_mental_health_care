import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.isAi, required this.content});

  final bool isAi;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          isAi ? Icons.smart_toy_outlined : Icons.person_outline,
          size: 16,
          color: isAi ? Colors.blue : Colors.grey,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isAi ? "Tuan AI" : "Bạn",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: isAi ? Colors.blue : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(content, style: const TextStyle(fontSize: 14, height: 1.4)),
            ],
          ),
        ),
      ],
    );
  }
}
