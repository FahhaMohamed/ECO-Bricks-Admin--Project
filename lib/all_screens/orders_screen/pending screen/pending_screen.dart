
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_bricks/Widgets/add_customer_dialog.dart';
import 'package:eco_bricks/Widgets/animated_custom_list.dart';
import 'package:eco_bricks/customers/pending%20customer/pending_customer_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon_animated/icon_animated.dart';
import 'package:info_toast/info_toast.dart';
import 'package:info_toast/resources/arrays.dart';


class PendingScreen extends StatefulWidget {

  const PendingScreen({super.key});

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {

  CollectionReference? pendingCustomer = FirebaseFirestore.instance.collection('Pending customer');

  final TextEditingController categoryEditingController = TextEditingController();
  final TextEditingController itemEditingController = TextEditingController();
  final TextEditingController colorEditingController = TextEditingController();
  final TextEditingController amountEditingController = TextEditingController();
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController mobileEditingController = TextEditingController();
  final TextEditingController addressEditingController = TextEditingController();

  String search = "";


  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    final keyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    return GestureDetector(
      onTap:()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {

            categoryEditingController.text = '';
            itemEditingController.text = '';
            amountEditingController.text = '';
            colorEditingController.text = '';
            nameEditingController.text = '';
            mobileEditingController.text = '';
            addressEditingController.text = '';

            showAdaptiveDialog(
              barrierDismissible: false,
                context: context,
                builder: (context){
                  return AddCustomerDialog(
                    categoryEditingController: categoryEditingController,
                    itemEditingController: itemEditingController,
                    colorEditingController: colorEditingController,
                    amountEditingController: amountEditingController,
                    nameEditingController: nameEditingController,
                    mobileEditingController: mobileEditingController,
                    addressEditingController: addressEditingController,
                    onPressed: () async {

                      if(categoryEditingController.text.isEmpty || itemEditingController.text.isEmpty || amountEditingController.text.isEmpty || nameEditingController.text.isEmpty || mobileEditingController.text.isEmpty || addressEditingController.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Please fill all the fields');
                        return;
                      } else if(mobileEditingController.text.length  > 10 || mobileEditingController.text.length < 9) {
                        Fluttertoast.showToast(msg: 'Please check the mobile number');
                        return;
                      }else {

                        Navigator.pop(context);

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
                            title:   Text('Orders Successfully added',style: TextStyle(fontSize: 17,color: Colors.white),),
                            displayTitle:  true,
                            toastPosition:  Position.bottom,
                            animationType: AnimationType.fromRight,
                            animationDuration:  Duration(milliseconds:  1000),
                            autoDismiss:  true
                        ).show(context);


                        var date  = DateTime.now();
                        var order = date.microsecondsSinceEpoch.toString();

                        await pendingCustomer!.doc(order).set({
                          'name' : nameEditingController.text,
                          'mobile' : mobileEditingController.text,
                          'address' : addressEditingController.text,
                          'order' : order,
                        });

                        await pendingCustomer!.doc(order).collection('Orders').doc(order).set({
                          'category' : categoryEditingController.text,
                          'item' : itemEditingController.text,
                          'color' : colorEditingController.text.isEmpty ? "-" : colorEditingController.text,
                          'amount' : amountEditingController.text,
                          'date' : '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                          'time' : '${DateTime.now().hour}:${DateTime.now().minute}',
                          'order' : order,
                        });

                      }

                    },
                  );
                }
            );
          },
          child: Icon(IconlyLight.addUser,size: 30,color: Colors.purple,),
          backgroundColor: Colors.grey.shade300,
        ),
        backgroundColor: Colors.grey.shade100,
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(top: 15.0,left: 10,right: 10),
                child: Container(
                  height: 40,
                  padding: EdgeInsets.only(left: 20,right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (val){
                      setState(() {
                        search = val;
                      });
                    },
                    cursorColor: Colors.purple,
                    style: TextStyle(
                        decorationColor: Colors.white12,
                        letterSpacing: 0.7,
                        fontSize: 18,
                        color: Colors.black
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: 'Find customer',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black45,
                        ),
                        suffixIcon: Icon(Icons.search,color:!keyBoard ? Colors.black45 : Colors.purple ,)
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40,),
              Expanded(
                child: StreamBuilder(
                  stream: pendingCustomer!.orderBy('name').startAt([search]).endAt([search + "\uf8ff"]).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

                    if(snapshot.connectionState == ConnectionState.waiting)
                      {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if(!snapshot.hasData || snapshot.data!.docs.isEmpty) {

                      return SingleChildScrollView(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Opacity(
                                  child: Image.asset('assets/empty/pending.webp',width: w * 0.8,),
                                  opacity: 0.7,
                              ),
                              const SizedBox(height: 10,),
                              Text('No pending orders',style: GoogleFonts.aBeeZee(color: Color(0xFF6A1B9A),fontSize: 22,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 5,),
                              Text('Take new order',style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 19,fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                      );
                    }

                    else if (snapshot.hasData) {

                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, i) {

                          QueryDocumentSnapshot x = snapshot.data!.docs[i];

                          return AnimatedCustomList(context, child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(

                              onTap: ()=> Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context)=> PendingCustomer(
                                    order: x['order'], name: x['name'], address: x['address'], mobile: x['mobile'],
                                  )
                              ),
                              ),

                              child: AnimationConfiguration.staggeredList(
                                position: i,
                                delay: const Duration(milliseconds: 100),
                                child: SlideAnimation(
                                  duration:
                                  const Duration(milliseconds: 2500),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  horizontalOffset: 30,
                                  verticalOffset: 300.0,
                                  child: FadeInAnimation(
                                    duration:
                                    const Duration(milliseconds: 2500),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    child: Container(
                                      padding: EdgeInsets.only(left: 5,right: 5),
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            blurRadius: 10,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                          children:[
                                            ListTile(
                                              title: Text(x['name'],
                                                style: TextStyle(
                                                    inherit: false,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18
                                                ),
                                              ),
                                              subtitle: Text(x['mobile'],),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Center(child: Icon(Icons.arrow_circle_right_outlined,size: 50,color: Colors.purple,)),
                                              ],
                                            ),
                                          ]
                                      ),
                                    ),
                                  ),
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
          )
        ),
      ),
    );
  }
}
