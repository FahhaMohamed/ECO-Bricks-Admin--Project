
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class bricksAdd extends StatefulWidget {


  const bricksAdd({super.key});

  @override
  State<bricksAdd> createState() => _bricksAddState();
}

class _bricksAddState extends State<bricksAdd> {

  CollectionReference? fileRef = FirebaseFirestore.instance.collection('Bricks');
  TextEditingController textEditingController = TextEditingController();
  int initialAmount = 0;

  bool isTapped = true;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;

    return InkWell(
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
        isTapped ? isExpanded ? 60 : 70 : isExpanded ? 200 : 213,
        width:  w*0.7,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple,
              Colors.grey.shade100,
            ]
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.shade200,
              blurRadius: 20,
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
                    'Bricks',
                    style: TextStyle(
                        color: Colors.white,
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
                    'Bricks',
                    style: TextStyle(
                        color: Colors.white,
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
              SizedBox(
                height: 170,
                width: double.maxFinite,
                child: StreamBuilder(
                    stream: fileRef!.snapshots(),
                    builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                      if(snapshot.hasData){
                        return ListView.builder(
                            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context,i){
                              QueryDocumentSnapshot x = snapshot.data!.docs[i];
                              return GestureDetector(
                                onTap: (){
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          title: const Text("Please enter the amount",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                          ),
                                          content: SizedBox(
                                            height: 90,
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 2),
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

                                                  child:TextField(
                                                    controller: textEditingController,
                                                    keyboardType: TextInputType.number,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      decorationColor: Colors.pinkAccent.withOpacity(0.05),
                                                      fontSize: 17,
                                                      fontWeight: FontWeight.w400,
                                                      letterSpacing: 0.7,
                                                    ),
                                                    cursorColor: Colors.black,
                                                    decoration: const InputDecoration(
                                                      hintText: ' Amount',
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                                const Expanded(child: SizedBox()),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    TextButton(onPressed: (){Navigator.pop(context);}, child: const Text("Cancel",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20),)),
                                                    TextButton(
                                                        onPressed: () async {
                                                          Navigator.pop(context);
                                                          if(x['amount'] == null)
                                                          {
                                                            setState(() {
                                                              initialAmount = 0;
                                                            });
                                                          }
                                                          else
                                                          {
                                                            setState(() {
                                                              initialAmount = x['amount'];
                                                            });
                                                          }
                                                          String amount = textEditingController.text.trim();
                                                          initialAmount = initialAmount + int.parse(amount);

                                                          await FirebaseFirestore.instance.collection('Add History').doc().set({
                                                            'name' : x['item'],
                                                            'colour' :'-',
                                                            'amount' : int.tryParse(amount),
                                                            'order' : DateTime.now().toString(),
                                                            'date' : '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}'
                                                          });

                                                          fileRef!.doc('${snapshot.data!.docs[i]['item']}').set({
                                                            'item' : x['item'],
                                                            'amount' : initialAmount,
                                                          });
                                                        },
                                                        child: const Text("Add",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)
                                                    ),
                                                  ],),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  );
                                },
                                child: Container(
                                    margin: const EdgeInsets.all(8),
                                    height: 40,
                                    width: MediaQuery.of(context).size.width*0.8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 10,
                                          offset: const Offset(0, 10),
                                        ),
                                      ],
                                    ),
                                    child:Center(
                                      child: Text(x['item'],style: const TextStyle(color: Colors.black,fontSize: 19),),
                                    )
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
    );
  }
}
