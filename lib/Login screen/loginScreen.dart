
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndialog/ndialog.dart';

import '../AllmainScreens/mainScreen.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  bool _isSecurePassword = true;

  late ConnectivityResult result;
  late StreamSubscription subscription;
  var isConnected = false;

  @override
  void initState()
  {
    super.initState();
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
    }
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
      body: SingleChildScrollView(
        child: Container(
          height: h,
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
          child: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20,),
                      Text("Welcome",
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.7,
                            shadows: [
                              Shadow(
                                color: Colors.purple.shade300,
                                offset: const Offset(2, 2),
                                blurRadius: 5
                              )
                            ]
                        ),
                      ),
                      const SizedBox(height: 20,),
                       Text("Block by Block Lets Build the Nation",
                        style: GoogleFonts.aBeeZee(color: Colors.purple,fontSize: 17,fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Address", style: TextStyle(color: Colors.white,fontSize: 18),),
                      Text("No: 213 | Mannar Road | Puttalam.", style: TextStyle(color: Colors.white,fontSize: 16),),
                      SizedBox(height: 10,)
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    height: h*0.4,
                    width: w*0.86,
                    child: Center(
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: h*0.345,
                                width: w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        offset: Offset(2, 2),
                                        blurRadius: 3
                                    ),
                                  ],

                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: h*0.07,),
                                    Container(
                                      padding: const EdgeInsets.only(left: 10,),
                                      width: w*0.76,
                                      height: h*0.046,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.purple.withOpacity(0.5),
                                              offset: Offset(2, 2),
                                              blurRadius: 3
                                          ),
                                        ],
                                      ),
                                      child: TextFormField(
                                        textAlignVertical: TextAlignVertical.center,
                                        controller: emailEditingController,
                                        keyboardType: TextInputType.emailAddress,
                                        cursorColor: Colors.purple,
                                        style: TextStyle(
                                            decorationColor: Colors.transparent,
                                            letterSpacing: 0.7,
                                            fontSize: 16,
                                            color: Colors.black
                                        ),
                                        decoration: const InputDecoration(
                                          icon: Icon(Icons.perm_identity),
                                          iconColor: Colors.purple,
                                          border: InputBorder.none,
                                          hintText: 'Email address',
                                          hintStyle: TextStyle(
                                          fontSize: 16
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: h*0.03,),
                                    Container(
                                      padding: const EdgeInsets.only(left: 10,),
                                      width: w*0.76,
                                      height: h*0.046,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.purple.withOpacity(0.5),
                                              offset: Offset(2, 2),
                                              blurRadius: 3
                                          ),
                                        ],
                                      ),
                                      child: TextFormField(
                                        textAlignVertical: TextAlignVertical.center,
                                        controller: passwordEditingController,
                                        keyboardType: TextInputType.visiblePassword,
                                        obscureText: _isSecurePassword,
                                        cursorColor: Colors.purple,
                                        style: TextStyle(
                                            decorationColor: Colors.transparent,
                                            letterSpacing: 0.7,
                                            fontSize: 16,
                                            color: Colors.black
                                        ),
                                        decoration: InputDecoration(
                                            suffixIcon: togglePassword(),
                                            icon: const Icon(Icons.lock),
                                            iconColor: Colors.purple,
                                            border: InputBorder.none,
                                            hintText: 'Password',
                                            hintStyle: const TextStyle(
                                                fontSize: 16
                                            )
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: h*0.03,),
                                    GestureDetector(
                                      onTap: () async {

                                        var email = emailEditingController.text.trim();
                                        var password = passwordEditingController.text.trim();
                                        startStreaming();

                                        if(email.isEmpty||password.isEmpty){
                                          //show error toast
                                          Fluttertoast.showToast(msg: 'Please fill all fields');

                                          return;
                                        }
                                        else if(isConnected == false)
                                          {
                                            Fluttertoast.showToast(msg: 'Please check your internet connection');

                                            return;
                                          }
                                        else if(email!= "ecobricks@gmail.com" && password!= "ebt18600"){
                                          //show error toast
                                          Fluttertoast.showToast(msg: 'Invalid Email address and Password');

                                          return;
                                        }
                                        else if(email!= "ecobricks@gmail.com"){
                                          //show error toast
                                          Fluttertoast.showToast(msg: 'Invalid Email address');

                                          return;
                                        }
                                        else if(password!= "ebt18600"){
                                          //show error toast
                                          Fluttertoast.showToast(msg: 'Wrong password');

                                          return;
                                        }


                                        //request to firebase auth
                                        ProgressDialog progressdialog = ProgressDialog(context, title: Text('Logging In'), message: Text('Please wait'),);
                                        progressdialog.show();

                                        try{

                                          FirebaseAuth auth = FirebaseAuth.instance;

                                          UserCredential usercredential = await auth.signInWithEmailAndPassword(email: email, password: password);

                                          if(usercredential.user!=null){

                                            progressdialog.dismiss();

                                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                                              return const mainScreen();
                                            }));
                                          }
                                        }

                                        on FirebaseAuthException catch(e){

                                          progressdialog.dismiss();

                                          if(e.code=='user-not-found'){

                                            Fluttertoast.showToast(msg: 'User not found');

                                          }else if(e.code=='wrong-password'){

                                            Fluttertoast.showToast(msg: 'Wrong Password');

                                          }

                                        }
                                        catch(e){

                                            Fluttertoast.showToast(msg: 'Something went wrong');
                                            progressdialog.dismiss();
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 2),
                                        width: w*0.76,
                                        height: h*0.05,
                                        decoration: BoxDecoration(
                                          color: Colors.purple,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Login",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.8
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: h*0.015,),
                                    Container(
                                      padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                                      width: w,
                                      height: h*0.046,
                                      child: const Align(
                                        alignment: Alignment.bottomCenter,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children:[
                                              Icon(Icons.info_outline_rounded,color: Colors.black,size: 20,),
                                              SizedBox(width: 4,),
                                              Text(
                                                "This App only for Company employees",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    letterSpacing: 0.5
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                  height: h*0.09,
                                  width: h*0.09,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(60),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.purple.withOpacity(0.5),
                                          offset: Offset(2, 2),
                                          blurRadius: 3
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(60),
                                          image: const DecorationImage(image: AssetImage('assets/icon/icon.jpg'))
                                      ),
                                    ),
                                  )
                              ),
                              ),
                          ],
                        )
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
      )
    );
  }
  Widget togglePassword (){
    return IconButton(onPressed: (){
      setState(() {
        _isSecurePassword = !_isSecurePassword;
      });
    }, icon:_isSecurePassword ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
      color: Colors.grey,
    );
  }
}
