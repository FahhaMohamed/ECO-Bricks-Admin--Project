
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_bricks/Widgets/custom_carousel_slider.dart';
import 'package:eco_bricks/all_screens/mainScreen.dart';
import 'package:eco_bricks/all_screens/pavers.dart';
import 'package:eco_bricks/all_screens/rawMaterials.dart';
import 'package:eco_bricks/all_screens/wallTiles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../Widgets/fadout_trans.dart';
import 'bricks.dart';
import 'floorTiles.dart';
import 'hydralicPavers.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

List<String> asset = [
  'assets/1.jpg',
  'assets/2.jpg',
  'assets/4.jpg',
  'assets/5.jpg',
  'assets/6.jpg',
  'assets/7.jpg',
  'assets/8.jpg',
];

class _homeScreenState extends State<homeScreen> {

  ScrollController scrollController = ScrollController();


  int currentIndex = 0;


  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500),(){
      scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(seconds: asset.length*10), curve: Curves.linear);
    });
  }


  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: w*0.05,),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text("  Our Projects",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),)
              ),
              SizedBox(height: w*0.07,),
              CarouselWidget(context,list: asset),
              SizedBox(height: w*0.07,),

              const Align(
                  alignment: Alignment.topLeft,
                  child: Text("  Categories",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),)
              ),
              SizedBox(height: w*0.07,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ZoomTapAnimation(
                          onTap:() => Navigator.push(context, FadeRoute2(const bricks())),
                          child: Container(
                            margin: const EdgeInsets.all(13),
                            height: w*0.3,
                            width: w*0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.withOpacity(0.15),
                                  blurRadius: 10,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Bricks",
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ).animate().slideX(begin:-1,delay: Duration(milliseconds: 50),duration: Duration(milliseconds: 600)),
                        ),
                      ),
                      Expanded(
                        child: ZoomTapAnimation(
                          onTap: () => Navigator.push(context, FadeRoute2(const pavers())),
                          child: Container(
                            margin: const EdgeInsets.all(13),
                            height: w*0.3,
                            width: w*0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.withOpacity(0.15),
                                  blurRadius: 10,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Pavers",
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ).animate().slideX(begin:1,delay: Duration(milliseconds: 50),duration: Duration(milliseconds: 600)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: w*0.04,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ZoomTapAnimation(
                          onTap:() => Navigator.push(context, FadeRoute2(const floorTiles())),
                          child: Container(
                            margin: const EdgeInsets.all(13),
                            height: w*0.3,
                            width: w*0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.withOpacity(0.15),
                                  blurRadius: 10,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Floor",
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    SizedBox(height: w*0.01,),
                                    Text(
                                      "Tiles",
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ).animate().slideX(begin:-1,delay: Duration(milliseconds: 50),duration: Duration(milliseconds: 500)),
                        ),
                      ),
                      Expanded(
                        child: ZoomTapAnimation(
                          onTap:() => Navigator.push(context, FadeRoute2(const wallTiles())),
                          child: Container(
                            margin: const EdgeInsets.all(13),
                            height: w*0.3,
                            width: w*0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.withOpacity(0.15),
                                  blurRadius: 10,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Wall",
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    SizedBox(height: w*0.01,),
                                    Text(
                                      "Tiles",
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ).animate().slideX(begin:1,delay: Duration(milliseconds: 50),duration: Duration(milliseconds: 500)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: w*0.04,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ZoomTapAnimation(
                          onTap:() => Navigator.push(context, FadeRoute2(const hydraulicPavers())),
                          child: Container(
                            margin: const EdgeInsets.all(13),
                            height: w*0.3,
                            width: w*0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Hydraulic",
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    SizedBox(height: w*0.01,),
                                    Text(
                                      "Pavers",
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ).animate().slideX(begin:-1,delay: Duration(milliseconds: 50),duration: Duration(milliseconds: 400)),
                        ),
                      ),
                      Expanded(
                        child: ZoomTapAnimation(
                          onTap:() => Navigator.push(context, FadeRoute2(const rawMaterials())),
                          child: Container(
                            margin: const EdgeInsets.all(13),
                            height: w*0.3,
                            width: w*0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.purple.shade300,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.shade100,
                                  blurRadius: 10,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Raw",
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    SizedBox(height: w*0.01,),
                                    Text(
                                      "Materials",
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ).animate().slideX(begin:1,delay: Duration(milliseconds: 50),duration: Duration(milliseconds: 400)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 80,),
            ],
          ),
        ),
      ),
    );
  }
}
