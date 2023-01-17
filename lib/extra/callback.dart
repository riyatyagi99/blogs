
import 'package:flutter/material.dart';

import '../logs/logs.dart';

class CallbackFun extends StatefulWidget {
  const CallbackFun({Key? key}) : super(key: key);

  @override
  State<CallbackFun> createState() => _CallbackFunState();
}

class _CallbackFunState extends State<CallbackFun> {
  final log = logger(CallbackFun);

  String topic="Packages";
  callback(varTopic){
    setState(() {
      topic=varTopic;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.maxFinite,
            height: 70,
            margin: const EdgeInsets.only(top:50,left: 40,right: 40, bottom: 20),
            decoration: BoxDecoration(
                color:Colors.lightBlue,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Center(
              child: Text(
                "We are learning Flutter "+topic,
                style: TextStyle(
                    fontSize: 20,
                    color:Colors.white
                ),
              ),
            ),
          ),
          MyButtons(topic: "Cubit", callbackFunction:callback),
          MyButtons(topic: "BLoc", callbackFunction:callback),
          MyButtons(topic: "GetX", callbackFunction:callback),
          buildButton('DEBUG', Colors.blue, () => log.d('Debug message')),
          buildButton('INFO', Colors.blue, () => log.i('Info message')),
          buildButton('WARNING', Colors.orange, () => log.w('Warning message')),
          buildButton('ERROR', Colors.red, () => log.e('Error message')),
          buildButton('WTF', Colors.red, () => log.wtf('Wtf message')),
        ],
      ),
    ),
  );

  Widget buildButton(
      String text,
      Color color,
      VoidCallback onClicked,
      ) =>
      Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: ElevatedButton(
          child: Text(text),
          onPressed: onClicked,
        ),
      );
}


class MyButtons extends StatelessWidget {
  final String topic;
  final Function callbackFunction;
  const MyButtons({Key? key, required this.topic, required this.callbackFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: (){
          callbackFunction(topic);
        },
        child: Container(
          width: double.maxFinite,
          height: 70,
          margin: const EdgeInsets.only(top:20,left: 40,right: 40, bottom: 20),
          decoration: BoxDecoration(
              color:Colors.lightBlue,
              borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: Text(
              topic,
              style: const TextStyle(
                  fontSize: 20,
                  color:Colors.white
              ),
            ),
          ),
        ),
      );
  }
}