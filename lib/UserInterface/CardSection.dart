import 'dart:math';

import 'package:flutter/material.dart';
import 'ProfileCardItem.dart';

List<Size> cardsSize = new List(2);
Size frontCardSize;


class CardSection extends StatefulWidget {
  
  CardSection (BuildContext context)
  {
    frontCardSize = new Size(MediaQuery.of(context).size.width * 0.99, MediaQuery.of(context).size.height * 0.75);
  }

  @override  
  _CardSectionState createState() => _CardSectionState();
}

class _CardSectionState extends State<CardSection>  with SingleTickerProviderStateMixin
{
  int cardsCounter = 0;

  List<ProfileCardItem> cards = new List();
  AnimationController _controller;

  final Alignment defaultFrontCardAlign = new Alignment(0.0, 0.0);
  Alignment frontCardAlign;
  double frontCardRot = 0.0;

  bool isRollBack = false;

  @override
  void initState() {
    
    //create card
    for (cardsCounter = 0; cardsCounter < 2; cardsCounter++)
    {
      cards.add(new ProfileCardItem(cardsCounter + 1));
    }

    frontCardAlign = new Alignment(0.0, 0.0);

    _controller = new AnimationController(duration: new Duration(milliseconds: 700), vsync: this);
    _controller.addListener(() => setState( () {} ));
    _controller.addStatusListener((AnimationStatus status)
    {
      if(status == AnimationStatus.completed) changeCardOder();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Stack(
        children: <Widget>[ 
          backCard(),
          frontCard(),
          new SizedBox.expand(
            child: new GestureDetector(
              onPanUpdate: (DragUpdateDetails details)
              {
                setState(() {

                  print("onPanUpdate : " );

                  frontCardAlign = new Alignment
                  (
                    frontCardAlign.x + 200 * details.delta.dx / MediaQuery.of(context).size.width,
                    frontCardAlign.y + 40 * details.delta.dy / MediaQuery.of(context).size.height
                  );

                  frontCardRot = frontCardAlign.x / 10;
                });
              },
              onPanEnd: (_) {
                isRollBack = !(frontCardAlign.x >= 80.0 || frontCardAlign.x <= -80.0);
                _controller.stop();
                _controller.value = 0.0;
                _controller.forward();  
              },
            ),
          )
        ],
      ),
    );
  }

  Animation<Alignment> cardAlignAnimationPanEnd()
  {
    return !isRollBack ? CardsAnimation.frontCardDisappearAlignmentAnim(_controller, frontCardAlign) : CardsAnimation.frontCardRollBackAlignmentAnim(_controller, frontCardAlign);
  }

  frontCard()
  {
    return new Align(
      alignment: _controller.status == AnimationStatus.forward ? cardAlignAnimationPanEnd().value : frontCardAlign,      
      child: new Transform.rotate(
        angle: (pi / 180.0) * (_controller.status == AnimationStatus.forward && isRollBack ? CardsAnimation.frontCardRollBackRotAnim(_controller, frontCardRot).value : frontCardRot),
        child: new SizedBox.fromSize(
          size: frontCardSize,
          child: cards[0],
        ),
      )
    );  
  }

  backCard()
  {
    return new Align(
      alignment: defaultFrontCardAlign,
      child: new SizedBox.fromSize(
        size: frontCardSize,
        child: cards[1],
      ),
    );
  } 

  void changeCardOder() {
    setState(() {
      if(!isRollBack)
      {
        var temp = cards[0];
        cards[0] = cards[1];
        cards[1] = temp;

        cards[1] = new ProfileCardItem(cardsCounter + 1);
        cardsCounter ++;
      }
      
      frontCardAlign = defaultFrontCardAlign;
      frontCardRot = 0.0;
    });
  }
}

class CardsAnimation
{
  //Release card
  static Animation<Alignment> frontCardDisappearAlignmentAnim(AnimationController parent, Alignment beginAlign)
  {
    print("frontCardDisappearAlignmentAnim");
    return new AlignmentTween
    (
      begin: beginAlign,
      end: new Alignment(beginAlign.x > 0 ? beginAlign.x + 60.0 : beginAlign.x - 60.0, 0.0) // Has swiped to the left or right?
    ).animate
    (
      new CurvedAnimation
      (
        parent: parent,
        curve: new Interval(0.0, 0.5, curve: Curves.easeIn)
      )
    );
  }

  //Rollback alignment Card
  static Animation<Alignment> frontCardRollBackAlignmentAnim(AnimationController parent, Alignment beginAlign)
  {
    print("frontCardDisappearAlignmentAnim");
    return new AlignmentTween
    (
      begin: beginAlign,
      end: new Alignment(0.0, 0.0) // Has swiped to the left or right?
    ).animate
    (
      new CurvedAnimation
      (
        parent: parent,
        curve: new Interval(0.0, 0.5, curve: Curves.easeIn)
      )
    );
  }

  //Rollback rotation Card
  static Animation<double> frontCardRollBackRotAnim(AnimationController parent, double beginRot)
  {
    print("frontCardDisappearAlignmentAnim");
    return new Tween<double>
    (
      begin: beginRot,
      end: 0 // Has swiped to the left or right?
    ).animate
    (
      new CurvedAnimation
      (
        parent: parent,
        curve: new Interval(0.0, 0.5, curve: Curves.easeIn)
      )
    );
  }

}