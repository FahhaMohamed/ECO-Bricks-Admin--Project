
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_bricks/Widgets/animated_custom_list.dart';
import 'package:eco_bricks/customers/pending%20customer/pending_customer_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../services/call_handler/callHandler.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {

  String search = "";
  CollectionReference? completeCustomer = FirebaseFirestore.instance.collection('Complete customer');

  CallHandler callHandler = CallHandler();


  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    final keyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    return GestureDetector(
      onTap:()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                    stream: completeCustomer!.orderBy('name').startAt([search]).endAt([search + "\uf8ff"]).snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }else if(!snapshot.hasData || snapshot.data!.docs.isEmpty) {

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/empty/emptybox.png',width: w *0.8,),
                            const SizedBox(height: 30,),
                            Text('Oops!!!',style: GoogleFonts.aBeeZee(color: Color(0xFF6A1B9A),fontSize: 22,fontWeight: FontWeight.bold)),
                            Text('Page is empty',style: GoogleFonts.aBeeZee(color: Color(0xFF6A1B9A),fontSize: 22,fontWeight: FontWeight.bold)),
                          ],
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
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: (){
                                  showAnimatedDialog(
                                      animationType: DialogTransitionType.size,
                                      curve: Curves.fastOutSlowIn,
                                      duration: Duration(seconds: 1),
                                      context: context,
                                      builder: (context){
                                    return AlertDialog(
                                      scrollable: true,
                                      content: Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios)),
                                                Text('Details', style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                                              ],
                                            ),
                                            ListTile(
                                              title: Text(x['name'], style: TextStyle(color: Colors.black,fontSize: 16),),
                                              leading: Icon(Icons.person,color: Colors.purple,size: 23,),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                callHandler.call(x['mobile']);
                                              },
                                              child: ListTile(
                                                title: Text(x['mobile'], style: TextStyle(color: Colors.black,fontSize: 16),),
                                                leading: Icon(Icons.phone,color: Colors.purple,size: 23,),
                                              ),
                                            ),
                                            ListTile(
                                              title: Text(x['address'], style: TextStyle(color: Colors.black,fontSize: 16),),
                                              leading: Icon(Icons.location_on,color: Colors.purple,size: 23,),
                                            ),
                                            ListTile(
                                              title: Text('Completed at:', style: TextStyle(color: Colors.black,fontSize: 16),),
                                              leading: Icon(IconlyBold.calendar,color: Colors.purple,size: 23,),
                                              subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(x['date'], style: TextStyle(color: Colors.black54,fontSize: 16),),
                                                  Text(x['time'], style: TextStyle(color: Colors.black54,fontSize: 16),),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    );
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 10.0 ,right: 5,top: 5,bottom: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.purple.shade100,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.purple.withOpacity(0.2),
                                        blurRadius: 10,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(IconlyBold.user2),
                                      const SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(x['name'], style: TextStyle(color: Colors.black,fontSize: 18),),
                                          Row(
                                            children: [
                                              Text(x['date'], style: TextStyle(color: Colors.black54,fontSize: 16),),
                                              Text(' at '+ x['time'], style: TextStyle(color: Colors.black54,fontSize: 16),),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Icon(Icons.arrow_circle_right_outlined,size: 40,color: Colors.purple,)
                                    ],
                                  ),
                                ),
                              ),
                            ), index: i);
                          },
                        );
                      }
                      else {
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
            )
        ),
      ),
    );
  }
}
