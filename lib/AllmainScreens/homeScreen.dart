
import 'package:eco_bricks/AllmainScreens/hydralicPavers.dart';
import 'package:eco_bricks/AllmainScreens/pavers.dart';
import 'package:eco_bricks/AllmainScreens/rawMaterials.dart';
import 'package:eco_bricks/AllmainScreens/wallTiles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Call Handler/callHandler.dart';
import '../Login screen/loginScreen.dart';
import '../Widgets/fadout_trans.dart';
import 'bricks.dart';
import 'floorTiles.dart';

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
  'assets/3.jpg',
  'assets/1.jpg',
  'assets/2.jpg',
  'assets/4.jpg',
  'assets/5.jpg',
  'assets/6.jpg',
  'assets/7.jpg',
  'assets/8.jpg',
  'assets/3.jpg',
  'assets/1.jpg',
  'assets/2.jpg',
  'assets/4.jpg',
  'assets/5.jpg',
  'assets/6.jpg',
  'assets/7.jpg',
  'assets/8.jpg',
  'assets/3.jpg',
];

class _homeScreenState extends State<homeScreen> {


  CallHandler callHandler = CallHandler();
  ScrollController scrollController = ScrollController();

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        foregroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(20),
        ),
       ),
        actions: [
          IconButton(
            onPressed: (){

              showDialog(context: context, builder: (ctx)=>AlertDialog(
                title: Text("Confirmation"),
                content: Text("Are you sure to Log out ??",),
                contentTextStyle: TextStyle(fontSize: 16,color: Colors.black.withOpacity(0.7)),
                actions: [
                  Row(
                    mainAxisAlignment : MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.purple,
                          ),
                          onPressed: (){

                            Navigator.of(ctx).pop();

                          },
                          child: const Text('No',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,),)
                      ),
                      ElevatedButton(
                          onPressed: (){

                            Navigator.of(ctx).pop();

                            FirebaseAuth.instance.signOut();

                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                              return const loginScreen();
                            }));

                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.purple,
                          ),
                          child: const Text('Yes',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)
                      ),
                    ],
                  )
                ],
              ));



            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black87,
              offset: Offset(2, 2),
              blurRadius: 3,
            )
          ],
          color: Colors.grey.shade100,
        ),
        width: w*0.65,
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              height: h*0.2,
              child: DrawerHeader(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Eco Bricks",style: GoogleFonts.aclonica(fontSize: 27,color: Colors.black,),),

                      Text("&",style: GoogleFonts.aclonica(fontSize: 27,color: Colors.black,),),

                      Text("Tiles (Pvt) Ltd.",style: GoogleFonts.aclonica(fontSize: 27,color: Colors.black,),),
                    ],
                  ),
                )
              ),
            ),
            SizedBox(height: h*0.015,),
            const ListTile(
              title: Text("Contacts",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15,right: 15),
              width: w,
              decoration: BoxDecoration(
                  boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 10),
                  ),
                ],
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      callHandler.call("071 485 0060");
                    },
                    child: const ListTile(
                      title: Text("071 485 0060",style: TextStyle(color: Colors.black,fontSize: 16),),
                      leading: Icon(Icons.phone,color: Colors.purple,),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      callHandler.call("032 226 5332");
                    },
                    child: const ListTile(
                      title: Text("032 226 5332",style: TextStyle(color: Colors.black,fontSize: 16),),
                      leading: Icon(Icons.phone,color: Colors.purple,),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      callHandler.call("070 185 0067");
                    },
                    child: const ListTile(
                      title: Text("070 185 0067",style: TextStyle(color: Colors.black,fontSize: 16),),
                      leading: Icon(Icons.phone,color: Colors.purple,),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      callHandler.call("071 485 0068");
                    },
                    child: const ListTile(
                      title: Text("071 485 0068",style: TextStyle(color: Colors.black,fontSize: 16),),
                      leading: Icon(Icons.phone,color: Colors.purple,),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: h*0.015,),
            const ListTile(
              minVerticalPadding: 10,
              title: Text("Address",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15,right: 15),
              width: w,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 10),
                  ),
                ],
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: const Center(
                child: ListTile(
                  subtitle: Text("No: 213, Mannar Road, Puttalam.",style: TextStyle(color: Colors.black,fontSize: 16,),),
                  leading: Icon(Icons.location_pin,color: Colors.purple,),
                ),
              ),
            ),
            SizedBox(height: h*0.015,),
            const ListTile(
              minVerticalPadding: 20,
              title: Text("Email",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
            ),
            GestureDetector(
              onTap: () async {
                final Uri emailUri = Uri(
                  scheme: 'mailto',
                  path: 'ecobricksntiles@gmail.com',
                );
                await launchUrl(emailUri);
              },
              child: Container(
                margin: const EdgeInsets.only(left: 15,right: 15),
                width: w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 10),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: const Center(
                  child: ListTile(
                    subtitle: Text("ecobricksntiles@gmail.com",style: TextStyle(color: Colors.black,fontSize: 18,),),
                    leading: Icon(Icons.email,color: Colors.purple,),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent
                    ),
                    width: w,
                    height: h*0.26,
                    child: Center(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          controller: scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: asset.length,
                          itemBuilder: (BuildContext context, i) {
                            return Container(
                              margin: const EdgeInsets.all(10),
                              height: w*0.5,
                              width: w*0.65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                image: DecorationImage(image: AssetImage(asset[i]),fit: BoxFit.fill),
                                boxShadow:[
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    offset: const Offset(3, 5),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                    ),
                  )
              ),
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
                        child: GestureDetector(
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
                                  color: Colors.grey.shade300,
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
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
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
                                  color: Colors.grey.shade300,
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
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: w*0.04,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
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
                                  color: Colors.grey.shade300,
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
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
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
                                  color: Colors.grey.shade300,
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
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: w*0.04,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
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
                                  color: Colors.grey.shade300,
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
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
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
                                  color: Colors.grey.shade400,
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: w*0.1,),
            ],
          ),
        ),
      ),
    );
  }
}
