
import 'package:flutter/material.dart';

import '../../pavers/3D View/dViewSold.dart';
import '../../pavers/Bee Hive/beeHiveSold.dart';
import '../../pavers/Big Try Arc/bigTryArcSold.dart';
import '../../pavers/Cerb Stone/cerbStoneSold.dart';
import '../../pavers/Corel Shell/coralShellSold.dart';
import '../../pavers/Grass Paver/grassPaverSold.dart';
import '../../pavers/Hexa/hexaSold.dart';
import '../../pavers/I shape/iShapeSold.dart';
import '../../pavers/Oyel/oyalSold.dart';
import '../../pavers/Shell/shellSold.dart';
import '../../pavers/Square Polish/squarePolishSold.dart';
import '../../pavers/Square R/squareRSold.dart';
import '../../pavers/Square/squareSold.dart';
import '../../pavers/Star/starSold.dart';
import '../../pavers/Try Arc/tryArcSold.dart';
import '../../pavers/Zig Zag R/zigzagRSold.dart';
import '../../pavers/Zig Zag polish/zigzagPolishSold.dart';

class paversSold extends StatefulWidget {


  const paversSold({super.key});

  @override
  State<paversSold> createState() => _paversSoldState();
}

class _paversSoldState extends State<paversSold> {


  bool isTapped = true;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
          isTapped = !isTapped;
        });
      },
      onHighlightChanged: (value) {
        setState(() {
          isExpanded = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn,
        height:
        isTapped ? isExpanded ? 60 : 70 : isExpanded ? 1120 : 1123,
        width:  w*0.7,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.purple,
                Colors.grey.shade100,
              ]
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.shade200,
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: isTapped
            ? SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pavers',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w400),
                  ),
                  Icon(
                    isTapped
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: Colors.black,
                    size: 27,
                  ),
                ],
              ),
            ],
          ),
        )
            : SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pavers',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w400),
                  ),
                  Icon(
                    isTapped
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: Colors.black,
                    size: 27,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
               const SingleChildScrollView(
                child: Column(
                  children: [
                    iShapeSold(),
                    SizedBox(height: 20,),
                    squareRSold(),
                    SizedBox(height: 20,),
                    zigzagPolishSold(),
                    SizedBox(height: 20,),
                    squarePolishSold(),
                    SizedBox(height: 20,),
                    oyalSold(),
                    SizedBox(height: 20,),
                    zigzagRSold(),
                    SizedBox(height: 20,),
                    starSold(),
                    SizedBox(height: 20,),
                    bigTryArcSold(),
                    SizedBox(height: 20,),
                    coralShellSsold(),
                    SizedBox(height: 20,),
                    beeHiveSold(),
                    SizedBox(height: 20,),
                    cerbStoneSold(),
                    SizedBox(height: 20,),
                    dViewSold(),
                    SizedBox(height: 20,),
                    tryArcSold(),
                    SizedBox(height: 20,),
                    HexaSold(),
                    SizedBox(height: 20,),
                    squareSold(),
                    SizedBox(height: 20,),
                    shellSold(),
                    SizedBox(height: 20,),
                    grassPaverSold(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
