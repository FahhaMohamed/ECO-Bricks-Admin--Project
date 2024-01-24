import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

class addScreen extends StatefulWidget {
  const addScreen({super.key});

  @override
  State<addScreen> createState() => _addScreenState();
}

class _addScreenState extends State<addScreen> {
  CollectionReference? fileRef =
      FirebaseFirestore.instance.collection('Add History');

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.grey.shade100,
        title: Text(
          "History of produced items",
          style: GoogleFonts.aBeeZee(color: Colors.black),
        ),
        leading: Icon(
          Icons.history,
          color: Colors.purple,
          size: 30,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/background/back.webp'),
                        fit: BoxFit.fill,
                        opacity: 0.7),
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
                            width: w * 0.24,
                            child: const Center(
                                child: Text(
                              "Type",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ))),
                        SizedBox(
                            width: w * 0.24,
                            child: const Center(
                                child: Text(
                              "Amount",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ))),
                        SizedBox(
                            width: w * 0.24,
                            child: const Center(
                                child: Text(
                              "Colour",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ))),
                        SizedBox(
                            width: w * 0.24,
                            child: const Center(
                                child: Padding(
                              padding: EdgeInsets.only(
                                right: 3.0,
                              ),
                              child: Text(
                                "Product Date",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ))),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: fileRef!
                          .orderBy('order', descending: true)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return AnimationLimiter(
                            child: ListView.builder(
                                padding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.width / 50),
                                physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, i) {
                                  QueryDocumentSnapshot x =
                                      snapshot.data!.docs[i];
                                  return AnimationConfiguration.staggeredList(
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
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  35),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    width: w * 0.24,
                                                    child: Center(
                                                        child: Text(
                                                      x['name'],
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                    ))),
                                                SizedBox(
                                                    width: w * 0.24,
                                                    child: Center(
                                                        child: Text(
                                                      "${x['amount']}",
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16),
                                                    ))),
                                                SizedBox(
                                                    width: w * 0.24,
                                                    child: Center(
                                                        child: Text(
                                                      x['colour'],
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16),
                                                    ))),
                                                SizedBox(
                                                    width: w * 0.24,
                                                    child: Center(
                                                      child: Text(
                                                        x['date'],
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                      ),
                                                    )),
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
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
