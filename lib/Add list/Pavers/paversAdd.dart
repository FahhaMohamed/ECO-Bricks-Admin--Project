
import 'package:flutter/material.dart';

import '../../pavers/3D View/dViewAdd.dart';
import '../../pavers/Bee Hive/beeHiveAdd.dart';
import '../../pavers/Big Try Arc/bigTryArcAdd.dart';
import '../../pavers/Cerb Stone/cerbStoneAdd.dart';
import '../../pavers/Corel Shell/coralShellAdd.dart';
import '../../pavers/Grass Paver/grassPaverAdd.dart';
import '../../pavers/Hexa/hexaAdd.dart';
import '../../pavers/I shape/iShapeAdd.dart';
import '../../pavers/Oyel/oyalAdd.dart';
import '../../pavers/Shell/shellAdd.dart';
import '../../pavers/Square Polish/squarePolishAdd.dart';
import '../../pavers/Square R/squareRAdd.dart';
import '../../pavers/Square/squareAdd.dart';
import '../../pavers/Star/starAdd.dart';
import '../../pavers/Try Arc/tryArcAdd.dart';
import '../../pavers/Zig Zag R/zigzagRAdd.dart';
import '../../pavers/Zig Zag polish/zigzagPolishAdd.dart';

class paversAdd extends StatefulWidget {


  const paversAdd({super.key});

  @override
  State<paversAdd> createState() => _paversAddState();
}

class _paversAddState extends State<paversAdd> {


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
                        iShapeAdd(),
                        SizedBox(height: 20,),
                        squareRAdd(),
                        SizedBox(height: 20,),
                        zigzagPolishAdd(),
                        SizedBox(height: 20,),
                        squarePolishAdd(),
                        SizedBox(height: 20,),
                        oyalAdd(),
                        SizedBox(height: 20,),
                        zigzagRAdd(),
                        SizedBox(height: 20,),
                        starAdd(),
                        SizedBox(height: 20,),
                        bigTryArcAdd(),
                        SizedBox(height: 20,),
                        coralShellAdd(),
                        SizedBox(height: 20,),
                        beeHiveAdd(),
                        SizedBox(height: 20,),
                        cerbStoneAdd(),
                        SizedBox(height: 20,),
                        dViewAdd(),
                        SizedBox(height: 20,),
                        tryArcAdd(),
                        SizedBox(height: 20,),
                        HexaAdd(),
                        SizedBox(height: 20,),
                        squareAdd(),
                        SizedBox(height: 20,),
                        shellAdd(),
                        SizedBox(height: 20,),
                        grassPaverAdd(),
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
