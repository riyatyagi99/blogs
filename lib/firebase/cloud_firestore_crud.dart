import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:january_2023/firebase/user_data_model.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: name,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Your name"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: age,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Your age"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: email,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Your email"),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    final user = UserData(
                        name: name.text,
                        email: email.text,
                        age: age.text ='20');
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
                SizedBox(
                  height: 10,
                ),
                Container(
                  //height: 50,
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  decoration: const BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  child: const Text("Users List from doc"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/2,
                  child: StreamBuilder<List<UserData>>(
                      stream: readData(),
                      builder: (context, snapshot) {   //(context, AsyncSnapshot<QuerySnapshot> streamSnapshot)
                        if (snapshot.hasData) {
                          final users = snapshot.data;
                          return users==null?Center(child: Text("No users ")):ListView(
                            children: users.map(dataList).toList() ?? [],
                          );
                        } else if(snapshot.hasError){
                          return Center(child: Text("Something went wrong"));
                        }else {
                          return CircularProgressIndicator();
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

  Widget dataList(UserData user){
    return Container(
      margin:
      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Colors.orange,
      child: ListTile(
        title: Text(user.name??''),
        subtitle: Text(user.email ??''),
        leading:Text(user.age ??'20'),
        trailing: ElevatedButton(
          onPressed: () {
            _update(user);
          },
          child: const Icon(
          Icons.edit
          ),
        ),
      ),
    );
  }

  Future createUser(UserData user) async {
    user.id = docUser.id;
    final json = user.toJson();
    await docUser.set(json);
    name.clear();
    email.clear();
    age.clear();
  }

  Stream<List<UserData>> readData() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => UserData.fromJson(doc.data())).toList());


  Future<void> _update(UserData user) async {
    if (docUser != null) {

      name.text = user.name??'';
      age.text = user.age??'';
      email.text = user.email??'';
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
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
                  child: const Text( 'Update'),
                  onPressed: () async {
                    final String namee = name.text;
                    final String agee = age.text;
                    final String emaill = email.text;

                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(user.id).update({"name": namee, "age": agee,"email":emaill});
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });
  }



}
