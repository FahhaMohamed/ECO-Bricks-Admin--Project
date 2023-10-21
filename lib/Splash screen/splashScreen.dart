
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../AllmainScreens/mainScreen.dart';
import '../Login screen/loginScreen.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen>
    with SingleTickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    Future.delayed(
        const Duration(milliseconds: 2000),()
        {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
          FirebaseAuth.instance.currentUser != null ? const mainScreen() : const loginScreen(),
            )
          );
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
              Colors.white,
              Colors.purple,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(child: SizedBox()),
            Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/splash/eco2.png'),fit: BoxFit.fill)
              ),
            ),
            const Expanded(child: SizedBox()),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.android,color: Colors.white,size: 20,),
                SizedBox(width: 5,),
                Text("Developed by",style: TextStyle(color: Colors.white,fontSize: 12,),),
              ],
            ),
            const SizedBox(height: 3,),
            const Text("MOHAMED FAHHAM",style: TextStyle(color: Colors.white,fontSize: 12,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
            const SizedBox(height: 26,),
          ],
        ),
      ),
    );
  }
}
