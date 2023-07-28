import 'package:flutter/material.dart';

import 'appbar.dart';
import 'common_appbar.dart';

class DropdownExample extends StatefulWidget {
  const DropdownExample({Key? key}) : super(key: key);

  @override
  State<DropdownExample> createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        toolbarHeight: 50,
        appBar: AppBar(),
        title: const Text("Custom Appbar"),
        centreTitle: false,
        bgColor: Colors.black38,
        actions: const [
          Icon(Icons.person)
        ],
      ),
      body: SizedBox(

        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>FlutterAppbar()));
                },
                child: Text("Hello",style: TextStyle(fontSize: 30,color: Colors.red),))
          ],
        ),
      )
    );
  }
}
