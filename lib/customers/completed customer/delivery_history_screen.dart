import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_bricks/Widgets/animated_custom_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class DeliveryHistory extends StatefulWidget {
  const DeliveryHistory({super.key});

  @override
  State<DeliveryHistory> createState() => _DeliveryHistoryState();
}

class _DeliveryHistoryState extends State<DeliveryHistory> {

  CollectionReference? delivery = FirebaseFirestore.instance.collection('delivery history');

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        title: const  Text("All settlements",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22,),),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/background/back.webp'),
                      fit: BoxFit.fill,
                      opacity: 0.7),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.purple,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          width: w*0.2,
                          child: const Center(child: Text("Customer",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),))
                      ),
                      SizedBox(
                          width: w*0.2,
                          child: const Center(child: Text("Product",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),))
                      ),
                      SizedBox(
                          width: w*0.2,
                          child: const Center(child: Text("Amount",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),))
                      ),
                      SizedBox(
                          width: w*0.2,
                          child: const Center(child: Text("Settled Date",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),))
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Expanded(
                child: StreamBuilder(
                  stream: delivery!.orderBy('order',descending: true).snapshots(),
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

                          return AnimatedCustomList(
                              context,
                              child: Padding(
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
                                        width: w * 0.2,
                                        child: Center(
                                          child: Text(
                                            x['name'],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w * 0.2,
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
                                        width: w * 0.2,
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
                              index: i
                          );
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
        )
      ),
    );
  }
}
