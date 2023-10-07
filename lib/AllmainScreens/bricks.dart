
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndialog/ndialog.dart';

import '../Widgets/animCard.dart';

class bricks extends StatefulWidget {
  const bricks({super.key});

  @override
  State<bricks> createState() => _bricksState();
}

class _bricksState extends State<bricks> {

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }


  int interAmount = 0;
  int ashAmount = 0;


  fetchDatabaseList() async {

    var inter = await FirebaseFirestore.instance.collection('Bricks').doc('Interlock Bricks');
    var flyAsh = await FirebaseFirestore.instance.collection('Bricks').doc('Fly Ash Bricks');

    inter.get().then((inter) {
      setState(() {
        interAmount = inter['amount'];
      });
    });
    flyAsh.get().then((flyAsh){
      setState(() {
        ashAmount = flyAsh['amount'];
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
        centerTitle: false,
        backgroundColor: Colors.grey.shade100,
        title: Text("BRICKS",style: GoogleFonts.aBeeZee(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20,right: 20),
              width: w,
              height: w*0.45,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(image: AssetImage('assets/Screenshot.jpg'),fit: BoxFit.cover)
              ),
            ),
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: w*0.24,),
                    AnimCard(Colors.deepPurple, interAmount, 'assets/interlocking-brick.png', 'Interlock Bricks', '', '', ''),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: w*0.8,),
                    AnimCard(Colors.deepPurple, ashAmount, 'assets/images-products-flyash.gif', 'Fly ash Bricks', '', '', ''),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
