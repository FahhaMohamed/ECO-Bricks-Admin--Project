import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

  Widget AnimatedCustomList(BuildContext context, {required child, required int index}) {
    return AnimationConfiguration.staggeredList(
      position: index,
      delay: const Duration(milliseconds: 100),
      child: SlideAnimation(
        duration:
        const Duration(milliseconds: 2500),
        curve: Curves.fastLinearToSlowEaseIn,
        horizontalOffset: 30,
        verticalOffset: 300.0,
        child: FadeInAnimation(
          duration:
          const Duration(milliseconds: 2500),
          curve: Curves.fastLinearToSlowEaseIn, child: child,
        ),
      ),
    );
  }

