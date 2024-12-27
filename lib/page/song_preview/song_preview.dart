import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:itune_test_app/component/network_image.dart';
import 'package:itune_test_app/model/music.dart';
import 'package:itune_test_app/theme/font_style.dart';
import 'package:itune_test_app/utils/valuenotifier_compose.dart';
import 'package:just_audio/just_audio.dart';

class TriggerSongPreview {
  final Music music;

  TriggerSongPreview({required this.music});

  void display(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (context) {
        try {
          return SongPreview(music: music);
        } catch (e) {
          return SongPreviewFatal();
        }
      },
    );
  }
}

class SongPreview extends StatefulWidget {
  final Music music;
  const SongPreview({super.key, required this.music});

  @override
  State<SongPreview> createState() => _SongPreviewState();
}

class _SongPreviewState extends State<SongPreview> {
  late AudioPlayer _audioPlayer;
  final ValueNotifier<bool> _isPlaying = ValueNotifier(false);
  final ValueNotifier<Duration> _songPosition = ValueNotifier(Duration.zero);
  final ValueNotifier<Duration> _durationPosition = ValueNotifier(Duration.zero);

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _loadAudio();
    _audioPlayer.positionStream.listen((position) {
      _songPosition.value = position;
    });
    _audioPlayer.durationStream.listen((duration) {
      _durationPosition.value = duration ?? Duration.zero;
    });
  }

  Future<void> _loadAudio() async {
    try {
      await _audioPlayer.setUrl(widget.music.previewUrl!);
    } catch (e) {
      context.pop();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPause() {
    if (_isPlaying.value == true) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    setState(() {
      _isPlaying.value = !_isPlaying.value;
    });
  }

  Widget _songInfoBuilder() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black12,
      ),
      child: Column(
        children: [
          Text(widget.music.trackName ?? "不詳", style: AppText.jfR18White),
          Text(widget.music.collectionName ?? "不詳", style: AppText.jfR14White),
        ],
      ),
    );
  }

  Widget _songDurationBuilder() {
    return ValueListenableComposter<Duration, Duration>(
      first: _songPosition,
      second: _durationPosition,
      builder: (BuildContext context, Duration position, Duration duration, Widget? child) {
        return Container(
          color: Colors.black12,
          child: Column(
            children: [
              Slider(
                value: position.inSeconds.toDouble(),
                min: 0.0,
                max: duration.inSeconds.toDouble(),
                onChanged: (value) {
                  final newPosition = Duration(seconds: value.toInt());
                  _audioPlayer.seek(newPosition);
                },
              ),
              Text(
                "${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')} / "
                "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}",
                style: AppText.jfR14White,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pop();
      },
      child: Container(
        width: 250,
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: Stack(
                children: [
                  CachedImage(imageUrl: widget.music.getImageUrl),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _songInfoBuilder(),
                      _songDurationBuilder(),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: _playPause,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
                    child: ValueListenableBuilder(
                      valueListenable: _isPlaying,
                      builder: (BuildContext context, bool value, Widget? child) {
                        if (value == true) {
                          return Icon(
                            (Icons.stop),
                            color: Colors.black,
                            size: 30,
                          );
                        } else {
                          return Icon(
                            (Icons.play_arrow),
                            color: Colors.black,
                            size: 30,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SongPreviewFatal extends StatelessWidget {
  const SongPreviewFatal({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}
