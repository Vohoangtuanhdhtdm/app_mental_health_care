import 'package:app_mental_health_care/app/features/music/view/media_player_screen.dart';
import 'package:app_mental_health_care/data/constants.dart';
import 'package:app_mental_health_care/data/providers/user/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContainerWidget extends ConsumerWidget {
  const ContainerWidget({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    this.imageUrl,
    required this.audioUrl,
  });

  final String id;
  final String title;
  final String description;
  final String duration;
  final String? imageUrl;
  final String audioUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        // Điều hướng sang màn hình Player
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MediaPlayerScreen(
              id: id,
              title: title,
              description: description,
              audioUrl: audioUrl,
              imageUrl:
                  imageUrl ??
                  "https://i.pinimg.com/736x/47/c5/0f/47c50f916191cea017c4582e140d493f.jpg", // Ảnh mặc định nếu null
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20), // Bo góc toàn bộ thẻ
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1), // Đổ bóng nhẹ nhàng
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Modal Bottom Sheet
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,

                            style: KTextStyle.titleTealText,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            _showMoreOption(context, ref);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Text(
                      description,
                      style: KTextStyle.descriptionText,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 14,
                          color: Colors.teal,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          duration,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.teal,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),
              //Media
              Hero(
                tag: title,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.teal.shade50,
                    image: imageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(imageUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: imageUrl == null
                      ? const Icon(
                          Icons.play_circle_fill,
                          color: Colors.teal,
                          size: 40,
                        )
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMoreOption(BuildContext context, WidgetRef ref) {
    final userAsync = ref.read(currentUserProvider);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 180, // Tăng chiều cao một chút
          child: userAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Center(child: Text("Lỗi: $e")),
            data: (user) {
              if (user == null) {
                return const Center(child: Text("Vui lòng đăng nhập"));
              }

              // Kiểm tra xem bài này đã được thích chưa
              final isLiked = user.favorites.contains(id);

              return Column(
                children: [
                  // Nút Yêu Thích
                  ListTile(
                    leading: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.grey,
                    ),
                    title: Text(
                      isLiked
                          ? "Bỏ khỏi danh sách yêu thích"
                          : "Lưu vào danh sách yêu thích",
                      style: TextStyle(
                        color: isLiked ? Colors.red : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () async {
                      // Đóng modal trước cho mượt
                      Navigator.pop(context);

                      // Gọi hàm toggleFavorite từ Controller
                      await ref
                          .read(userControllerProvider)
                          .toggleFavorite(id, user.favorites);

                      // Hiện thông báo
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isLiked
                                  ? "Đã xóa khỏi yêu thích"
                                  : "Đã thêm vào yêu thích",
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      }
                    },
                  ),
                  // Có thể thêm nút khác ví dụ: Share
                  ListTile(
                    leading: const Icon(Icons.share, color: Colors.blue),
                    title: const Text("Chia sẻ"),
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: Implement share functionality
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
