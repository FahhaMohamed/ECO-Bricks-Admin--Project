
import 'package:flutter/material.dart';

import '../../Floor Tiles/FT 02/ft02Add.dart';
import '../../Floor Tiles/FT 02/ft02Sold.dart';
import '../../Floor Tiles/FT 03/ft03.dart';
import '../../Floor Tiles/FT 03/ft03Sold.dart';
import '../../Floor Tiles/FT 04/ft04.dart';
import '../../Floor Tiles/FT 04/ft04Sold.dart';
import '../../Floor Tiles/FT 05/ft05.dart';
import '../../Floor Tiles/FT 05/ft05Sold.dart';
import '../../Floor Tiles/FT 06/ft06.dart';
import '../../Floor Tiles/FT 06/ft06Sold.dart';
import '../../Floor Tiles/FT O1/ft01Add.dart';
import '../../Floor Tiles/FT O1/ft01Sold.dart';
import '../../Floor Tiles/Lines Step/lineStepAdd.dart';
import '../../Floor Tiles/Lines Step/linesStepSold.dart';
import '../../Floor Tiles/Moon Face/moonFaceAdd.dart';
import '../../Floor Tiles/Moon Face/moonFaceSold.dart';
import '../../Floor Tiles/Oval Step/ovalStepAdd.dart';
import '../../Floor Tiles/Oval Step/ovalStepSold.dart';
import '../../Floor Tiles/Square Step/squareStep.dart';
import '../../Floor Tiles/Square Step/squareStepSold.dart';
import '../../Floor Tiles/Syider Web/syiderWebAdd.dart';
import '../../Floor Tiles/Syider Web/syiderWebSold.dart';

class floorTilesSold extends StatefulWidget {


  const floorTilesSold({super.key});

  @override
  State<floorTilesSold> createState() => _floorTilesSoldState();
}

class _floorTilesSoldState extends State<floorTilesSold> {


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
        isTapped ? isExpanded ? 60 : 70 : isExpanded ? 750 : 763,
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
                    'Floor Tiles',
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
                    'Floor Tiles',
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
                    ft01Sold(),
                    SizedBox(height: 20,),
                    ft02Sold(),
                    SizedBox(height: 20,),
                    ft03Sold(),
                    SizedBox(height: 20,),
                    ft04Sold(),
                    SizedBox(height: 20,),
                    ft05Sold(),
                    SizedBox(height: 20,),
                    ft06Sold(),
                    SizedBox(height: 20,),
                    linesStepSold(),
                    SizedBox(height: 20,),
                    moonFaceSold(),
                    SizedBox(height: 20,),
                    ovalStepSold(),
                    SizedBox(height: 20,),
                    squareStepSold(),
                    SizedBox(height: 20,),
                    spyiderWebSold(),
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
