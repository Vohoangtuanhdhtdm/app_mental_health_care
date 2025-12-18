import 'package:flutter/material.dart';

class ButtonContent extends StatelessWidget {
  const ButtonContent({super.key, required this.state});
  final dynamic state;

  @override
  Widget build(BuildContext context) {
    if (state.isConnecting) {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          ),
          SizedBox(width: 12),
          Text("Đang kết nối AI..."),
        ],
      );
    }
    if (state.isCallActive) {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.call_end, color: Colors.white),
          SizedBox(width: 8),
          Text("Kết thúc cuộc gọi"),
        ],
      );
    }
    if (state.isCallEnded) {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, color: Colors.white),
          SizedBox(width: 8),
          Text("Xem kết quả"),
        ],
      );
    }
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.mic, color: Colors.white),
        SizedBox(width: 8),
        Text("Bắt đầu trò chuyện"),
      ],
    );
  }
}
