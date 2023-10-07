import 'package:flutter/material.dart';

class customContainer extends StatefulWidget {
  const customContainer({super.key});

  @override
  State<customContainer> createState() => _customContainerState();
}

class _customContainerState extends State<customContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 80,
      color: Colors.black,
    );
  }
}
