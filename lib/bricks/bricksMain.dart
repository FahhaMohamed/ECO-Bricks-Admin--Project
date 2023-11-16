import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_bricks/Models/gallery.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class bricksMain extends StatefulWidget {

  final String xfeet;
  final String xname;
  final String xweight;
  final int xamount;
  final String docum;

  const bricksMain({required this.xname,required this.xfeet,required this.xweight,required this.xamount,required this.docum,super.key});

  @override
  State<bricksMain> createState() => _bricksMainState();
}

class _bricksMainState extends State<bricksMain> {

  CollectionReference? fileRef = FirebaseFirestore.instance.collection("Bricks");
  TextEditingController amountEditingController = TextEditingController();

  int value = 0;

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.xname),
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(onPressed: (){
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    content: SizedBox(
                      height:MediaQuery.of(context).size.height*0.4,
                      width: w,
                      child: GalleryScreen(title: widget.xname, collection: 'Bricks', docum: widget.docum,),
                    ),
                  );
                }
            );
            }, icon: Icon(Icons.image_outlined,size: 40,color: Colors.purple,))
        ],
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: const Offset(2, 5),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 35),
                  Text("Per Sq.ft",style: const TextStyle(color: Colors.black,fontSize: 19),),
                  const Expanded(child: SizedBox()),
                  Text(widget.xfeet,style: const TextStyle(color: Colors.black,fontSize: 19),),
                  const SizedBox(width: 35),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: const Offset(2, 5),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 35),
                  Text("Dry Weight",style: const TextStyle(color: Colors.black,fontSize: 19),),
                  const Expanded(child: SizedBox()),
                  Text(widget.xweight,style: const TextStyle(color: Colors.black,fontSize: 19),),
                  const SizedBox(width: 35),
                ],
              ),
            ),
            GestureDetector(
              onDoubleTap: (){
                amountEditingController.text = widget.xamount.toString();
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context){
                      return GestureDetector(
                        onTap: ()=> FocusScope.of(context).unfocus(),
                        child: AlertDialog(
                          backgroundColor: Colors.white,
                          title: Row(
                            children: [
                              Icon(Icons.drive_file_rename_outline,color: Colors.purple,size: 30,),
                              SizedBox(width: 10,),
                              Text("Reset",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                ),
                              ),
                            ],
                          ),
                          content: Container(
                            padding: EdgeInsets.only(left: 20 ,bottom: 2),
                            width: MediaQuery.of(context).size.width*0.8,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                              boxShadow:[
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  offset: const Offset(10, 10),
                                  blurRadius: 20,
                                )
                              ],
                            ),

                            child:TextFormField(
                              controller: amountEditingController,
                              textCapitalization: TextCapitalization.sentences,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                color: Colors.black,
                                decorationColor: Colors.pinkAccent.withOpacity(0.05),
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.7,
                              ),
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text("Cancel",style: TextStyle(color: Colors.white,fontSize: 18),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey
                              ),
                            ),
                            ElevatedButton(
                              onPressed: (){
                                if(amountEditingController.text.isEmpty)
                                {
                                  Fluttertoast.showToast(msg: 'Please fill the field');
                                  return;
                                }
                                else
                                {
                                  fileRef!.doc(widget.docum).update({
                                    'amount' : int.tryParse(amountEditingController.text),
                                  });
                                }
                                Navigator.pop(context);
                              },
                              child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 18),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple
                              ),
                            ),
                          ],
                          actionsAlignment: MainAxisAlignment.spaceAround,
                        ),
                      );
                    }
                );
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                height: 40,
                width: w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      offset: const Offset(2, 5),
                      blurRadius: 5,
                    ),
                  ],
                  gradient: const LinearGradient(
                      colors: [
                        Colors.deepPurple,
                        Colors.purple,
                      ]
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 35),
                    Text("Available",style: const TextStyle(color: Colors.white,fontSize: 19),),
                    const Expanded(child: SizedBox()),
                    Text("${widget.xamount}",style: const TextStyle(color: Colors.white,fontSize: 19),),
                    const SizedBox(width: 35),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
