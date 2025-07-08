
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eco_bricks/all_screens/soldScreen.dart';
import 'package:eco_bricks/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/call_handler/callHandler.dart';
import 'Login screen/loginScreen.dart';
import 'addScreen.dart';
import 'homeScreen.dart';
import 'orders_screen/order_screen.dart';

class mainScreen extends StatefulWidget {

  mainScreen({super.key });

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> with SingleTickerProviderStateMixin{

  int counter = 0;

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
   initState() {
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

    FirebaseFirestore.instance.collection('Pending customer').get().then((data) {
      setState(() {
        counter = data.docs.length;
      });
    });

    double w = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor:Colors.grey.shade100,
        appBar: selectedIndex == 0 ? AppBar(
          elevation: 0,
          backgroundColor: Colors.grey.shade100,
          foregroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(0),
            ),
          ),
          actions: [
           Padding(
             padding: const EdgeInsets.only(right: 15.0),
             child: Badge(
               isLabelVisible: counter == 0 ? false : true,
               backgroundColor: CustomColor.badgeColor,
               offset: Offset(5, -3),
               label: Text(counter>9 ? '${counter}': ' ${counter} ',style: TextStyle(fontSize: 15,color: Colors.black),),
               largeSize: 23,
               smallSize: 23,
               child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white
                    ),
                   onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OrderScreen()));
                   },
                   child: Text("Orders",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17,),)),
             ).animate().shimmer(duration: Duration(milliseconds: 1000)),
           ),
          ],
        ): null,
        drawer: selectedIndex == 0 ? Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey,
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.grey,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
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
              Center(
                child: Container(
                  height: 120,
                  width: w,
                  child: Image.asset('assets/splash/new.PNG',fit: BoxFit.cover,).animate().shimmer(duration: Duration(milliseconds: 1000)),
                ),
              ),
              Divider(
                thickness: 2,
                indent: 10,
                endIndent: 10,
              ),
              SizedBox(height:5,),
              const ListTile(
                title: Text("Contacts",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15,right: 15),
                width: w,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/background/back.webp'),fit: BoxFit.fill,opacity: 0.5),
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
              ).animate().shimmer(duration: Duration(milliseconds: 1000)),
              SizedBox(height:5,),
              const ListTile(
                minVerticalPadding: 10,
                title: Text("Address",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15,right: 15),
                width: w,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/background/back.webp'),fit: BoxFit.fill,opacity: 0.7),
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
              ).animate().shimmer(duration: Duration(milliseconds: 1000)),
              SizedBox(height:5,),
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
                    image: DecorationImage(image: AssetImage('assets/background/back.webp'),fit: BoxFit.fill,opacity: 0.7),
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
                ).animate().shimmer(duration: Duration(milliseconds: 1000)),
              ),
              SizedBox(height: 12,),
              InkWell(
                onTap: (){
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
                                backgroundColor:  Colors.grey,
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
                                backgroundColor: Colors.purple,
                              ),
                              child: const Text('Yes',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)
                          ),
                        ],
                      )
                    ],
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: const ListTile(
                    title: Text("Log Out",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold)),
                    leading: Icon(Icons.logout,color: Colors.purple,),
                  ),
                ),
              ).animate().shimmer(duration: Duration(milliseconds: 1000)),
            ],
          ),
        ) : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(image: AssetImage('assets/background/back.webp',),fit: BoxFit.cover,),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 3,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: BottomNavigationBar(
              iconSize: 25,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(IconlyBold.home,size: 25,),
                    label: 'Home'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.store),
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
          ).animate().shimmer(duration: Duration(milliseconds: 1000),delay: Duration(milliseconds: 300)),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: const [
            homeScreen(),
            addScreen(),
            soldScreen(),
          ],
        ),
    );
  }
}