import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ft01Add extends StatefulWidget {
  const ft01Add({super.key});

  @override
  State<ft01Add> createState() => _ft01AddState();
}

class _ft01AddState extends State<ft01Add> {

  CollectionReference? fileRef = FirebaseFirestore.instance.collection('FT 01 Floor Tiles');
  TextEditingController textEditingController = TextEditingController();
  TextEditingController colorEditingController = TextEditingController();
  int initialAmount = 0;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.grey.shade100,
                icon: Row(
                  children: [
                    IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
                    const Expanded(child: SizedBox()),
                    const Text("Create new",style: TextStyle(color: Colors.purple,fontSize: 17,fontWeight: FontWeight.bold),),
                    IconButton(
                        onPressed: (){
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: const Text("Add new colour",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  content: SizedBox(
                                    height: 160,
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
                                            controller: colorEditingController,
                                            textCapitalization: TextCapitalization.sentences,
                                            keyboardType: TextInputType.text,
                                            style: TextStyle(
                                              color: Colors.black,
                                              decorationColor: Colors.pinkAccent.withOpacity(0.05),
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.7,
                                            ),
                                            cursorColor: Colors.black,
                                            decoration: const InputDecoration(
                                              hintText: ' Colour',
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
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
                                                  String amount = textEditingController.text.trim();
                                                  if(amount.isEmpty){
                                                    amount = "0";
                                                  }
                                                  String color = colorEditingController.text.trim();

                                                  Navigator.pop(context);

                                                  await FirebaseFirestore.instance.collection('Add History').doc().set({
                                                    'name' : 'FT 01 Floor Tiles',
                                                    'colour' : color,
                                                    'amount' : int.tryParse(amount),
                                                    'order' : DateTime.now().toString(),
                                                    'date' : '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}'
                                                  });
                                                  await FirebaseFirestore.instance.collection('FT 01 Floor Tiles').doc(color).set({
                                                    'color' : color,
                                                    'amount' : int.tryParse(amount),
                                                  });
                                                },
                                                child: const Text("Create",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
                                          ],),
                                      ],
                                    ),
                                  ),
                                );
                              }
                          );
                        },
                        icon: Icon(
                          Icons.add_circle,
                          color: Colors.purple,
                          size: 30,
                          shadows: [
                            Shadow(
                              color: Colors.grey.shade300,
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            )
                          ],
                        )
                    )
                  ],
                ),
                title: const Text("Please select the colour",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                content: SizedBox(
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
                                                              'name' : 'FT 01 Floor Tiles',
                                                              'colour' : x['color'],
                                                              'amount' : int.tryParse(amount),
                                                              'order' : DateTime.now().toString(),
                                                              'date' : '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}'
                                                            });

                                                            fileRef!.doc('${snapshot.data!.docs[i]['color']}').set({
                                                              'color' : x['color'],
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
                                      width: 6,
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
                                        child: Text(x['color'],style: const TextStyle(color: Colors.black,fontSize: 19),),
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
              );
            }
        );
      },
      child: Container(
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
        child: const Center(child: Text("FT 01",style: TextStyle(fontSize: 19,color: Colors.black),)),
      ),
    );
  }
}
