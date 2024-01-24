import 'package:flutter/material.dart';

class CustomPersonIcon extends StatelessWidget {

  final double? outerIconSize;
  final double? innerIconSize;

  const CustomPersonIcon({super.key, this.outerIconSize = 45, this.innerIconSize = 24});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.circle_outlined,color: Colors.purple,size: outerIconSize,),
        Icon(Icons.perm_identity,color: Colors.purple,size: innerIconSize,),
      ],
    );
  }
}
