import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  CollectionReference _reference=FirebaseFirestore.instance.collection('posts');
  TextEditingController _controllerPost=TextEditingController();
  bool showLoader=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Post'),
        ),
        body: Column(
          children: [
            TextFormField(
              controller: _controllerPost,
            ),
            showLoader?CircularProgressIndicator():
            ElevatedButton(onPressed: ()
            async{
              Map<String,String> _dataToAdd={
                'title': _controllerPost.text
              };

              setState((){
                showLoader=true;
              });

             await _reference.add(_dataToAdd);

              setState((){
                showLoader=false;
              });
              Navigator.of(context).pop(true);
            }, child: Text('Save'))
          ],
        )
    );
  }
}