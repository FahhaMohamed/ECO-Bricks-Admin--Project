
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Model/paversList.dart';
import '../pavers/3D View/3dViewHome.dart';
import '../pavers/Bee Hive/beeHiveHome.dart';
import '../pavers/Big Try Arc/bigTryArcHome.dart';
import '../pavers/Cerb Stone/cerbStoneHome.dart';
import '../pavers/Corel Shell/corelShellHome.dart';
import '../pavers/Grass Paver/grassPaverHome.dart';
import '../pavers/Hexa/hexaHome.dart';
import '../pavers/I shape/iShapeHome.dart';
import '../pavers/Oyel/oyalHome.dart';
import '../pavers/Shell/shellHome.dart';
import '../pavers/Square Polish/squarePolishHome.dart';
import '../pavers/Square R/squareRHome.dart';
import '../pavers/Square/squareHome.dart';
import '../pavers/Star/starHome.dart';
import '../pavers/Try Arc/tryArcHome.dart';
import '../pavers/Zig Zag R/zigzagRHome.dart';
import '../pavers/Zig Zag polish/zigzagPolishHome.dart';

class pavers extends StatefulWidget {
  const pavers({super.key});

  @override
  State<pavers> createState() => _paversState();
}

class _paversState extends State<pavers> {



  static List<PaversList> pavers = [
    PaversList("i Shape Home", const iShapeHome(url: 'assets/image.png'),),
    PaversList("square R Home", const squareRHome(url: 'assets/image.png'),),
    PaversList("zig zag Polish Home", const zigzagPolishHome(url: 'assets/image.png'),),
    PaversList("square Polish Home", const squarePolishHome(url: 'assets/image.png'),),
    PaversList("oyal Home", const oyalHome(url: 'assets/image.png'),),
    PaversList("zig zag R Home", const zigzagRHome(url: 'assets/image.png'),),
    PaversList("star Home", const starHome(url: 'assets/image.png'),),
    PaversList("big Try Arc Home", const bigTryArcHome(url: 'assets/image.png'),),
    PaversList("corel Shell Home", const corelShellHome(url: 'assets/image.png'),),
    PaversList("bee Hive Home", const beeHiveHome(url: 'assets/image.png'),),
    PaversList("cerb Stone Home", const cerbStoneHome(url: 'assets/image.png'),),
    PaversList("v shape Home", const dViewHome(url: 'assets/image.png'),),
    PaversList("try Arc Home", const tryArcHome(url: 'assets/image.png'),),
    PaversList("hexa Home", const hexaHome(url: 'assets/image.png'),),
    PaversList("square Home", const squareHome(url: 'assets/image.png'),),
    PaversList("shell Home", const shellHome(url: 'assets/image.png'),),
    PaversList("grass Paver Home", const grassPaverHome(url: 'assets/image.png'),),
  ];


  List<PaversList> display_List = List.from(pavers);

  void updateList(String value){
    setState(() {
      display_List = pavers.where((element) => element.pavers_name!.toLowerCase().contains(value.toLowerCase())).toList();
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
        title: Text("PAVERS",style: GoogleFonts.aBeeZee(color: Colors.black),),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 2),
              width: w*0.8,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow:[
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: const Offset(10, 10),
                      blurRadius: 20,
                    )
                  ],
              ),

              child:TextField(
                onChanged: (value) => updateList(value),
                style: TextStyle(
                  color: Colors.black,
                  decorationColor: Colors.pinkAccent.withOpacity(0.05),
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.7,
                ),
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.search,color: Colors.grey,),
                  hintText: ' Search...',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 30,),
            Expanded(
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: display_List.length,
                itemBuilder: (BuildContext context, i) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    child: display_List[i].paver,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
