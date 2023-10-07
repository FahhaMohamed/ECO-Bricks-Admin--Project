
import 'package:flutter/material.dart';

import '../../Wall Tiles/Aqua/aquaSold.dart';
import '../../Wall Tiles/Bamboo/bambooSold.dart';
import '../../Wall Tiles/Inner Brick/innerBrickSold.dart';
import '../../Wall Tiles/Matte/matteSold.dart';
import '../../Wall Tiles/Mountain/mountainSold.dart';
import '../../Wall Tiles/Plan Brick/planBrickSold.dart';
import '../../Wall Tiles/Rock/rockSold.dart';
import '../../Wall Tiles/Spider Rock/spiderRockSold.dart';
import '../../Wall Tiles/Vaneer/vaneerSold.dart';
import '../../Wall Tiles/Wood/woodSold.dart';

class wallTilesSold extends StatefulWidget {


  const wallTilesSold({super.key});

  @override
  State<wallTilesSold> createState() => _wallTilesSoldState();
}

class _wallTilesSoldState extends State<wallTilesSold> {


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
        isTapped ? isExpanded ? 60 : 70 : isExpanded ? 690 : 703,
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
                    'Wall Tiles',
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
                    'Wall Tiles',
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
                    aquaSold(),
                    SizedBox(height: 20,),
                    bambooSold(),
                    SizedBox(height: 20,),
                    innerBrickSold(),
                    SizedBox(height: 20,),
                    matteSold(),
                    SizedBox(height: 20,),
                    mountainSold(),
                    SizedBox(height: 20,),
                    planBrickSold(),
                    SizedBox(height: 20,),
                    rockSold(),
                    SizedBox(height: 20,),
                    spiderRockSold(),
                    SizedBox(height: 20,),
                    vaneerSold(),
                    SizedBox(height: 20,),
                    woodSold(),
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
