
import 'package:flutter/material.dart';

import '../../Wall Tiles/Aqua/aquaAdd.dart';
import '../../Wall Tiles/Bamboo/bambooAdd.dart';
import '../../Wall Tiles/Inner Brick/innerBrick.dart';
import '../../Wall Tiles/Matte/matteAdd.dart';
import '../../Wall Tiles/Mountain/mountainAdd.dart';
import '../../Wall Tiles/Plan Brick/planBrickAdd.dart';
import '../../Wall Tiles/Rock/rockAdd.dart';
import '../../Wall Tiles/Spider Rock/spiderRockAdd.dart';
import '../../Wall Tiles/Vaneer/vaneerAdd.dart';
import '../../Wall Tiles/Wood/woodAdd.dart';

class wallTilesAdd extends StatefulWidget {


  const wallTilesAdd({super.key});

  @override
  State<wallTilesAdd> createState() => _wallTilesAddState();
}

class _wallTilesAddState extends State<wallTilesAdd> {


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
                    aquaAdd(),
                    SizedBox(height: 20,),
                    bambooAdd(),
                    SizedBox(height: 20,),
                    innerBrickAdd(),
                    SizedBox(height: 20,),
                    matteAdd(),
                    SizedBox(height: 20,),
                    mountainAdd(),
                    SizedBox(height: 20,),
                    planBrickAdd(),
                    SizedBox(height: 20,),
                    rockAdd(),
                    SizedBox(height: 20,),
                    spiderRockAdd(),
                    SizedBox(height: 20,),
                    vaneerAdd(),
                    SizedBox(height: 20,),
                    woodAdd(),
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
