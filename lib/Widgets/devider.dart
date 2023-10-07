import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1.0,
      color: Colors.purple,
      thickness: 1.0,
    );
  }
}
