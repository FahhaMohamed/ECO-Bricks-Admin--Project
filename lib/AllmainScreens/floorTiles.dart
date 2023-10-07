
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Floor Tiles/FT 02/ft02Home.dart';
import '../Floor Tiles/FT 03/ft03Home.dart';
import '../Floor Tiles/FT 04/ft04Home.dart';
import '../Floor Tiles/FT 05/ft05Home.dart';
import '../Floor Tiles/FT 06/ft06Home.dart';
import '../Floor Tiles/FT O1/ft01Home.dart';
import '../Floor Tiles/Lines Step/linesStepHome.dart';
import '../Floor Tiles/Moon Face/moonFaceHome.dart';
import '../Floor Tiles/Oval Step/ovalStepHome.dart';
import '../Floor Tiles/Square Step/squareStepHome.dart';
import '../Floor Tiles/Syider Web/syiderWebHome.dart';
import '../Model/floorTilesList.dart';

class floorTiles extends StatefulWidget {
  const floorTiles({super.key});

  @override
  State<floorTiles> createState() => _floorTilesState();
}

class _floorTilesState extends State<floorTiles> {

  static List<FloorTilesList> floorTiles = [
    FloorTilesList('FT 01 Home', const FT01Home(url: 'assets/image.png')),
    FloorTilesList('FT 02 Home', const FT02Home(url: 'assets/image.png')),
    FloorTilesList('FT 03 Home', const FT03Home(url: 'assets/image.png')),
    FloorTilesList('FT 04 Home', const FT04Home(url: 'assets/image.png')),
    FloorTilesList('FT 05 Home', const FT05Home(url: 'assets/image.png')),
    FloorTilesList('FT 06 Home', const FT06Home(url: 'assets/image.png')),
    FloorTilesList('Lines Step Home', const LinesStepHome(url: 'assets/image.png')),
    FloorTilesList('Moon Face Home', const MoonFaceHome(url: 'assets/image.png')),
    FloorTilesList('Oval Step Home', const OvalStepHome(url: 'assets/image.png')),
    FloorTilesList('Square Step Home', const SquareStepHome(url: 'assets/image.png')),
    FloorTilesList('Spider Web Home', const SyiderWebHome(url: 'assets/image.png')),
  ];

  List<FloorTilesList> display_List = List.from(floorTiles);

  void updateList(String value){
    setState(() {
      display_List = floorTiles.where((element) => element.floorTiles_name!.toLowerCase().contains(value.toLowerCase())).toList();
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
        title: Text("FLOOR TILES",style: GoogleFonts.aBeeZee(color: Colors.black),),
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
                    child: display_List[i].floorTile,
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
