import 'package:cloud_firestore/cloud_firestore.dart';

class UserStats {
  final int totalMinutes;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastActiveDate;

  UserStats({
    this.totalMinutes = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastActiveDate,
  });

  factory UserStats.fromMap(Map<String, dynamic> map) {
    return UserStats(
      totalMinutes: map['totalMinutes'] ?? 0,
      currentStreak: map['currentStreak'] ?? 0,
      longestStreak: map['longestStreak'] ?? 0,
      lastActiveDate: map['lastActiveDate'] != null
          ? (map['lastActiveDate'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalMinutes': totalMinutes,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lastActiveDate': lastActiveDate != null
          ? Timestamp.fromDate(lastActiveDate!)
          : null,
    };
  }
}
