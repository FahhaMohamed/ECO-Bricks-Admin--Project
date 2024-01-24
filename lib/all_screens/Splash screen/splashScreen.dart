
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../Login screen/loginScreen.dart';
import '../mainScreen.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen>
    with SingleTickerProviderStateMixin {

  Stream<QuerySnapshot> pendingCustomer = FirebaseFirestore.instance.collection('Pending customer').snapshots();

  int counter = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    Future.delayed(
        const Duration(milliseconds: 2000),()
        {
          pendingCustomer.forEach((element) {

            counter =  element.docs.length;
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
            FirebaseAuth.instance.currentUser != null ? mainScreen(counter: counter,) : const loginScreen(),
            )
            );

          });
        }
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.grey,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(left: 15),
                height: 400,
                width: 400,
                child: Image.asset('assets/splash/new.PNG',fit: BoxFit.fill).animate().shimmer(duration: Duration(milliseconds: 1000),delay: Duration(milliseconds: 300)),
              ),
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.android,color: Colors.green,size: 20,),
                      SizedBox(width: 5,),
                      Text("Developed by",style: TextStyle(color: Colors.black,fontSize: 12,),),
                    ],
                  ),
                  const SizedBox(height: 3,),
                  const Text("MOHAMED FAHHAM",style: TextStyle(color: Colors.black,fontSize: 12,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
