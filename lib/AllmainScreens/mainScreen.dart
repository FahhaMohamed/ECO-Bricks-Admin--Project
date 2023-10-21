
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eco_bricks/AllmainScreens/soldScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Scaffold(
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
