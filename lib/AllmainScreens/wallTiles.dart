
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Model/wallTilesList.dart';
import '../Wall Tiles/Aqua/aquaHome.dart';
import '../Wall Tiles/Bamboo/bambooHome.dart';
import '../Wall Tiles/Inner Brick/innerBrickHome.dart';
import '../Wall Tiles/Matte/matteHome.dart';
import '../Wall Tiles/Mountain/mountainHome.dart';
import '../Wall Tiles/Plan Brick/planBrickHome.dart';
import '../Wall Tiles/Rock/rockHome.dart';
import '../Wall Tiles/Spider Rock/spiderRockHome.dart';
import '../Wall Tiles/Vaneer/vaneerHome.dart';
import '../Wall Tiles/Wood/woodHome.dart';

class wallTiles extends StatefulWidget {
  const wallTiles({super.key});

  @override
  State<wallTiles> createState() => _wallTilesState();
}

class _wallTilesState extends State<wallTiles> {



  static List<WallTilesList> wallTiles = [
    WallTilesList('Aqua', const AquaHome(url: 'assets/image.png')),
    WallTilesList('Bamboo', const BambooHome(url: 'assets/image.png')),
    WallTilesList('Inner Brick', const InnerBrickHome(url: 'assets/image.png')),
    WallTilesList('Matte', const MatteHome(url: 'assets/image.png')),
    WallTilesList('Mountain', const MountainHome(url: 'assets/image.png')),
    WallTilesList('Plan Brick', const PlanBrickHome(url: 'assets/image.png')),
    WallTilesList('Rock', const RockHome(url: 'assets/image.png')),
    WallTilesList('Spider Rock', const SpiderRockHome(url: 'assets/image.png')),
    WallTilesList('Vaneer', const VaneerHome(url: 'assets/image.png')),
    WallTilesList('Wood', const WoodHome(url: 'assets/image.png')),
  ];


  List<WallTilesList> display_List = List.from(wallTiles);

  void updateList(String value){
    setState(() {
      display_List = wallTiles.where((element) => element.wallTiles_name!.toLowerCase().contains(value.toLowerCase())).toList();
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
        title: Text("WALL TILES",style: GoogleFonts.aBeeZee(color: Colors.black),),
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
                    child: display_List[i].wallTile,
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
