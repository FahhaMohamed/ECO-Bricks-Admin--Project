import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Models/gallery.dart';


class wallTilesMain extends StatefulWidget {

  final int xmoulds;
  final String xfeet;
  final String xname;
  final String xweight;
  final String docum;
  const wallTilesMain({required this.xname,required this.xmoulds,required this.xfeet,required this.xweight,required this.docum,super.key});

  @override
  State<wallTilesMain> createState() => _wallTilesMainState();
}

class _wallTilesMainState extends State<wallTilesMain> {

  CollectionReference? fileRef = FirebaseFirestore.instance.collection("Wall tiles");

  int value = 0;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController amountEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    value = widget.xmoulds;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.xname),
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
                      child: GalleryScreen(title: widget.xname, collection: 'Wall tiles', docum: widget.docum,),
                    ),
                  );
                }
            );
          }, icon: Icon(Icons.image_outlined,size: 40,color: Colors.purple,))
        ],
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios)),
      ),
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: (){
                  textEditingController.text = widget.xmoulds.toString();
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context){
                        return GestureDetector(
                          onTap: ()=> FocusScope.of(context).unfocus(),
                          child: AlertDialog(
                            backgroundColor: Colors.white,
                            content: Container(
                              width: 40,
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
                                controller: textEditingController,
                                textCapitalization: TextCapitalization.sentences,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
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
                                child: Icon(Icons.close,color: Colors.white,),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey
                                ),
                              ),
                              ElevatedButton(
                                onPressed: (){
                                  if(textEditingController.text.isEmpty)
                                  {
                                    Fluttertoast.showToast(msg: 'Please fill the field');
                                    return;
                                  }
                                  else
                                  {
                                    setState(() {
                                      value = int.tryParse(textEditingController.text)!;
                                    });
                                    fileRef!.doc(widget.docum).update({
                                      'moulds' : value
                                    });
                                  }

                                  Navigator.pop(context);

                                },
                                child: Icon(Icons.done,color: Colors.white,),
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
                  height: 50,
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
                      Text('Moulds',style: const TextStyle(color: Colors.black,fontSize: 19),),
                      Expanded(child: SizedBox()),
                      Text("$value",style: const TextStyle(color: Colors.black,fontSize: 20),),
                      const SizedBox(width: 35),
                    ],
                  ),
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
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder(
                    stream: fileRef!.doc(widget.docum).collection('colors').snapshots(),
                    builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                      if(snapshot.hasData){
                        return ListView.builder(
                            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context,i){
                              QueryDocumentSnapshot y = snapshot.data!.docs[i];
                              return GestureDetector(
                                onDoubleTap: (){
                                  textEditingController.text = y['color'];
                                  amountEditingController.text = y['amount'].toString();
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
                                            content: SizedBox(
                                              height: 90,
                                              child: Column(
                                                children: [
                                                  Container(
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
                                                      controller: textEditingController,
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
                                                  SizedBox(height: 10,),
                                                  Container(
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
                                                      keyboardType: TextInputType.number,
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
                                                ],
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
                                                  if(textEditingController.text.isEmpty || amountEditingController.text.isEmpty)
                                                  {
                                                    Fluttertoast.showToast(msg: 'Please fill the field');
                                                    return;
                                                  }
                                                  else
                                                  {
                                                    fileRef!.doc(widget.docum).collection('colors').doc(y['color']).update({
                                                      'color' : textEditingController.text,
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
                                onLongPress: (){
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
                                              child: Text("Are you sure to delete?",
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
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                  fileRef!.doc(widget.docum).collection('colors').doc(y['color']).delete();
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
                                  margin: const EdgeInsets.all(8),
                                  height: 40,
                                  width: 6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(
                                        colors: [
                                          Colors.deepPurple,
                                          Colors.purple,
                                        ]
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black45,
                                        offset: const Offset(2, 5),
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child:Row(
                                    children: [
                                      const SizedBox(width: 35),
                                      Text(y['color'],style: const TextStyle(color: Colors.white,fontSize: 19),),
                                      const Expanded(child: SizedBox()),
                                      Text("${y['amount']}",style: const TextStyle(color: Colors.white,fontSize: 19),),
                                      const SizedBox(width: 35),
                                    ],
                                  ),
                                ),
                              );

                            });

                      }
                      return const Center(
                        child:CircularProgressIndicator(
                          color: Colors.purple,
                        ) ,
                      );
                    }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
