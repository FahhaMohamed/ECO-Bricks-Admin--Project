
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eco_bricks/AllmainScreens/soldScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Call Handler/callHandler.dart';
import '../Login screen/loginScreen.dart';
import 'addScreen.dart';
import 'homeScreen.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> with SingleTickerProviderStateMixin{

  TabController? tabController;
  int selectedIndex = 0;
  late ConnectivityResult result;
  late StreamSubscription subscription;
  var isConnected = false;
  CallHandler callHandler = CallHandler();


  onItemClicked(int index)
  {
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }

  @override
  void initState() {

    super.initState();
    tabController = TabController(length: 3, vsync: this);
    startStreaming();
  }

  checkInternet() async {
    result = await Connectivity().checkConnectivity();
    if(result != ConnectivityResult.none)
    {
      isConnected = true;
    }
    else
    {
      isConnected = false;
      showDialogBox();
    }
  }


  showDialogBox()
  {
    showDialog(
        barrierDismissible: false,
        context: context, builder: (context) => AlertDialog(
      title: Text("No Internet"),
      content: Text("Please check your internet connection"),
      actions: [
        CupertinoButton(
          color: Colors.purple,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.refresh),
              Text("Retry")
            ],
          ),
          onPressed: (){
            Navigator.pop(context);
            checkInternet();
          },

        )
      ],
    ));
  }

  startStreaming ()
  {
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      checkInternet();
    });
  }

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: selectedIndex == 0 ? AppBar(
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
                              primary: Colors.grey,
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
        ): null,
        drawer: selectedIndex == 0 ? Container(
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
        ) : null,
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: const [
            homeScreen(),
            addScreen(),
            soldScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            iconSize: 25,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home,size: 25,),
                  label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle),
                  label: 'Product'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sell),
                  label: 'Sold'
              ),
            ],
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.purple,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: GoogleFonts.aBeeZee(
                fontSize: 14,
                fontWeight: FontWeight.w500
            ),
            showUnselectedLabels: false,
            showSelectedLabels: true,
            currentIndex: selectedIndex,
            onTap: onItemClicked,
          ),
        )
    );
  }
}