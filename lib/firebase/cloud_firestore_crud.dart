import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:january_2023/firebase/user_data_model.dart';
import 'dart:io';
import 'package:path/path.dart';

class FBStore extends StatefulWidget {
  const FBStore({Key? key}) : super(key: key);

  @override
  State<FBStore> createState() => _FBStoreState();
}

class _FBStoreState extends State<FBStore> {
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController email = TextEditingController();
  final docUser = FirebaseFirestore.instance.collection('users').doc();
  File? imageFile;
  String? imageUrl;
  BuildContext? context1;


  Future imgFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        uploadFile();
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (imageFile == null) return;
    final fileName = basename(imageFile!.path);
    final destination = 'files/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref().child('usersImages/').child(destination);
      await ref.putFile(imageFile!);
      imageUrl= await ref.getDownloadURL();

      setState((){
      });
    } catch (e) {
      debugPrint('error occured');
    }
  }



  /*Future<List<Map<String, dynamic>>> _loadImages() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await FirebaseStorage.instance.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
        "description":
        fileMeta.customMetadata?['description'] ?? 'No description'
      });
    });

    return files;
  }*/

  @override
  Widget build(BuildContext context) {
    context1=context;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
              const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                imgFromGallery();
              },
              child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.grey,
                      ),
                      child: (imageFile != null)
                          ? ClipOval(
                          child: Image.file(
                            File(imageFile!.path),
                            fit: BoxFit.cover,
                          )) :
                        const Padding(
                        padding:
                         EdgeInsets.all(
                            35.0),
                        child: Icon(Icons.camera_alt,size: 20,),
                      )


                  ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: name,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Your name"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: age,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Your age"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: email,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Your email"),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  final user = UserData(
                      name: name.text,
                      email: email.text,
                      age: age.text = '20',
                     profilePicUrl: imageUrl
                  );
                  createUser(user);
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 5),
                    //horizontal: 20,vertical: 15
                    foregroundColor: Colors.red,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0))),
                child: const Text(
                  "Send Details",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                //height: 50,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding:
                const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                decoration: const BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: const Text(
                    "Users List from doc---Delete the item onLongPress"),
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 2,
                child: StreamBuilder<List<UserData>>(
                    stream: readData(),

                    builder: (context,  snapshot) { //(context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
                      if (snapshot.hasData) {
                        final users = snapshot.data;
                        return users == null
                            ? Center(child: Text("No users "))
                            : ListView(
                          children: users.map(dataList).toList() ?? [],
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Something went wrong"));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              )
              ],
            ),
          ),
        ),
      ),
    );
  }


  // widget to to show the data o ui
  Widget dataList(UserData user) {
    return GestureDetector(
      onLongPress: () {
        debugPrint("helllo");
        deleteProduct(user);
      },
      child: Container(
        margin:
        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: Colors.orange,
        child: ListTile(
          title: Text("${user.name }""---${user.age??20 }"  ?? ''),
          subtitle: Text(user.email ?? ''),
          leading:Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: Colors.black,
            ),
            child:ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: user.profilePicUrl!=null?Image.network(user.profilePicUrl ?? 'assets/images/dummyProfilePic.png',fit: BoxFit.fill,):
              Image.asset('assets/images/dummyProfilePic.png'),
            )
            ,
          ),
          trailing: ElevatedButton(
            onPressed: () {
              _update(user);
            },
            child: const Icon(
                Icons.edit
            ),
          ),
        ),
      ),
    );
  }


  // creating or addigng the usersss
  Future createUser(UserData user) async {
    user.id = docUser.id;
    final json = user.toJson();
    await docUser.set(json);
    name.clear();
    email.clear();
    age.clear();
  }


  //to get the list of usersss
  Stream<List<UserData>> readData() =>
      FirebaseFirestore.instance
          .collection('users')
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => UserData.fromJson(doc.data())).toList());


  // for updating the itemsss
  Future<void> _update(UserData user,) async {

    if (docUser != null) {
      name.text = user.name ?? '';
      age.text = user.age ?? '';
      email.text = user.email ?? '';
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context1!,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery
                    .of(ctx)
                    .viewInsets
                    .bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: name,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: age,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                  ),
                ),
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String namee = name.text;
                    final String agee = age.text;
                    final String emaill = email.text;

                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(user.id).update(
                        {"name": namee, "age": agee, "email": emaill});
                    Navigator.of(context1!).pop();
                  },
                )
              ],
            ),
          );
        });
  }

//for deleeting the item
  Future<void> deleteProduct(UserData user) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.id)
        .delete();
  }

}
