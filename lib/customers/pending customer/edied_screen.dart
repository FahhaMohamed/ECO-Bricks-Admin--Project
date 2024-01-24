import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_bricks/Widgets/animated_custom_list.dart';
import 'package:eco_bricks/Widgets/editing_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Widgets/add_order_dialog.dart';

class EditCustomer extends StatefulWidget {

  final String order;
  final String name;
  final String address;
  final String mobile;


  const EditCustomer({super.key, required this.order, required this.name, required this.address, required this.mobile});

  @override
  State<EditCustomer> createState() => _EditCustomerState();
}

class _EditCustomerState extends State<EditCustomer> {

  CollectionReference? pendingCustomer = FirebaseFirestore.instance.collection('Pending customer');

  final TextEditingController categoryEditingController = TextEditingController();
  final TextEditingController itemEditingController = TextEditingController();
  final TextEditingController colorEditingController = TextEditingController();
  final TextEditingController amountEditingController = TextEditingController();
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController mobileEditingController = TextEditingController();
  final TextEditingController addressEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
        backgroundColor: Colors.grey.shade300,
        title: const  Text("Edit the orders",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22,),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Container(
                height: 55,
                padding: EdgeInsets.all(5),
                width: w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/background/back.webp'),
                        fit: BoxFit.fill,
                        opacity: 0.7),
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width:w*0.4,child: Center(child: const Text("Items",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),))),
                    SizedBox(width:w*0.2,child: Center(child: const Text("Balance",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),))),
                    SizedBox(width:w*0.24,child: const Text("Order date",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),)),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              const SizedBox(height: 10,),
              Expanded(
                child: StreamBuilder(
                  stream: pendingCustomer!.doc(widget.order).collection('Orders').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else if(snapshot.hasData) {
                      return ListView.builder(
                        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,i){

                          QueryDocumentSnapshot x = snapshot.data!.docs[i];

                          return AnimatedCustomList(context, child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: GestureDetector(
                              onLongPress: (){
                                showDialog(barrierDismissible:false, context: context, builder: (context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Icon(Icons.info,color: Colors.red,size: 25,),
                                        const SizedBox(width: 5,),
                                        const Text('Confirmation',style: TextStyle(color: Colors.red),)
                                      ],
                                    ),
                                    content: const Text('Are you sure to remove the order',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                                    actions: [
                                      ElevatedButton(
                                          style:ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey,
                                          ),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel',style: TextStyle(fontSize: 16,color: Colors.black),)
                                      ),
                                      ElevatedButton(
                                          style:ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                          ),
                                          onPressed: () async {
                                            Navigator.pop(context);

                                            await pendingCustomer!.doc(widget.order).collection('Orders').doc(widget.order).delete();
                                          },
                                          child: const Text('Confirm',style: TextStyle(fontSize: 16,color: Colors.black),)
                                      ),
                                    ],
                                  );
                                });
                              },
                              onTap: (){

                                categoryEditingController.text = x['category'];
                                itemEditingController.text = x['item'];
                                amountEditingController.text = x['amount'];
                                colorEditingController.text = x['color'];

                                showDialog(
                                  context: context,
                                  builder: (context) => AddOrderDialog(
                                    categoryEditingController: categoryEditingController,
                                    itemEditingController: itemEditingController,
                                    colorEditingController: colorEditingController,
                                    amountEditingController: amountEditingController,
                                    onPressed: () async {

                                      if(categoryEditingController.text.isEmpty || itemEditingController.text.isEmpty || amountEditingController.text.isEmpty ) {
                                        Fluttertoast.showToast(msg: 'Please fill all the fields');
                                        return;
                                      } else {

                                        Navigator.pop(context);


                                        await pendingCustomer!.doc(widget.order).collection('Orders').doc(x['order']).update({
                                          'category' : categoryEditingController.text,
                                          'item' : itemEditingController.text,
                                          'color' : colorEditingController.text.isEmpty ? "-" : colorEditingController.text,
                                          'amount' : amountEditingController.text,
                                          if(amountEditingController.text != x['amount'])
                                            'date' : '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                                          if(amountEditingController.text != x['amount'])
                                            'time' : '${DateTime.now().hour}:${DateTime.now().minute}',
                                        });

                                      }

                                    },
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 10,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width:w*0.4,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            x['item'],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          if(x['color'] != "-")
                                            Text(
                                              x['color'],
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          Text(
                                            x['category'],
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width:w*0.2,child: Center(child: Text(x['amount'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),))),
                                    SizedBox(
                                      width:w*0.24,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            x['date'],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            x['time'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black54
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),                                ],
                                ),
                              ),
                            ),
                          ), index: i);
                        },
                      );
                    }
                    else {
                      return const Center(
                        child: Text("EMPTY",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
