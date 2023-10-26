
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';


class soldScreen extends StatefulWidget {
  const soldScreen({super.key});

  @override
  State<soldScreen> createState() => _soldScreenState();
}

class _soldScreenState extends State<soldScreen> {

  CollectionReference? fileRef = FirebaseFirestore.instance.collection('Sold History');

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.grey.shade100,
        title: Text("History of sold items",style: GoogleFonts.aBeeZee(color: Colors.black),),
        leading: Icon(Icons.history,color: Colors.purple,size: 30,),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
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
                          width: w*0.25,
                          child: const Center(child: Text("Type",style: TextStyle(color: Colors.white,fontSize: 16),))
                      ),
                      SizedBox(
                          width: w*0.25,
                          child: const Center(child: Text("Amount",style: TextStyle(color: Colors.white,fontSize: 16),))
                      ),
                      SizedBox(
                          width: w*0.25,
                          child: const Center(child: Text("Colour",style: TextStyle(color: Colors.white,fontSize: 16),))
                      ),
                      SizedBox(
                          width: w*0.25,
                          child: const Center(child: Text("Sold Date",style: TextStyle(color: Colors.white,fontSize: 16),))
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
                                                  width: w*0.25,
                                                  child: Center(child: Text(x['name'],style: const TextStyle(color: Colors.black,fontSize: 14),))),
                                              SizedBox(
                                                  width: w*0.25,
                                                  child: Center(child: Text("${x['amount']}",style: const TextStyle(color: Colors.black,fontSize: 16),))),
                                              SizedBox(
                                                  width: w*0.25,
                                                  child: Center(child: Text(x['colour'],style: const TextStyle(color: Colors.black,fontSize: 16),))),
                                              SizedBox(
                                                  width: w*0.25,
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

                              }),
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
        ),
      ),
    );
  }
}
