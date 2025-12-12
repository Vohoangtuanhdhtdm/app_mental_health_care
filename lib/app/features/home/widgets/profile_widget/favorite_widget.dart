import 'package:app_mental_health_care/app/features/music/view/media_player_screen.dart';
import 'package:app_mental_health_care/data/database/models/content_model.dart';
import 'package:flutter/material.dart';

Widget buildFavoriteItem(BuildContext context, ContentModel content) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.08),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: ListTile(
      contentPadding: const EdgeInsets.all(10),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          content.imageUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              Container(color: Colors.grey.shade200, width: 60, height: 60),
        ),
      ),
      title: Text(
        content.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(content.author, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(
        Icons.play_circle_fill,
        color: Colors.teal,
        size: 32,
      ),
      onTap: () {
        // Phát nhạc khi bấm vào
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MediaPlayerScreen(
              id: content.id,
              title: content.title,
              description: content.description,
              imageUrl: content.imageUrl,
              audioUrl: content.audioUrl,
            ),
          ),
        );
      },
    ),
  );
}
