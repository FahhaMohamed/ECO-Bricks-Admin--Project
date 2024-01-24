import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_bricks/Widgets/animated_custom_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class PendingHistory extends StatefulWidget {

  final String order1;

  const PendingHistory({super.key, required this.order1});

  @override
  State<PendingHistory> createState() => _PendingHistoryState();
}

class _PendingHistoryState extends State<PendingHistory> {

  CollectionReference? pendingCustomer =
  FirebaseFirestore.instance.collection('Pending customer');
  @override
  Widget build(BuildContext context) {

    var history = pendingCustomer!.doc(widget.order1).collection('history');

    double w  = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: const  Text("Settlement History",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22,),),
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
                    SizedBox(width:w*0.24,child: const Text("Date",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),)),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              const SizedBox(height: 10,),
              Expanded(
                child: StreamBuilder(
                  stream: history.orderBy('order',descending: true).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, i) {
                          QueryDocumentSnapshot x = snapshot.data!.docs[i];

                          return AnimatedCustomList(context, child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
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
                                        child: Text(
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
