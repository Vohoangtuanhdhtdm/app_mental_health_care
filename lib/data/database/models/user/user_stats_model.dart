import 'package:cloud_firestore/cloud_firestore.dart';

class UserStats {
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastActiveDate;

  UserStats({
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastActiveDate,
  });

  factory UserStats.fromMap(Map<String, dynamic> map) {
    return UserStats(
      currentStreak: map['currentStreak'] ?? 0,
      longestStreak: map['longestStreak'] ?? 0,
      lastActiveDate: map['lastActiveDate'] != null
          ? (map['lastActiveDate'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lastActiveDate': lastActiveDate != null
          ? Timestamp.fromDate(lastActiveDate!)
          : null,
    };
  }
}
