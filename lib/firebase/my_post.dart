import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'add_post.dart';
import 'details.dart';

class PostsPage extends StatefulWidget {
  PostsPage({Key? key}) : super(key: key);
  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {

  late CollectionReference _referencePosts;
  late Future<QuerySnapshot>_future;
  @override
  Widget build(BuildContext context) {
    _referencePosts=FirebaseFirestore.instance.collection('posts');
    _future=_referencePosts.get();
    return Scaffold(
      appBar: AppBar(title: Text('Posts'),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddPost())).then((value){
            if(value==true){
              setState((){});
            }
          });
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future:_future,
        builder: (context,snapshot){
          if(snapshot.hasError)
          {
            return Center(child: Text('Error:${snapshot.error}'));
          }

          if(snapshot.hasData)
          {
            QuerySnapshot data=snapshot.data!;
            List<QueryDocumentSnapshot> documents=data.docs;
            List<Map> items=documents.map((e) => {
              'id':e.id,
              'title':e['title']}).toList();

            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context,index){
                  Map thisItem=items[index];
                  return ListTile(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Detail(thisItem)));
                    },
                    title: Text(thisItem['title']),);
                });
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}