import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:workmanager/workmanager.dart';
import './fullSteamVideo.dart';

class StreamBuilderCamera extends StatefulWidget {
  StreamBuilderCamera({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;

  @override
  _StreamBuilderCameraState createState() => _StreamBuilderCameraState();
}

class _StreamBuilderCameraState extends State<StreamBuilderCamera> {
  bool _isPlaying = true;

  late VlcPlayerController _videoPlayerController;

  Future<void> initializePlayer() async {
    _videoPlayerController = VlcPlayerController.network(
      widget.url,
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
    VlcMediaEventType.buffering;
  }

  void main() {
    WidgetsFlutterBinding.ensureInitialized();
    Workmanager().initialize(initializePlayer);
  }

  @override
  void initState() {
    super.initState();
    initializePlayer();
    _videoPlayerController = VlcPlayerController.network(
      widget.url,
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
    VlcMediaEventType.buffering;

    Workmanager().registerPeriodicTask('uniqueName', 'taskName',
        frequency: Duration(hours: 1));
  }

  @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController.stopRendererScanning();
    await _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned.fill(
            child: VlcPlayer(
              controller: _videoPlayerController,
              aspectRatio: 16 / 9,
              // aspectRatio: _videoPlayerController.value.aspectRatio,
              placeholder: Center(child: CircularProgressIndicator()),
            ),
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {},
                          child: const Icon(
                            Icons.fast_rewind,
                            size: 16,
                            color: Colors.white,
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            if (_isPlaying) {
                              setState(() {
                                _isPlaying = false;
                              });
                              _videoPlayerController.pause();
                            } else {
                              setState(() {
                                _isPlaying = true;
                              });
                              _videoPlayerController.play();
                            }
                          },
                          child: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                            size: 16,
                            color: Colors.white,
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {},
                          child: const Icon(
                            Icons.fast_forward,
                            size: 16,
                            color: Colors.white,
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return VideoScreen(
                                url: widget.url,
                              );
                            }));
                          },
                          child: const Icon(
                            Icons.fullscreen,
                            size: 16,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
