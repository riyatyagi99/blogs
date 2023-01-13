import 'package:flutter/material.dart';

import 'app_config.dart';
import 'extra/blink_text.dart';
import 'extra/callback.dart';
import 'extra/render_html.dart';
import 'extra/search_with_tf.dart';

class AllPackagesList extends StatefulWidget {
  AppConfig? appConfig;
   AllPackagesList({Key? key,this.appConfig}) : super(key: key);

  @override
  State<AllPackagesList> createState() => _AllPackagesListState();
}

class _AllPackagesListState extends State<AllPackagesList> {


  ButtonStyle style = ElevatedButton.styleFrom(
      padding:  const EdgeInsets.symmetric(horizontal: 50 ,vertical: 5),//horizontal: 20,vertical: 15
      foregroundColor: Colors.red,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0))
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

          ],
        ),
      ),
    );
  }
}
