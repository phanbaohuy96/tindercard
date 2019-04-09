import 'package:flutter/material.dart';
import 'SliderStack.dart';

class ProfileCardItem extends StatelessWidget {

  final int cardNum;
  List<String> imageList = new List();
  int selectedIdx, numImages;
  final Function onCardPanUpdate, onCardPanEnd;
  ProfileCardItem(this.cardNum, this.numImages, this.selectedIdx, this.onCardPanUpdate, this.onCardPanEnd);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: new Stack(
        children: <Widget>[
          //Create a picture
          new SizedBox.expand(
            child: new Material(              
              borderRadius: new BorderRadius.circular(12.0),
              child: new Image.asset('data/images/cf1.JPG', fit: BoxFit.cover),
            ),
          ),

          //make effect gradient from center widget to end
          new SizedBox.expand(
            child: new Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  colors: [Colors.transparent, Colors.black54],
                  begin: Alignment.center,
                  end: Alignment.bottomCenter
                )
              ),
            ),
          ),

          //Create descristion for image
          new Align(
            alignment: Alignment.bottomLeft,
            child: new Container(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text('Card number $cardNum', style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w700)),
                  new Padding(padding: new EdgeInsets.only(bottom: 8.0)),
                  new Text('A short description.', textAlign: TextAlign.start, style: new TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
          new SliderStack(
            new Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.015), 
            numImages, 
            selectedIdx
          ),
          new GestureDetector(
            onPanUpdate: (details) => onCardPanUpdate(details, context),
            onPanEnd: (_) => onCardPanEnd(),
          )
        ],
      ),
    );
  }
}