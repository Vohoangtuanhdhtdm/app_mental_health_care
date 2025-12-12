import 'package:app_mental_health_care/app/features/home/widgets/container_widget.dart';
import 'package:app_mental_health_care/app/features/home/widgets/time_line.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    this.isActive = false,
    this.isLast = false,
    this.imageUrl,
    required this.audioUrl,
  });

  final String id;
  final String title;
  final String description;
  final String duration;
  final bool isActive;
  final bool isLast;
  final String? imageUrl;
  final String audioUrl;

  @override
  Widget build(BuildContext context) {
    return TimelineItem(
      isActive: isActive,
      isLast: isLast,
      child: ContainerWidget(
        id: id,
        title: title,
        description: description,
        duration: duration,
        imageUrl: imageUrl,
        audioUrl: audioUrl,
      ),
    );
  }
}
