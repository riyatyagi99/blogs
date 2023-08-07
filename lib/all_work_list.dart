import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:january_2023/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'animations/curved_animations.dart';
import 'app_config.dart';
import 'extra/audio_play.dart';
import 'extra/blink_text.dart';
import 'extra/callback.dart';
import 'extra/render_html.dart';
import 'extra/search_with_tf.dart';
import 'extra/video_play.dart';
import 'firebase/cloud_firestore_crud.dart';
import 'firebase/my_post.dart';
import 'firebase/remote_config.dart';
import 'get_set_methods.dart';

class AllPackagesList extends StatefulWidget {
  AppConfig? appConfig;
   AllPackagesList({Key? key,this.appConfig}) : super(key: key);

  @override
  State<AllPackagesList> createState() => _AllPackagesListState();
}

class _AllPackagesListState extends State<AllPackagesList> {

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    getConnectivity();
    getSetMethods();

  }

  getSetMethods() {
    var rectangle = Rectangle(12,6);
    print(rectangle.area);
    rectangle.center = Point(4,4);
    print(rectangle.center);
  }

  void _captureScreenShot() async{
    //get paint bound of your app screen or the widget which is wrapped with RepaintBoundary.
    RenderRepaintBoundary bound = _key.currentContext?.findRenderObject() as RenderRepaintBoundary;
    if(bound.debugNeedsPaint){
      Timer(const Duration(seconds: 1),()=>_captureScreenShot());
      return null;
    }
    ui.Image image = await bound.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    // this will save image screenshot in gallery
    if(byteData != null ){
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final resultsave = await ImageGallerySaver.saveImage(Uint8List.fromList(pngBytes),quality: 90,name: 'screenshot-${DateTime.now()}');
      print(resultsave);
    }
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
            (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  ButtonStyle style = ElevatedButton.styleFrom(
      padding:  const EdgeInsets.symmetric(horizontal: 50 ,vertical: 5),//horizontal: 20,vertical: 15
      foregroundColor: Colors.white,
      backgroundColor: Colors.grey,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0))
  );

  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('No Connection'),
      content: const Text('Please check your internet connectivity'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');
            setState(() => isAlertSet = false);
            isDeviceConnected =
            await InternetConnectionChecker().hasConnection;
            if (!isDeviceConnected && isAlertSet == false) {
              showDialogBox();
              setState(() => isAlertSet = true);
            }
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );



  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return RepaintBoundary(
      key: _key,
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                const SizedBox(height: 50,),
                Text('Flutter Demo Home Page ${widget.appConfig?.appName}'),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Checkbox(
                        value: themeChange.darkTheme,
                        onChanged: (bool? value) {
                          themeChange.darkTheme = value??false;
                        }),
                    const Text(" Change your theme")
                  ],
                ),

                ElevatedButton(
                  onPressed:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchPage()));
                  },
                  style:style,
                  child:const Text("Search",),
                ) ,
                ElevatedButton(
                  onPressed:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BlinkText()));
                  },
                  style: style,
                  child:const Text("Blink Text",),
                ),

                ElevatedButton(
                  onPressed:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RenderHTML()));
                  },
                  style: style,
                  child:const Text("Render HTML",),
                ),
                ElevatedButton(
                  onPressed:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CallbackFun()));
                  },
                  style: style,
                  child:const Text("CallBack",),
                ),
                ElevatedButton(
                  onPressed:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RemoteConfigDemo()));
                  },
                  style: style,
                  child:const Text("F/B - remote Config",),
                ),
                ElevatedButton(
                  onPressed:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FBStore()));
                  },
                  style: style,
                  child:const Text("F/B - cloud fireStore",),
                ),
                ElevatedButton(
                  onPressed:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PostsPage()));
                  },
                  style: style,
                  child:const Text("F/B - cloud fireStore-nested",),
                ),
                ElevatedButton(
                  onPressed:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PlayingVideo()));
                  },
                  style: style,
                  child:const Text("Video Play",),
                ),
                ElevatedButton(
                  onPressed:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AudioPlay()));
                  },
                  style: style,
                  child:const Text("AudioPlay",),
                ),
                ElevatedButton(
                  onPressed:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const CurvedAnimationss()));
                  },
                  style: style,
                  child:const Text("CurvedAnimationss",),
                ),
                Image.asset('assets/images/dummyProfilePic.png')

              ],
            ),
          ),
        ),
        floatingActionButton:FloatingActionButton(

          onPressed: () {
            _captureScreenShot();
          },
          child: Text("Click"),

        ) ,
      ),
    );
  }
}
