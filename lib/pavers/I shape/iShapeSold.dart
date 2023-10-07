import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class iShapeSold extends StatefulWidget {
  const iShapeSold({super.key});

  @override
  State<iShapeSold> createState() => _iShapeSoldState();
}

class _iShapeSoldState extends State<iShapeSold> {

  CollectionReference? fileRef = FirebaseFirestore.instance.collection('I Shape Pavers');
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
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
                                                            initialAmount = initialAmount - int.parse(amount);

                                                            if(initialAmount<0){
                                                              showDialog(
                                                                  context: context,
                                                                  builder: (context) {
                                                                    return AlertDialog(
                                                                      backgroundColor: Colors.white,
                                                                      title: const Row(
                                                                        children: [
                                                                          Icon(Icons.info_outline,color: Colors.red,),
                                                                          SizedBox(width: 10,),
                                                                          Text("Not enough items",
                                                                            style: TextStyle(
                                                                              color: Colors.red,
                                                                              fontSize: 20,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      content: SizedBox(
                                                                        height: 70,
                                                                        child: Column(
                                                                          children: [
                                                                            const Text('Please check the balance',style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 18,
                                                                            ),),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                TextButton(onPressed: (){Navigator.pop(context);}, child: const Text("Ok",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
                                                                              ],),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                              );
                                                            }
                                                            else{
                                                              Navigator.pop(context);
                                                              await FirebaseFirestore.instance.collection('Sold History').doc().set({
                                                                'name' : 'I Shape Pavers',
                                                                'colour' : x['color'],
                                                                'amount' : int.tryParse(amount),
                                                                'order' : DateTime.now().toString(),
                                                                'date' : '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}'
                                                              });

                                                              fileRef!.doc('${snapshot.data!.docs[i]['color']}').set({
                                                                'color' : x['color'],
                                                                'amount' : initialAmount,
                                                              });
                                                            }
                                                          },
                                                          child: const Text("Sold",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)
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
        child: const Center(child: Text("I Shape",style: TextStyle(fontSize: 19,color: Colors.black),)),
      ),
    );
  }
}
