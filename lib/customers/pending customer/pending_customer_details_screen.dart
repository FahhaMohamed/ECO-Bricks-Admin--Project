
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_bricks/Widgets/animated_custom_list.dart';
import 'package:eco_bricks/all_screens/orders_screen/order_screen.dart';
import 'package:eco_bricks/customers/pending%20customer/edied_screen.dart';
import 'package:eco_bricks/customers/pending%20customer/pending%20customer%20history.dart';
import 'package:eco_bricks/services/call_handler/callHandler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon_animated/icon_animated.dart';
import 'package:info_toast/info_toast.dart';
import 'package:info_toast/resources/arrays.dart';
import '../../Widgets/add_order_dialog.dart';

class PendingCustomer extends StatefulWidget {
  final String order;
  final String name;
  final String address;
  final String mobile;

  const PendingCustomer(
      {super.key,
      required this.order,
      required this.name,
      required this.address,
      required this.mobile});

  @override
  State<PendingCustomer> createState() => _PendingCustomerState();
}

class _PendingCustomerState extends State<PendingCustomer> {
  CollectionReference? pendingCustomer = FirebaseFirestore.instance.collection('Pending customer');
  CollectionReference? completeCustomer = FirebaseFirestore.instance.collection('Complete customer');
  CollectionReference? delivery = FirebaseFirestore.instance.collection('delivery history');

  final TextEditingController categoryEditingController = TextEditingController();
  final TextEditingController itemEditingController = TextEditingController();
  final TextEditingController colorEditingController = TextEditingController();
  final TextEditingController amountEditingController = TextEditingController();

  CallHandler callHandler = CallHandler();

  int Amount = 0;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Row(
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white),
                onPressed: () {
                  categoryEditingController.text = '';
                  itemEditingController.text = '';
                  amountEditingController.text = '';
                  colorEditingController.text = '';

                  showDialog(
                    context: context,
                    builder: (context) => AddOrderDialog(
                      categoryEditingController: categoryEditingController,
                      itemEditingController: itemEditingController,
                      colorEditingController: colorEditingController,
                      amountEditingController: amountEditingController,
                      onPressed: () async {
                        if (categoryEditingController.text.isEmpty ||
                            itemEditingController.text.isEmpty ||
                            amountEditingController.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'Please fill all the fields');
                          return;
                        } else {
                          Navigator.pop(context);

                          var date = DateTime.now();
                          var order = date.microsecondsSinceEpoch.toString();

                          await pendingCustomer!
                              .doc(widget.order)
                              .collection('Orders')
                              .doc(order)
                              .set({
                            'category': categoryEditingController.text,
                            'item': itemEditingController.text,
                            'color': colorEditingController.text.isEmpty
                                ? "-"
                                : colorEditingController.text,
                            'amount': amountEditingController.text,
                            'date':
                            '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                            'time': '${DateTime.now().hour}:${DateTime.now().minute}',
                            'order': order,
                          });
                        }
                      },
                    ),
                  );
                },
                child: Text(
                  "Take new order",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                )),
            const Spacer(),
            FloatingActionButton(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                onPressed: (){
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Row(
                          children: [
                            Icon(Icons.info,color: Colors.green,size: 25,),
                            const SizedBox(width: 5,),
                            const Text('Confirmation',style: TextStyle(color: Colors.green),)
                          ],
                        ),
                        content: SizedBox(
                          width:w,
                          child: const Text('Are you sure?? It will be remove the Customer',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        actionsAlignment: MainAxisAlignment.spaceAround,
                        actions: [
                          ElevatedButton(
                              style:ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                              ),
                              onPressed: (){
                                Navigator.pop(context);
                                },
                              child: const Text('Cancel',style: TextStyle(fontSize: 16,color: Colors.white),)
                          ),
                          ElevatedButton(
                              style:ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () async {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>OrderScreen()));

                                InfoToast(
                                    enableIconAnimation: true,
                                    displayCloseButton: false,
                                    iconWidget: IconAnimated(
                                      color: Colors.white,
                                      active: true,// boolean
                                      size: 40,
                                      iconType: IconType.message,
                                    ),
                                    backgroundColor: Colors.purple.shade300,
                                    themeColor:  Colors.green,
                                    title:   Text('Orders Successfully Completed',style: TextStyle(fontSize: 17,color: Colors.white),),
                                    displayTitle:  true,
                                    toastPosition:  Position.bottom,
                                    animationType: AnimationType.fromRight,
                                    animationDuration:  Duration(milliseconds:  1000),
                                    autoDismiss:  true
                                ).show(context);

                                await pendingCustomer!.doc(widget.order).delete();

                                String order = DateTime.now().microsecondsSinceEpoch.toString();

                                await completeCustomer!.doc().set({
                                  'name' : widget.name,
                                  'date': '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                                  'time': '${DateTime.now().hour}:${DateTime.now().minute}',
                                  'order': order,
                                  'mobile' : widget.mobile,
                                  'address' : widget.address,
                                });

                              },
                              child: const Text('Complete',style: TextStyle(fontSize: 16,color: Colors.white),)
                          ),
                        ],
                      );
                    }
                  );
                },
                child: Icon(Icons.check,size: 24,),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditCustomer(
                      order: widget.order,
                      name: widget.name,
                      address: widget.address,
                      mobile: widget.mobile)));
            },
            icon: Icon(
              IconlyLight.edit,
              color: Colors.purple,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PendingHistory(order1: widget.order,)));
              },
              icon: Icon(Icons.history,color: Colors.purple,size: 30,),
            ),
          ),
        ],
        leading: IconButton(
            onPressed: () async {
              Navigator.pop(context);


            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        backgroundColor: Colors.grey.shade300,
        title: const Text(
          "Pending customer",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Card(
                surfaceTintColor: Colors.transparent,
                color: Colors.grey.shade200,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.purple,
                      ),
                      title: Text(widget.name),
                    ),
                    Divider(
                      color: Colors.grey.shade100,
                      thickness: 5,
                    ),
                    GestureDetector(
                      onTap: (){
                        callHandler.call(widget.mobile);
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.phone,
                          color: Colors.purple,
                        ),
                        title: Text(widget.mobile),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade100,
                      thickness: 5,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.location_pin,
                        color: Colors.purple,
                      ),
                      title: Text(widget.address),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
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
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: w * 0.4,
                        child: Center(
                            child: const Text(
                          "Items",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ))),
                    SizedBox(
                        width: w * 0.2,
                        child: Center(
                            child: const Text(
                          "Balance",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ))),
                    SizedBox(
                        width: w * 0.24,
                        child: const Text(
                          "Order date",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: pendingCustomer!
                      .doc(widget.order)
                      .collection('Orders')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if(!snapshot.hasData || snapshot.data!.docs.isEmpty) {

                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Opacity(
                              child: Image.asset('assets/empty/lock.png',width: w * 0.8,),
                              opacity: 0.7,
                            ),
                            const SizedBox(height: 10,),
                            Text('Order has been completed',style: GoogleFonts.aBeeZee(color: Color(0xFF6A1B9A),fontSize: 22,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      );
                    }
                    else if (snapshot.hasData) {
                      return ListView.builder(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, i) {
                          QueryDocumentSnapshot x = snapshot.data!.docs[i];

                          return AnimatedCustomList(context, child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: GestureDetector(
                              onTap: () {
                                amountEditingController.text = '';

                                if (int.parse(x['amount']) == 0) {
                                  Fluttertoast.showToast(msg: 'Order completed');
                                  return;
                                }
                                else {
                                  showCupertinoDialog(
                                      barrierDismissible: true,
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          titleTextStyle: TextStyle(fontSize: 18),
                                          title: Text('Enter the given amount',style: TextStyle(color: Colors.black),),
                                          content: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: amountEditingController,
                                              keyboardType: TextInputType.numberWithOptions(),
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.sell,
                                                  color: Colors.purple,
                                                ),
                                                hintText: 'Amount',
                                              ),
                                            ),
                                          ),
                                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                                          actions: [
                                            ElevatedButton(
                                              style:ElevatedButton.styleFrom(
                                                foregroundColor: Colors.black,
                                                backgroundColor: Colors.red,
                                              ),
                                              onPressed: (){
                                                Navigator.pop(context);
                                              },
                                              child: Text('Cancel',style: TextStyle(fontSize: 17),),
                                            ),
                                            ElevatedButton(
                                              style:ElevatedButton.styleFrom(
                                                foregroundColor: Colors.black,
                                                backgroundColor: Colors.green,
                                              ),
                                              onPressed: () async {

                                                if(amountEditingController.text.isEmpty) {
                                                  Fluttertoast.showToast(msg: 'Please enter the amount');
                                                  return;
                                                }

                                                Amount = int.parse(x['amount'])-int.parse(amountEditingController.text);

                                                if(Amount<0) {
                                                  Fluttertoast.showToast(msg: 'Your amount is too high');
                                                  return;
                                                }else {

                                                  Navigator.pop(context);

                                                  await pendingCustomer!.doc(widget.order).collection('Orders').doc(x['order']).update({
                                                    'amount' : Amount.toString(),
                                                  });

                                                  var date = DateTime.now();

                                                  await pendingCustomer!.doc(widget.order).collection('history').doc().set({
                                                    'category': x['category'],
                                                    'item': x['item'],
                                                    'color': x['color'],
                                                    'amount': amountEditingController.text,
                                                    'date':
                                                    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                                                    'time': '${DateTime.now().hour}:${DateTime.now().minute}',
                                                    'order': date,
                                                  });

                                                  await delivery!.doc().set({
                                                    'category': x['category'],
                                                    'item': x['item'],
                                                    'color': x['color'],
                                                    'amount': amountEditingController.text,
                                                    'date':
                                                    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                                                    'time': '${DateTime.now().hour}:${DateTime.now().minute}',
                                                    'order': date,
                                                    'name' : widget.name,
                                                  });

                                                }



                                              },
                                              child: Text('Ok',style: TextStyle(fontSize: 17),),
                                            )
                                          ],
                                        );
                                      });
                                }
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
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: w * 0.4,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            x['item'],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          if (x['color'] != "-")
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
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                        width: w * 0.2,
                                        child: Center(
                                          child: int.parse(x['amount']) == 0 ? IconAnimated(
                                            strokeWidth: 4,
                                            color: Colors.green,
                                            active: true,// boolean
                                            size: 60,
                                            iconType: IconType.check,
                                          ): Text(
                                            x['amount'],
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )),
                                    SizedBox(
                                      width: w * 0.24,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ), index: i);
                        },
                      );
                    } else {
                      return const Center(
                        child: Text(
                          "EMPTY",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
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
