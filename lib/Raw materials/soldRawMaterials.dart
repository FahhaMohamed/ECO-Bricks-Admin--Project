import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

class SoldRawMaterials extends StatefulWidget {
  const SoldRawMaterials({super.key});

  @override
  State<SoldRawMaterials> createState() => _SoldRawMaterialsState();
}

class _SoldRawMaterialsState extends State<SoldRawMaterials> {

  CollectionReference? fileRef = FirebaseFirestore.instance.collection('Raw sold History');

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        title: Text("Reduced History",style: TextStyle(color: Colors.black),),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
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
                      child: const Center(child: Text("Items",style: TextStyle(color: Colors.white,fontSize: 16),))
                  ),
                  SizedBox(
                      width: w*0.2,
                      child: const Center(child: Text("Units",style: TextStyle(color: Colors.white,fontSize: 16),))
                  ),
                  SizedBox(
                      width: w*0.2,
                      child: const Center(child: Text("Date",style: TextStyle(color: Colors.white,fontSize: 16),))
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: fileRef!.orderBy('order',descending: true).snapshots(),
                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.hasData){
                    return AnimationLimiter(
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.width/50),
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context,i){
                            QueryDocumentSnapshot x = snapshot.data!.docs[i];
                            return AnimationConfiguration.staggeredList(
                              position: i,
                              delay: const Duration(milliseconds: 100),
                              child: SlideAnimation(
                                duration: const Duration(milliseconds: 2500),
                                curve: Curves.fastLinearToSlowEaseIn,
                                horizontalOffset: 30,
                                verticalOffset: 300.0,
                                child: FadeInAnimation(
                                  duration: const Duration(milliseconds: 2500),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width/35),
                                    height: MediaQuery.of(context).size.width/8,
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
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                              width: w*0.2,
                                              child: Center(child: Text(x['name'],style: const TextStyle(color: Colors.black,fontSize: 14),))),
                                          SizedBox(
                                              width: w*0.2,
                                              child: Center(child: Text("${x['amount']}"+x['unit'],style: const TextStyle(color: Colors.black,fontSize: 16),))),
                                          SizedBox(
                                              width: w*0.2,
                                              child: Center(
                                                child: Text(x['date'],style: const TextStyle(color: Colors.black,fontSize: 16),),
                                              )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );

                          }
                      ),
                    );

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
    );
  }
}
