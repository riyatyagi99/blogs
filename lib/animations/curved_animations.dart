import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class CurvedAnimationss extends StatefulWidget {
  const CurvedAnimationss({Key? key}) : super(key: key);

  @override
  State<CurvedAnimationss> createState() => _CurvedAnimationssState();
}

class _CurvedAnimationssState extends State<CurvedAnimationss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [

        const RiveAnimation.network(
          "assets/Rive/bg.riv",
        ),
      /*  Positioned.fill(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: const SizedBox(),
        )),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                SizedBox(
                  width: 260,
                  child: Column(
                    children: const [
                      Text(
                        "Learn design & code",
                        style: TextStyle(
                          fontSize: 60,
                          fontFamily: "Poppins",
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Don’t skip design. Learn design and code, by building real apps with Flutter. Complete courses about the best tools.",
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 2),
                GestureDetector(
                  onTap: () {
                    // TODO: Start the animation
                  },
                  child: SizedBox(
                    height: 64,
                    width: 260,
                    child: Stack(
                      children: [
                        const RiveAnimation.asset(
                          "assets/Rive/button.riv",
                          // TODO: Add Rive Controller
                        ),
                        Positioned.fill(
                          top: 8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(CupertinoIcons.arrow_right),
                              SizedBox(width: 8),
                              Text(
                                "Start the course",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    "Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates.",
                  ),
                ),
              ],
            ),
          ),
        ),*/
      ]),
    );
  }
}
