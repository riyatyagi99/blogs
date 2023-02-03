import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class PlayingVideo extends StatefulWidget {
  const PlayingVideo({Key? key}) : super(key: key);

  @override
  State<PlayingVideo> createState() => _PlayingVideoState();
}

class _PlayingVideoState extends State<PlayingVideo> {
  late VideoPlayerController _controller;
   Future<void>? initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
      callVideoPlay();
  }


  callVideoPlay() {
    debugPrint("Is it there 22");

    initializeVideoPlayerFuture = _controller.initialize();
    debugPrint("Is it there ${initializeVideoPlayerFuture}");

    setState(() {

    });
    _controller.setLooping(true);

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          _controller.value.isInitialized
              ? FutureBuilder(
             future:initializeVideoPlayerFuture ,
                builder: (_,  snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    debugPrint("Is it there");
                    return  Center(
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: Stack(
                            children: [
                              VideoPlayer(_controller),
                              Center(
                                child: FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      _controller.value.isPlaying
                                          ? _controller.pause()
                                          : _controller.play();
                                    });
                                  },
                                  child: Icon(
                                    _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: VideoProgressIndicator(
                                  _controller,
                                  allowScrubbing: true,
                                  colors: const VideoProgressColors(
                                      backgroundColor: Colors.red,
                                      bufferedColor: Colors.black,
                                      playedColor: Colors.blueAccent),
                                ),
                              )

                            ]
                        ),
                      ),
                    );
                  } else if(snapshot.hasError){
                    return const Center(
                      child: Text("there is some errror"),
                    );
                  }else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                },

              )
              : Container(),

            ElevatedButton(
                onPressed: () async{
                  Uri url =Uri.parse('https://medium.flutterdevs.com/explore-open-urls-in-flutter-4b6273884f13') ;
                  if (!await canLaunchUrl(url)) {
                  await launchUrl(url,  );
                  }
                  else {
                  throw 'Could not launch $url';
                  }
                },
                child: const Text('Open this',style: TextStyle(fontSize: 20),)
            ),

          Linkify(
            onOpen: (link)  {
              print("Linkify link = ${link.url}");
            },
            text: "Linkify click -  https://www.youtube.com/channel/UCwxiHP2Ryd-aR0SWKjYguxw",
            style: TextStyle(color: Colors.blue),
            linkStyle: TextStyle(color: Colors.green),
          ),
        ],
      ),
    );
  }
}
