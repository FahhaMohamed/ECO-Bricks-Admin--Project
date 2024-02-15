
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndialog/ndialog.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../mainScreen.dart';

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

    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: h,
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
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:  CrossAxisAlignment.center,
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
                                  color: Colors.black.withOpacity(0.5),
                                  offset: const Offset(2, 2),
                                  blurRadius: 5
                                )
                              ]
                          ),
                        ),
                        const SizedBox(height: 20,),
                         Text("Block by Block Lets Build the Nation",
                          style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 80,),
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(10),
                    width: w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
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
                        SizedBox(height: 20,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.purple.shade100,
                                offset: Offset(3, 3),
                                blurRadius: 3
                              )
                            ]
                          ),
                          child: TextFormField(
                            controller: emailEditingController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.purple,
                            style: TextStyle(
                                decorationColor: Colors.transparent,
                                letterSpacing: 0.7,
                                fontSize: 18,
                                color: Colors.black
                            ),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.purple),
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.purple)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.white)
                              ),
                              prefixIcon: Icon(Icons.perm_identity),
                              prefixIconColor: Colors.purple,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.purple
                                ),
                                borderRadius: BorderRadius.circular(20)
                              ),
                              labelText: 'Email address',

                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.purple.shade100,
                                    offset: Offset(3, 3),
                                    blurRadius: 3
                                )
                              ]
                          ),
                          child: TextFormField(
                            obscuringCharacter: '*',
                            textAlignVertical: TextAlignVertical.center,
                            controller: passwordEditingController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _isSecurePassword,
                            cursorColor: Colors.purple,
                            style: TextStyle(
                                decorationColor: Colors.transparent,
                                letterSpacing: 0.7,
                                fontSize: 18,
                                color: Colors.black
                            ),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.purple),
                              suffixIcon: togglePassword(),
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.purple)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.white)
                              ),
                              prefixIcon: const Icon(Icons.lock),
                              prefixIconColor: Colors.purple,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.purple
                                  ),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              labelText: 'Password',

                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        ZoomTapAnimation(
                          onTap: () async {


                            var email = emailEditingController.text.trim();
                            var password = passwordEditingController.text.trim();
                            startStreaming();

                            if(email.isEmpty||password.isEmpty){
                              //show error toast
                              Fluttertoast.showToast(msg: 'Please fill all fields');

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
                                //getToken();

                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                                  return mainScreen();
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
                            margin: EdgeInsets.only(left: 20,right: 20),
                            width: w,
                            height: 50,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.purple.shade200,
                                    offset: Offset(3, 3),
                                    blurRadius: 3
                                )
                              ],
                              color: Colors.purple.shade400,
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
                        SizedBox(height: 25,),
                        Container(
                          width: w,
                          child: const Align(
                            alignment: Alignment.bottomCenter,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                  ).animate().shakeX(delay: Duration(milliseconds: 150),duration: Duration(milliseconds: 500),amount: 2),
                  const Spacer(),
                  const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Address", style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                        Text("No: 213 | Mannar Road | Puttalam.", style: TextStyle(color: Colors.black,fontSize: 16),),
                        SizedBox(height: 10,)
                      ],
                    ),
                  ),
                ],
              ),
            )
          ),
        )
      ),
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
