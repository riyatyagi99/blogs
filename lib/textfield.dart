import 'package:flutter/material.dart';

class TextFieldDemo extends StatefulWidget {
  const TextFieldDemo({Key? key}) : super(key: key);

  @override
  State<TextFieldDemo> createState() => _TextFieldDemoState();
}

class _TextFieldDemoState extends State<TextFieldDemo> {

  TextEditingController textControllerOne=TextEditingController();
  TextEditingController textControllerTwo=TextEditingController();
  TextEditingController textControllerThree=TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    textControllerOne.dispose();
    textControllerTwo.dispose();
    textControllerThree.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("TextFields"),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                SizedBox(width: 300,
                    child: TextFormField(
                      controller: textControllerOne,
                      toolbarOptions: const ToolbarOptions(
                        copy: true,
                        paste: true,
                        cut: true,
                        selectAll: true
                      ),
                      decoration:  const InputDecoration(
                        labelText: "ToolbarOptions",
                        border:OutlineInputBorder() ,
                      ),
                    )
                ),

                SizedBox(height: 20,),
                TextField(
                  controller: textControllerTwo,
                  textInputAction: TextInputAction.search,
                  decoration:  const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                         width: 2,
                        color: Colors.teal
                      )
                    ),
                      border:OutlineInputBorder() ,
                   icon: Icon(Icons.person),
                    hintText: "Write your  name",
                    labelText: "With Icons & filled Colour",
                    labelStyle: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Icon(Icons.close),
                    fillColor: Colors.black12,
                    filled: true
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  enabled: false,
                  decoration:  const InputDecoration(
                    labelText: "Disabled",
                    border:OutlineInputBorder() ,
                  ),
                ),
                SizedBox(height: 20,),

                Form(
                  key: formKey,
                  child: TextFormField(
                    controller: textControllerThree,
                    decoration:  const InputDecoration(
                       labelText: "TextFormField",
                        border:OutlineInputBorder() ,
                    ),
                    validator: (value){
                       if(value!.isEmpty){
                         return 'Cannot be empty';
                       }else{
                         return null;
                       }
                    },
                  ),
                ),
                SizedBox(height: 50,),
                ElevatedButton(onPressed: (){
                  final isValid = formKey
                      .currentState!
                      .validate();
                  if (!isValid) return;
                }
                    , child: Text("Click Here"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
