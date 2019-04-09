import 'dart:math';

import 'package:flutter/material.dart';
import 'ProfileCardItem.dart';
import 'package:tinder_card/Controller/AnimationUtils/CardsAnimation.dart';

List<Size> cardsSize = new List(2);
Size frontCardSize, contextSize;
double maxPerWidth = 0.99, maxPerHeight = 0.75;
double maxPerWidthBack = 0.9, maxPerHeightBack = 0.7;

class CardSection extends StatefulWidget {

  
  CardSection (BuildContext context)
  {
    contextSize = new Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    cardsSize[0] = new Size(contextSize.width * maxPerWidth, contextSize.height * maxPerHeight);
    cardsSize[1] = new Size(contextSize.width * maxPerWidthBack, contextSize.height * maxPerHeightBack);
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
      cards.add(new ProfileCardItem(cardsCounter + 1, 9, 0, _onCardPanUpdate, _onCardPanEnd));
    }

    frontCardAlign = new Alignment(0.0, 0.0);

    _controller = new AnimationController(duration: new Duration(milliseconds: 500), vsync: this);
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
          frontCard()
        ],
      ),
    );
  }

  _onCardPanUpdate(DragUpdateDetails details, BuildContext context)
  {
    setState(() {   
      frontCardAlign = new Alignment
      (
        frontCardAlign.x + 200 * details.delta.dx / MediaQuery.of(context).size.width,
        frontCardAlign.y + 60 * details.delta.dy / MediaQuery.of(context).size.height
      );

      //Animation resize backcard
      double newPerX = min(max(frontCardAlign.x, -frontCardAlign.x) * 0.01, 1);
      double newPerY = min(max(frontCardAlign.y * 4, -frontCardAlign.y * 4) * 0.01, 1);
      double newPer = max(newPerX, newPerY);      
      cardsSize[1] = new Size(contextSize.width * (maxPerWidthBack + (maxPerWidth - maxPerWidthBack) * newPer), contextSize.height * (maxPerHeightBack + (maxPerHeight - maxPerHeightBack) * newPer));

      frontCardRot = frontCardAlign.x / 10;
    });
  }

  _onCardPanEnd()
  {
    print("_onCardPanEnd");
    isRollBack = !(frontCardAlign.x >= 80.0 || frontCardAlign.x <= -80.0);
    _controller.stop();
    _controller.value = 0.0;
    _controller.forward();  
  }

  Animation<Alignment> cardAlignAnimationPanEnd()
  {
    return !isRollBack ? CardsAnimation.frontCardDisappearAlignmentAnim(_controller, frontCardAlign) : CardsAnimation.frontCardRollBackAlignmentAnim(_controller, frontCardAlign);
  }

  frontCard()
  {
    print("frontCard");

    return new Align(
      alignment: _controller.status == AnimationStatus.forward ? cardAlignAnimationPanEnd().value : frontCardAlign,      
      child: new Transform.rotate(
        angle: (pi / 180.0) * (_controller.status == AnimationStatus.forward && isRollBack ? CardsAnimation.frontCardRollBackRotAnim(_controller, frontCardRot).value : frontCardRot),
        child: new SizedBox.fromSize(
          size: cardsSize[0],
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
        size: cardsSize[1],
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

        cards[1] = new ProfileCardItem(cardsCounter + 1, 3, 0, _onCardPanUpdate, _onCardPanEnd);
        cardsCounter ++;
      }
      
      cardsSize[1] = new Size(contextSize.width * maxPerWidthBack, contextSize.height * maxPerHeightBack);
      frontCardAlign = defaultFrontCardAlign;
      frontCardRot = 0.0;
    });
  }
}
