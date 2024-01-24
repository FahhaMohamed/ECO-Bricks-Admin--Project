
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Widget CarouselWidget (BuildContext context,{required List<String> list}) {
  return Container(
    child: CarouselSlider(
      items: list.map((index) {
        return Container(
          margin: EdgeInsets.only(top: 5,bottom: 10),
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(index),
              fit: BoxFit.fill
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(3, 3),
                blurRadius: 3
              )
            ]
          ),
        );
      }).toList(),
      options: CarouselOptions(
        autoPlayInterval: Duration(milliseconds: 2000),
        autoPlayAnimationDuration: Duration(milliseconds: 1500),
        viewportFraction: 0.65,
        enlargeCenterPage: true,
        autoPlay: true,
        height: 210
      ),
    ),
  );
}