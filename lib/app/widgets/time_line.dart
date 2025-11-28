import 'package:flutter/material.dart';

class TimelineItem extends StatelessWidget {
  final Widget child;
  final bool isLast;
  final bool isActive;

  const TimelineItem({
    super.key,
    required this.child,
    this.isLast = false,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      // Quan trọng: Giúp đường kẻ cao bằng với nội dung
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CỘT TIMELINE BÊN TRÁI
          SizedBox(
            width: 40,
            child: Column(
              children: [
                // Chấm tròn
                Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.only(
                    top: 24,
                  ), // Căn chỉnh cho ngang hàng với Card
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.orange
                        : Colors.transparent, // Màu cam nếu active
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive ? Colors.orange : Colors.grey,
                      width: 2,
                    ),
                  ),
                ),
                // Đường kẻ (Nét đứt)
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: CustomPaint(
                        painter: DashedLinePainter(
                          // ignore: deprecated_member_use
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // NỘI DUNG BÊN PHẢI (ContainerWidget )
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

// Vẽ nét đứt
class DashedLinePainter extends CustomPainter {
  final Color color;
  DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
