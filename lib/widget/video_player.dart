import 'dart:io';

import 'package:app/theme/app_theme.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  VideoPlayerPage({Key key, this.videoLink}) : super(key: key);

  final String videoLink;

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.videoLink)
      ..initialize().then((value) => setState(() {}));
    // await Future.wait([
    //   _videoPlayerController.initialize(),
    // ]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: _videoPlayerController.value.aspectRatio,
      autoPlay: true,
      looping: false,
      showControls: true,
      materialProgressColors: ChewieProgressColors(
          //   playedColor: Theme.of(context).primaryColor,
          //   handleColor: Theme.of(context).primaryColor,
          //   backgroundColor: Colors.grey,
          //   bufferedColor: Colors.grey,
          ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      autoInitialize: true,
    );
    setState(() {});
  }

  @override
  void initState() {
    print(widget.videoLink);
    initializePlayer();
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Normal player page"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: _chewieController != null &&
                      _chewieController.videoPlayerController.value.initialized
                  ? Chewie(
                      controller: _chewieController,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text('Loading'),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChewieDemo extends StatefulWidget {
  const ChewieDemo({
    Key key,
    this.title = 'Chewie Demo',
  }) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  ChewieController _chewieController;
  int bufferDelay;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  List<String> srcs = [
    "https://www.youtube.com/watch?v=-Plvt5HGv9U",
    "https://www.youtube.com/shorts/jTxzJvGHw50",
    "https://www.youtube.com/shorts/jTxzJvGHw50"
  ];

  Future<void> initializePlayer() async {
    _videoPlayerController1 =
        VideoPlayerController.network(srcs[currPlayIndex]);
    _videoPlayerController2 =
        VideoPlayerController.network(srcs[currPlayIndex]);
    await Future.wait([
      _videoPlayerController1.initialize(),
      _videoPlayerController2.initialize(),
    ]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    // final subtitles = [
    //     Subtitle(
    //       index: 0,
    //       start: Duration.zero,
    //       end: const Duration(seconds: 10),
    //       text: 'Hello from subtitles',
    //     ),
    //     Subtitle(
    //       index: 0,
    //       start: const Duration(seconds: 10),
    //       end: const Duration(seconds: 20),
    //       text: 'Whats up? :)',
    //     ),
    //   ];

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: true,

      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      autoInitialize: true,
    );
  }

  int currPlayIndex = 0;

  Future<void> toggleVideo() async {
    await _videoPlayerController1.pause();
    currPlayIndex += 1;
    if (currPlayIndex >= srcs.length) {
      currPlayIndex = 0;
    }
    await initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: AppTheme.lightTheme.copyWith(
        platform: _platform ?? Theme.of(context).platform,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: _chewieController != null &&
                        _chewieController
                            .videoPlayerController.value.initialized
                    ? Chewie(
                        controller: _chewieController,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(height: 20),
                          Text('Loading'),
                        ],
                      ),
              ),
            ),
            TextButton(
              onPressed: () {
                _chewieController?.enterFullScreen();
              },
              child: const Text('Fullscreen'),
            ),
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //       child: TextButton(
            //         onPressed: () {
            //           setState(() {
            //             _videoPlayerController1.pause();
            //             _videoPlayerController1.seekTo(Duration.zero);
            //             _createChewieController();
            //           });
            //         },
            //         child: const Padding(
            //           padding: EdgeInsets.symmetric(vertical: 16.0),
            //           child: Text("Landscape Video"),
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       child: TextButton(
            //         onPressed: () {
            //           setState(() {
            //             _videoPlayerController2.pause();
            //             _videoPlayerController2.seekTo(Duration.zero);
            //             _chewieController = ChewieController(
            //               videoPlayerController: _videoPlayerController2,
            //               autoPlay: true,
            //               looping: true,
            //               /* subtitle: Subtitles([
            //                 Subtitle(
            //                   index: 0,
            //                   start: Duration.zero,
            //                   end: const Duration(seconds: 10),
            //                   text: 'Hello from subtitles',
            //                 ),
            //                 Subtitle(
            //                   index: 0,
            //                   start: const Duration(seconds: 10),
            //                   end: const Duration(seconds: 20),
            //                   text: 'Whats up? :)',
            //                 ),
            //               ]),
            //               subtitleBuilder: (context, subtitle) => Container(
            //                 padding: const EdgeInsets.all(10.0),
            //                 child: Text(
            //                   subtitle,
            //                   style: const TextStyle(color: Colors.white),
            //                 ),
            //               ), */
            //             );
            //           });
            //         },
            //         child: const Padding(
            //           padding: EdgeInsets.symmetric(vertical: 16.0),
            //           child: Text("Portrait Video"),
            //         ),
            //       ),
            //     )
            //   ],
            // ),
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //       child: TextButton(
            //         onPressed: () {
            //           setState(() {
            //             _platform = TargetPlatform.android;
            //           });
            //         },
            //         child: const Padding(
            //           padding: EdgeInsets.symmetric(vertical: 16.0),
            //           child: Text("Android controls"),
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       child: TextButton(
            //         onPressed: () {
            //           setState(() {
            //             _platform = TargetPlatform.iOS;
            //           });
            //         },
            //         child: const Padding(
            //           padding: EdgeInsets.symmetric(vertical: 16.0),
            //           child: Text("iOS controls"),
            //         ),
            //       ),
            //     )
            //   ],
            // ),
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //       child: TextButton(
            //         onPressed: () {
            //           setState(() {
            //             _platform = TargetPlatform.windows;
            //           });
            //         },
            //         child: const Padding(
            //           padding: EdgeInsets.symmetric(vertical: 16.0),
            //           child: Text("Desktop controls"),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // if (Platform.isAndroid)
            //   ListTile(
            //     title: const Text("Delay"),
            //     subtitle: DelaySlider(
            //       delay:
            //           _chewieController?.progressIndicatorDelay?.inMilliseconds,
            //       onSave: (delay) async {
            //         if (delay != null) {
            //           bufferDelay = delay == 0 ? null : delay;
            //           await initializePlayer();
            //         }
            //       },
            //     ),
            //   )
          ],
        ),
      ),
    );
  }
}

class DelaySlider extends StatefulWidget {
  const DelaySlider({Key key, this.delay, this.onSave}) : super(key: key);

  final int delay;
  final void Function(int) onSave;
  @override
  State<DelaySlider> createState() => _DelaySliderState();
}

class _DelaySliderState extends State<DelaySlider> {
  int delay;
  bool saved = false;

  @override
  void initState() {
    super.initState();
    delay = widget.delay;
  }

  @override
  Widget build(BuildContext context) {
    const int max = 1000;
    return ListTile(
      title: Text(
        "Progress indicator delay ${delay != null ? "${delay.toString()} MS" : ""}",
      ),
      subtitle: Slider(
        value: delay != null ? (delay / max) : 0,
        onChanged: (value) async {
          delay = (value * max).toInt();
          setState(() {
            saved = false;
          });
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.save),
        onPressed: saved
            ? null
            : () {
                widget.onSave(delay);
                setState(() {
                  saved = true;
                });
              },
      ),
    );
  }
}
