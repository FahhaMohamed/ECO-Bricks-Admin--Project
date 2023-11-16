import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_bricks/Models/galleryView.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

import '../Utils/utils.dart';

class GalleryScreen extends StatefulWidget {

  final String title;
  final String collection;
  final String docum;

  const GalleryScreen({required this.title,required this.collection,required this.docum,super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {


  List imagePaths = [
    'assets/pavers/ishape_product_image.png',
    'assets/pavers/beeHive.webp',
    'assets/pavers/bigTryArc.png',
  ];

  int currentIndex = 0;

  String url = "";


  @override
  Widget build(BuildContext context) {

    CollectionReference? fileRef = FirebaseFirestore.instance.collection(widget.collection);

    void pickImage(String doc) async {
      Uint8List img = await uploadImage();
      String order = DateTime.now().millisecondsSinceEpoch.toString();
      ProgressDialog progressDialog = ProgressDialog(context, title: null, message: Text("Uploading..."));
      progressDialog.show();
      //upload to Firebase storage
      Reference reference = await FirebaseStorage.instance.ref().child(order);
      UploadTask task = reference.putData(img);
      TaskSnapshot snapshot = await task;
      url = await snapshot.ref.getDownloadURL();

      await fileRef.doc(doc).collection('Images').doc(order).set({
        'Url' : url,
        'order' : order,
      });
      progressDialog.dismiss();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.title),
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(
            onPressed: () => pickImage(widget.docum),
            icon: Icon(Icons.add_circle,size: 30,color: Colors.purple,))
        ],
      ),
      backgroundColor: Colors.transparent,
      body: StreamBuilder(
        stream: fileRef.doc(widget.docum).collection('Images').snapshots(),
        builder: (context , AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData){
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context,index){
                QueryDocumentSnapshot x = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      currentIndex = index;
                    });
                    showDialog(context: context, builder: (context){
                      return GalleryView(imagePath: snapshot.data!.docs, index: currentIndex,);
                    });
                  },
                  onLongPress: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Row(
                              children: [
                                Icon(Icons.delete,color: Colors.purple,size: 30,),
                                SizedBox(width: 5,),
                                Text("Delete",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19,
                                  ),
                                ),
                              ],
                            ),
                            content: SizedBox(
                              height: 25,
                              child: Center(
                                child: Text("Are you sure to delete the Image?",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            actions: [
                              IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close,color: Colors.grey,size: 30,)),
                              IconButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    await fileRef.doc(widget.docum).collection('Images').doc("${snapshot.data!.docs[index]['order']}").delete();
                                    await FirebaseStorage.instance.ref().child('${snapshot.data!.docs[index]['file id']}').delete();
                                  },
                                  icon: Icon(Icons.done,color: Colors.purple,size: 30,)
                              )
                            ],
                            actionsAlignment: MainAxisAlignment.spaceAround,
                          );
                        }
                    );

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(image: NetworkImage(x['Url']),fit: BoxFit.cover),
                    ),
                  ),
                );
              },
              itemCount: snapshot.data!.docs.length,
            );
          }
          else{
            return Center(
              child: const CircularProgressIndicator(
                color: Colors.purple,
              ),
            );
          }
        },
      )
    );
  }
}
