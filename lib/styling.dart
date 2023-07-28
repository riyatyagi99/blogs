import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';


class StylingWidgets extends StatefulWidget {
  const StylingWidgets({Key? key}) : super(key: key);

  @override
  State<StylingWidgets> createState() => _StylingWidgetsState();
}

class _StylingWidgetsState extends State<StylingWidgets> with TickerProviderStateMixin {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Styling widgets"),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.network(
                        "https://i.kym-cdn.com/entries/icons/facebook/000/013/564/doge.jpg",
                        width: 200,
                        height: 200,
                      ),
                      Positioned.fill(
                        child: Center(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 2.0,
                              sigmaY: 3.0,
                            ),
                            child: Container(
                              color: Colors.black.withOpacity(0.1),

                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 5.0),
                  child:Image.network(
                    "https://i.kym-cdn.com/entries/icons/facebook/000/013/564/doge.jpg",
                    width: 200,
                    height: 200,
                  ),
                ),
                SizedBox(height: 50,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.red, Colors.blue],
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.center,
                          radius: 0.5,
                          colors: [Colors.yellow, Colors.black],
                        ),
                      ),
                    ),

                    Container(   height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        gradient: SweepGradient(
                          center: Alignment.center,
                          startAngle: 0.0,
                          endAngle: 2 * pi,
                          colors: [Colors.teal, Colors.yellow],
                        ),
                      ),
                    ),



                  ],
                )
                ,

              ],
            ),
          ),
        ),
      ),
    );
  }
}


