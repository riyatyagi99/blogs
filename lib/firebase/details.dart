import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  Map data;
  Detail(this.data,{Key? key}) : super(key: key);
  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  TextEditingController commentController=TextEditingController();
  DocumentReference? documentReference;
   CollectionReference? referenceComments;
  Stream<QuerySnapshot>? _streamSnapshot;


  @override
  Widget build(BuildContext context) {
    documentReference=FirebaseFirestore.instance.collection('posts').doc(widget.data['id']);
    referenceComments= documentReference?.collection('comments');
    _streamSnapshot=referenceComments?.orderBy('postedOn',descending: true).snapshots();

    return Scaffold(appBar: AppBar(
      title: Text('Details'),
    ),
        floatingActionButton: FloatingActionButton(onPressed: () {
            final mediaQuery=MediaQuery.of(context);
          showModalBottomSheet(
            isScrollControlled: true,
            context: context, builder: (BuildContext context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height/2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: commentController,
                    ),
                    ElevatedButton(onPressed: (){

                      Map<String, dynamic> commentToAdd={
                        "comment_text":commentController.text,
                        "postedOn":FieldValue.serverTimestamp()
                      };

                      referenceComments?.add(commentToAdd);

                      Navigator.of(context).pop();
                      commentController.clear();

                    }, child: const Text('Submit'))
                  ],
                ),
              ),
            );
          }, );

        },
          child: Icon(Icons.send),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                color: Colors.black12,
                padding: EdgeInsets.all(18),
                child: Text(widget.data['title'])),

            Expanded(
              child:commentsList()

            ),
          ],
        )
    );
  }

  commentsList(){
    return StreamBuilder<QuerySnapshot>(
      stream:_streamSnapshot ,
      builder: (context,snapshot){
        if(snapshot.hasData){
          QuerySnapshot? snap=snapshot.data;
          List<QueryDocumentSnapshot>? docSnap=snap?.docs;
          List<Map>? items=docSnap?.map((e) => {
            "id":e.id,
            "comment_text":e['comment_text']
          }).toList();


        return ListView.builder(
            itemCount: items?.length,
            itemBuilder: (context,index){
              Map? itemList=items?[index];
              return  ListTile(title: Text(itemList?['comment_text']),);
            });
        }else if(snapshot.hasError){
          return Center(child: Text("There is some error"),);
        }else {
          return Center(child: CircularProgressIndicator(),);
        }
      },

    );
  }
}