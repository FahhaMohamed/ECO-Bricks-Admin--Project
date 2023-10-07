import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class zigzagPolishHome extends StatefulWidget {

  final String url;

  const zigzagPolishHome({required this.url,super.key});

  @override
  State<zigzagPolishHome> createState() => _zigzagPolishHomeState();
}

class _zigzagPolishHomeState extends State<zigzagPolishHome> {

  bool isTapped = true;
  bool isExpanded = false;

  CollectionReference? fileRef = FirebaseFirestore.instance.collection('Zig Zag Polish Pavers');

  @override
  void initState() {
    super.initState();
    fetchValue();
  }

  int value = 0;
  String name = 'Zig Zag Polish Pavers';

  CollectionReference? dataRef = FirebaseFirestore.instance.collection('pavers');

  fetchValue() async {

    var _value = await FirebaseFirestore.instance.collection('pavers').doc('Zig Zag Polish Pavers');

    _value.get().then((inter) {
      if(inter['value'] != null)
      {
        setState(() {
          value = inter['value'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            setState(() {
              isTapped = !isTapped;
            });
          },
          onHighlightChanged: (value) {
            setState(() {
              isExpanded = value;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.fastLinearToSlowEaseIn,
            height:
            isTapped ? isExpanded ? 60 : 70 : isExpanded ? 400 : 413,
            width:  w*0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: isTapped
                ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Zig Zag Polish',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w400),
                      ),
                      Icon(
                        isTapped
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        color: Colors.black,
                        size: 27,
                      ),
                    ],
                  ),
                ],
              ),
            )
                : SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Zig Zag Polish',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22,
                            fontWeight: FontWeight.w400),
                      ),
                      Icon(
                        isTapped
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        color: Colors.black,
                        size: 27,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      height: 50,
                      width: w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade100,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            offset: const Offset(2, 2),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Moulds',style: const TextStyle(color: Colors.black,fontSize: 19),),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: (){
                                    setState(() {
                                      value==0?null:--value;
                                    });
                                    dataRef!.doc(name).set({
                                      'value' : value,
                                    });
                                  },
                                  icon: Icon(Icons.remove_circle,size: 25,color: Colors.purple,)
                              ),
                              Text("$value",style: const TextStyle(color: Colors.black,fontSize: 20),),
                              IconButton(
                                  onPressed: (){
                                    setState(() {
                                      ++value;
                                    });
                                    dataRef!.doc(name).set({
                                      'value' : value,
                                    });
                                  },
                                  icon: Icon(Icons.add_circle,size: 25,color: Colors.purple,)
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 400,
                    child: StreamBuilder(
                        stream: fileRef!.snapshots(),
                        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                          if(snapshot.hasData){
                            return ListView.builder(
                                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context,i){
                                  QueryDocumentSnapshot x = snapshot.data!.docs[i];
                                  return Container(
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
                                          color: Colors.grey.shade300,
                                          offset: const Offset(2, 2),
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child:Row(
                                      children: [
                                        const SizedBox(width: 35),
                                        Text(x['color'],style: const TextStyle(color: Colors.white,fontSize: 19),),
                                        const Expanded(child: SizedBox()),
                                        Text("${x['amount']}",style: const TextStyle(color: Colors.white,fontSize: 19),),
                                        const SizedBox(width: 35),
                                      ],
                                    ),
                                  );

                                });

                          }
                          return const Center(
                            child:CircularProgressIndicator(

                            ) ,
                          );
                        }
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 70,
          width: 80,
          decoration:BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(image: AssetImage(widget.url),fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}
