import 'package:flutter/material.dart';

class TinderCard extends StatefulWidget {
  final double width;
  final double height;
  final String imgURL;

  TinderCard({
    this.height,
    this.width,
    this.imgURL
  });


  @override
  _TinderCardState createState() => _TinderCardState(height: this.height, width: this.width, imgURL: this.imgURL);
}

class _TinderCardState extends State<TinderCard> {
  final double width;
  final double height;
  final String imgURL;
  final DecorationImage img;

  _TinderCardState({
    this.height,
    this.width,
    this.imgURL
  }) : img = new DecorationImage(
    image: new ExactAssetImage(imgURL),
    fit: BoxFit.cover
  );

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: this.width ,
      height: this.height ,
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(new Radius.circular(8.0)),
        image: this.img,
      ),
    );
  }
}