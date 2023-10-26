import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class bricksMain extends StatefulWidget {

  final int xmoulds;
  final String xfeet;
  final String xname;
  final String xweight;
  final int xamount;
  final String docum;

  const bricksMain({required this.xname,required this.xmoulds,required this.xfeet,required this.xweight,required this.xamount,required this.docum,super.key});

  @override
  State<bricksMain> createState() => _bricksMainState();
}

class _bricksMainState extends State<bricksMain> {

  CollectionReference? fileRef = FirebaseFirestore.instance.collection("Bricks");

  int value = 0;

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.xname),
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
              Container(
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
                    Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              setState(() {
                                value = widget.xmoulds;

                                if(value != 0)
                                {
                                  value = widget.xmoulds -1 ;
                                }
                              });
                              fileRef!.doc(widget.docum).update({
                                'moulds' : value,
                              });
                            },
                            icon: Icon(Icons.remove_circle,size: 25,color: Colors.purple,)
                        ),
                        Text('${widget.xmoulds}',style: const TextStyle(color: Colors.black,fontSize: 20),),
                        IconButton(
                            onPressed: (){
                              setState(() {
                                ++value;
                              });
                              fileRef!.doc(widget.docum).update({
                                'moulds' : value,
                              });
                            },
                            icon: Icon(Icons.add_circle,size: 25,color: Colors.purple,)
                        ),
                      ],
                    ),
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
                    Text("Square ft",style: const TextStyle(color: Colors.black,fontSize: 19),),
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
                    Text("Weight",style: const TextStyle(color: Colors.black,fontSize: 19),),
                    const Expanded(child: SizedBox()),
                    Text(widget.xweight,style: const TextStyle(color: Colors.black,fontSize: 19),),
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
            ],
          ),
        ),
      ),
    );
  }
}
