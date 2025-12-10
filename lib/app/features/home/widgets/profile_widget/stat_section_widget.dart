import 'package:app_mental_health_care/app/features/home/widgets/profile_widget/stat_widget.dart';
import 'package:app_mental_health_care/data/database/models/user/user_stats_model.dart';
import 'package:flutter/material.dart';

Widget buildStatsSection(UserStats stats) {
  return Row(
    children: [
      Expanded(
        child: buildStatCard(
          title: "Chuỗi ngày",
          value: "${stats.currentStreak}",
          unit: "ngày",
          icon: Icons.local_fire_department_rounded,
          color: Colors.orange,
          bgColor: Colors.orange.shade50,
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: buildStatCard(
          title: "Tổng thời gian",
          value: "${stats.totalMinutes}",
          unit: "phút",
          icon: Icons.timer_rounded,
          color: Colors.teal,
          bgColor: Colors.teal.shade50,
        ),
      ),
    ],
  );
}
