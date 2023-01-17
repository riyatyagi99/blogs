

import 'dart:async';

import 'package:flutter/material.dart';

class BlinkText extends StatefulWidget {
  const BlinkText({Key? key}) : super(key: key);

  @override
  State<BlinkText> createState() => _BlinkTextState();
}

class _BlinkTextState extends State<BlinkText> {
  bool _show = true;
  Timer? _timer;
  TextEditingController check=TextEditingController();

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      setState(() => _show = !_show);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text("Hello Riya",
              style: _show
                  ? const TextStyle(fontSize: 50, fontWeight: FontWeight.bold)
                  : const TextStyle(color: Colors.transparent)),
        ),
         const SizedBox(height: 20,),

        const Text("Auto sizing effect"),
        TextField(
          minLines: 1,
          maxLines: 10,
          controller:check ,
          decoration: const InputDecoration(
            border: OutlineInputBorder()
          ),
        ),

        const Text("trying some git features on IDE"),

      ],
    ),
  );

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


}
