import 'dart:async';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'app_config.dart';
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
      foregroundColor: Colors.red,
      backgroundColor: Colors.black,
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
   return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50,),
            Text('Flutter Demo Home Page ${widget.appConfig?.appName}'),
            Text('Flutter Demo Home Page ${widget.appConfig?.appName}'),
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

          ],
        ),
      ),
    );
  }
}
