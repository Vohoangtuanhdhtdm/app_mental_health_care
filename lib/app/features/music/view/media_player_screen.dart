import 'package:app_mental_health_care/data/providers/user/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

class MediaPlayerScreen extends ConsumerStatefulWidget {
  const MediaPlayerScreen({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.audioUrl,
  });

  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final String audioUrl;

  @override
  ConsumerState<MediaPlayerScreen> createState() => _MediaPlayerScreenState();
}

class _MediaPlayerScreenState extends ConsumerState<MediaPlayerScreen> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    _audioPlayer = AudioPlayer();
    _initAudio();
    super.initState();

    // Gọi khi vào màn hình để tính chuỗi ngày
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userControllerProvider).markActivity();
      debugPrint("Đã đánh dấu hoạt động cho ngày hôm nay!");
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _initAudio() async {
    try {
      await _audioPlayer.setUrl(widget.audioUrl);
      _audioPlayer.play(); // Tự động phát
    } catch (e) {
      debugPrint("Lỗi load nhạc: $e");
    }
  }

  // Hàm format thời gian (65 giây -> 01:05)
  String _formatDuration(Duration? duration) {
    if (duration == null) return "--:--";
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          userAsync.when(
            data: (user) {
              if (user == null) return const SizedBox();
              final isLiked = user.favorites.contains(widget.id);
              return IconButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.black,
                  size: 28,
                ),
                onPressed: () {
                  ref
                      .read(userControllerProvider)
                      .toggleFavorite(widget.id, user.favorites);
                },
              );
            },
            loading: () => const SizedBox(),
            error: (_, __) => const SizedBox(),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            Expanded(
              flex: 5,
              child: Hero(
                tag: widget.title,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    image: widget.imageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(widget.imageUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            StreamBuilder(
              stream: _audioPlayer.positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                final duration = _audioPlayer.duration ?? Duration.zero;
                return Column(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 4,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 6,
                        ),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 14,
                        ),
                        activeTrackColor: Colors.teal,
                        inactiveTrackColor: Colors.teal.shade100,
                        thumbColor: Colors.teal,
                      ),
                      child: Slider(
                        min: 0,
                        max: duration.inSeconds.toDouble(),
                        value: position.inSeconds.toDouble().clamp(
                          0,
                          duration.inSeconds.toDouble(),
                        ),
                        onChanged: (value) {
                          _audioPlayer.seek(Duration(seconds: value.toInt()));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(position),
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                          Text(
                            _formatDuration(duration),
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 20),

            StreamBuilder(
              stream: _audioPlayer.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final processingState = playerState?.processingState;
                final playing = playerState?.playing;

                if (processingState == ProcessingState.loading ||
                    processingState == ProcessingState.buffering) {
                  return const CircularProgressIndicator(color: Colors.teal);
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shuffle, color: Colors.grey),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.replay_10_rounded, size: 32),
                      onPressed: () {
                        // Tua lại 10s
                        _audioPlayer.seek(
                          _audioPlayer.position - const Duration(seconds: 10),
                        );
                      },
                    ),

                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal.withOpacity(0.4),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          (playing == true)
                              ? Icons.pause
                              : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          if (playing == true) {
                            _audioPlayer.pause();
                          } else {
                            _audioPlayer.play();
                          }
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.forward_10_rounded,
                        size: 32,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        // Tua tới 10s
                        _audioPlayer.seek(
                          _audioPlayer.position + const Duration(seconds: 10),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.repeat, color: Colors.grey),
                      onPressed: () {},
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
