import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';

class signUpScreen extends StatefulWidget {
  const signUpScreen({super.key});

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {


  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  bool _isSecurePassword = true;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          color: Colors.white,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.width*0.02,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 2),
                  width: size.width*0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(2, 2),
                          blurRadius: 2,
                        )
                      ]
                  ),

                  child:TextField(
                    style: TextStyle(
                      decorationColor: Colors.pinkAccent.withOpacity(0.05),
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.6,
                    ),
                    controller: emailEditingController,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email,color: Colors.pinkAccent,),
                      hintText: 'Email',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 2),
                  width: size.width*0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        offset: Offset(2, 2),
                        blurRadius: 2,
                      )
                    ],
                  ),

                  child:TextField(
                    style: TextStyle(
                      decorationColor: Colors.pinkAccent.withOpacity(0.05),
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.7,
                    ),
                    controller: passwordEditingController,
                    cursorColor: Colors.black,
                    obscureText: _isSecurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      suffixIcon: togglePassword(),
                      icon: const Icon(Icons.lock,color: Colors.pinkAccent,),
                      hintText: 'Password',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.width*0.02,
                ),
                InkWell(
                  onTap: () async {
                    var email = emailEditingController.text.trim();
                    var password = passwordEditingController.text.trim();

                    if( email.isEmpty || password.isEmpty ){
                      Fluttertoast.showToast(msg: "Please fill all fields");
                      return;
                    }

                    ProgressDialog progressdialog = ProgressDialog(context, title: const Text('Signing up'), message: const Text('Please wait'));

                    progressdialog.show();


                      FirebaseAuth auth = FirebaseAuth.instance;
                      auth.createUserWithEmailAndPassword(email: email, password: password);

                      progressdialog.dismiss();

                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: size.width*0.8,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(2, 2),
                          blurRadius: 2,
                        )
                      ],
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.pinkAccent,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    alignment: Alignment.center,
                    child: const Text('REGISTER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.width*0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child:const Text(" Login",
                        style: TextStyle(
                          color: Colors.pinkAccent,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    )
                  ],
                ),
              ],
            ),
          ),
        ),
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
