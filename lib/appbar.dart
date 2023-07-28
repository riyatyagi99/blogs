import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FlutterAppbar extends StatefulWidget {
  const FlutterAppbar({Key? key}) : super(key: key);

  @override
  State<FlutterAppbar> createState() => _FlutterAppbarState();
}

class _FlutterAppbarState extends State<FlutterAppbar> with SingleTickerProviderStateMixin{
  TabController? tabController;
  final email=TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar
          (
          title: const Text("Flutter Appbar"),
          //centerTitle:true ,
          backgroundColor: Colors.yellow.withOpacity(0.9),
          automaticallyImplyLeading: true,
          leading: Icon(Icons.arrow_back),

          actions: const[
            Icon(Icons.phone),
            Icon(Icons.email),
            Icon(Icons.mic),
          ],
          primary:true ,



          toolbarHeight: 50,
          foregroundColor: Colors.black,
            elevation: 5,
          shape: const RoundedRectangleBorder(

              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.0),
                  topLeft: Radius.circular(25.0)
              )
          ),
          shadowColor:Colors.black38 ,
        titleSpacing:30 ,
        bottom:TabBar(
          controller:tabController ,
          tabs: const[
            Icon(Icons.home,color: Colors.black,size: 30,),
            Icon(Icons.settings,color: Colors.black),
            Icon(Icons.person,color: Colors.black),
        ],

        ) ,
        bottomOpacity:0.5 ,
        titleTextStyle: TextStyle(fontSize: 25,color: Colors.black) ,
        toolbarOpacity:0.8 ,
        leadingWidth: 5,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
             Form(
               child: SizedBox(
                 width: 150,
                 height: 30,
                 child: TextFormField(
                  controller: email,
                   validator: (email) {
                     if (email != null &&
                         !EmailValidator.validate(
                             email)) {
                       return 'Enter a valid Email';
                     } else {
                       return null;
                     }
                   },
                 ),
               ),
             ),
              const SizedBox(height: 20,),

              ElevatedButton(onPressed: (){
               Fluttertoast.showToast(msg : "Hello", );
              }, child: const Text("click")),

              const Text("Hello",style: TextStyle(fontSize: 30,color: Colors.purple),)
            ],
          ),
        )
    );
  }
}
