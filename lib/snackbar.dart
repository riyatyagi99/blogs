import 'package:blog/app_utils.dart';
import 'package:flutter/material.dart';

class SnackbarDemo extends StatefulWidget {
  const SnackbarDemo({Key? key}) : super(key: key);

  @override
  State<SnackbarDemo> createState() => _SnackbarDemoState();
}

class _SnackbarDemoState extends State<SnackbarDemo> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: const Text("Snackbar Demo")) ,
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: ElevatedButton(
            onPressed: (){

              ScaffoldMessenger.of(context).
              showSnackBar( SnackBar(
                  content: const Text("Learn and enjoy!",style: TextStyle(color: Colors.red),),
                  duration: const Duration(seconds: 5),
                  backgroundColor:Colors.lime ,

                  shape:const RoundedRectangleBorder( // StadiumBorder()
                   side: BorderSide(
                     color: Colors.red,
                     width: 2,
                   ),
                  ) ,
                  behavior: SnackBarBehavior.floating,
               // width: double.infinity,
                elevation: 5,
                dismissDirection: DismissDirection.up,
                action: SnackBarAction(label: "Undo", onPressed: (){}),
              ));

            },
            child: Text("Click to see Snackbar"),
          ),),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          AppUtils.showSnackBar("Snackbar from Utils class");
        },
      )
    );
  }
}
