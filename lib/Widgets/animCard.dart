import 'package:flutter/material.dart';

class AnimCard extends StatefulWidget {
  final Color color;
  final int amount;
  final String url;
  final String title;
  final String num;
  final String numEng;
  final String content;

  const AnimCard(this.color,this.amount,this.url,this.title, this.num, this.numEng, this.content, {super.key});

  @override
  _AnimCardState createState() => _AnimCardState();
}

class _AnimCardState extends State<AnimCard> {
  var padding = 150.0;
  var bottomPadding = 0.0;


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPadding(
          padding: EdgeInsets.only(top: padding, bottom: bottomPadding),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.fastLinearToSlowEaseIn,
          child: Container(
            child: CardItem(
              widget.color,
              widget.amount,
              widget.url,
              widget.title,
              widget.num,
              widget.numEng,
              widget.content,
                  () {
                setState(() {
                  padding = padding == 0 ? 150.0 : 0.0;
                  bottomPadding = bottomPadding == 0 ? 0 : 0.0;
                });
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.only(right: 20, left: 20, top: 200),
            height: 80,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2), blurRadius: 30)
              ],
              color: Colors.grey.shade200.withOpacity(1.0),
              borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10,),
                    Image.asset(widget.url),
                  ],
                ),
                Center(child: Text(widget.title,style: const TextStyle(color: Colors.black,fontSize: 20),)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CardItem extends StatelessWidget {
  final Color color;
  final int amount;
  final String url;
  final String title;
  final String num;
  final String numEng;
  final String content;
  final onTap;

  CardItem(this.color,this.amount,this.url,this.title, this.num, this.numEng, this.content, this.onTap);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 26),
          height: 100,
          width: width,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2), blurRadius: 25),
            ],
            color: color.withOpacity(1.0),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Align(
                    alignment: Alignment.topRight,
                    child: Icon(Icons.arrow_circle_down,color: Colors.white,size: 40,),
                ),
                Text("Available items: $amount",style: const TextStyle(color: Colors.white,fontSize: 18),)
              ],
            ),
          ),
        ),
        );
    }
}