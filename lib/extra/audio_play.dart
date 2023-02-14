
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlay extends StatefulWidget {
  const AudioPlay({Key? key}) : super(key: key);

  @override
  State<AudioPlay> createState() => _AudioPlayState();
}

class _AudioPlayState extends State<AudioPlay> {


  final player = AudioPlayer();
  bool isPlaying=false;
 Duration position=Duration.zero;  // changing time o slider
 Duration duration=Duration.zero;  // total time


  @override
  void initState() {
    super.initState();
    sound();
  }

  sound() async {
   var totalTime= await player.setAsset('assets/audio/sample.mp3');
   duration= player.duration!;  // total duration time
  // setState(() {});
   player.positionStream.listen((event) {
     if(event!=null){
       Duration temp=event as Duration;
       position=temp;
     setState(() {});
     }
   });

  }

  playerAction(){
    if(isPlaying){
      player.pause();
      isPlaying=false;
    }else{
      player.play();
      isPlaying=true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Play Audio in Flutter App"),
            backgroundColor: Colors.redAccent
        ),
        body: Column(
          children: [
           Slider(
               min: 0,
               max: duration.inSeconds.toDouble(),
               value:position.inSeconds.toDouble() ,
               onChanged: (value){
                 final seekPos=Duration(seconds: value.toInt());
                 player.seek(seekPos);
                 setState(() {});
               }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Text(formatTime(position)),
                  IconButton(
                    iconSize: 30,
                      onPressed: (){
                        playerAction();
                      },
                      icon: isPlaying ? Icon(Icons.pause):Icon(Icons.play_arrow)),
                  Text(formatTime(duration)),

                ],
              ),
            )

          ],
        )
    );
  }

  String formatTime(Duration value){

    String twoDigits(int n)=>n.toString().padLeft(2,'0');
    final hours=twoDigits(value.inHours);
    final min=twoDigits(value.inMinutes.remainder(60));
    final sec=twoDigits(value.inSeconds.remainder(60));

      return [  if(value.inHours>0)hours,min,sec
        ].join(':');



  }
}
