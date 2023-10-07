import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class interLockSold extends StatefulWidget {
  const interLockSold({super.key});

  @override
  State<interLockSold> createState() => _interLockSoldState();
}

class _interLockSoldState extends State<interLockSold> {

  int interAmount = 0;

  @override
  void initState() {
    super.initState();
    fatchichDatabaseList();
  }

  fatchichDatabaseList() async {

    var inter = await FirebaseFirestore.instance.collection('Interlock Bricks').doc('add');
    inter.get().then((inter){
      interAmount = inter['amount'];
    });
  }
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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

                                if(interAmount == null)
                                {
                                  setState(() {
                                    interAmount= 0;
                                  });
                                }
                                else
                                {
                                  setState(() {
                                    interAmount = interAmount;
                                  });
                                }

                                String amount = textEditingController.text.trim();
                                interAmount = interAmount - int.parse(amount);

                                if(interAmount<0){
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
                                    'name' : 'Interlock Bricks',
                                    'colour' : '-',
                                    'amount' : int.tryParse(amount),
                                    'order' : DateTime.now().toString(),
                                    'date' : '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}'
                                  });
                                  await FirebaseFirestore.instance.collection('Interlock Bricks').doc('add').set({
                                    'amount' : interAmount,
                                  });
                                }
                              },
                              child: const Text("Sold",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
                        ],),
                    ],
                  ),
                ),
              );
            }
        );
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width*0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: const Center(child: Text("Inetrlock Bricks",style: TextStyle(fontSize: 19,color: Colors.black),)),
      ),
    );
  }
}
