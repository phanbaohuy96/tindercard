import 'dart:math';

import 'package:flutter/material.dart';
import 'ProfileCardItem.dart';
import 'package:tinder_card/Controller/AnimationUtils/CardsAnimation.dart';

Size backCardSize, contextSize;
double maxPerWidthBack = 0.9, maxPerHeightBack = 0.7;

class CardSection extends StatefulWidget {

  
  CardSection (BuildContext context)
  {
    contextSize = new Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    backCardSize = new Size(contextSize.width * maxPerWidthBack, contextSize.height * maxPerHeightBack);
  }

  @override  
  _CardSectionState createState() => _CardSectionState();
}

class _CardSectionState extends State<CardSection>  with SingleTickerProviderStateMixin
{
  int cardsCounter = 0;

  List<ProfileCardItem> cards = new List();
  AnimationController _controller;

  final Offset defaultFrontCardOffset = new Offset(0.0, 0.0);
  Offset frontCardOffset;
  double frontCardRot = 0.0;

  bool isRollBack = false;

  @override
  void initState() {
    
    //create card
    for (cardsCounter = 0; cardsCounter < 2; cardsCounter++)
    {
      cards.add(new ProfileCardItem(cardsCounter + 1, 9, _onCardPanUpdate, _onCardPanEnd));
    }

    frontCardOffset = new Offset(0.0, 0.0);

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
      if(_controller.status == AnimationStatus.forward)
        _controller.stop();
      frontCardOffset = new Offset
      (
        frontCardOffset.dx + 300 * details.delta.dx / MediaQuery.of(context).size.width,
        frontCardOffset.dy + 400 * details.delta.dy / MediaQuery.of(context).size.height
      );

      //Animation resize backcard
      double newPerX = min(max(frontCardOffset.dx, -frontCardOffset.dx) * 0.01, 1);
      double newPerY = min(max(frontCardOffset.dy , -frontCardOffset.dy) * 0.01, 1);
      double newPer = max(newPerX, newPerY);      
      backCardSize = new Size(
        contextSize.width * (maxPerWidthBack + (1 - maxPerWidthBack) * newPer * 2), 
        contextSize.height * (maxPerHeightBack + (1 - maxPerHeightBack) * newPer / 2)
      );

      frontCardRot = frontCardOffset.dx / 10;
    });
  }

  _onCardPanEnd()
  {
    print("_onCardPanEnd");
    isRollBack = !(frontCardOffset.dx >= 80.0 || frontCardOffset.dx <= -80.0);
    _controller.stop();
    _controller.value = 0.0;
    _controller.forward();  
  }

  Animation<Offset> cardAlignAnimationPanEnd()
  {
    return !isRollBack ? CardsAnimation.frontCardDisappearOffsetAnim(_controller, frontCardOffset) : CardsAnimation.frontCardRollBackOffsetAnim(_controller, frontCardOffset);
  }

  frontCard()
  {
    return new Container(
      child: new Transform.translate(
        offset: _controller.status == AnimationStatus.forward ? cardAlignAnimationPanEnd().value : frontCardOffset,
        child:  new Transform.rotate(
          angle: (pi / 180.0) * (_controller.status == AnimationStatus.forward && isRollBack ? CardsAnimation.frontCardRollBackRotAnim(_controller, frontCardRot).value : frontCardRot),
          child: new SizedBox.fromSize(
            child: cards[0],
          ),
        ),
      )
    );
  }

  backCard()
  {
    return new Align(      
      child: new Transform.translate(
        offset: defaultFrontCardOffset,
        child: new SizedBox.fromSize(
          size: (_controller.status == AnimationStatus.forward && isRollBack) ? CardsAnimation.backCardRollBackResizeAnim(_controller, backCardSize, new Size(contextSize.width * maxPerWidthBack, contextSize.height * maxPerHeightBack)).value : backCardSize,
          child: cards[1],
        )
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

        cards[1] = new ProfileCardItem(cardsCounter + 1, 3, _onCardPanUpdate, _onCardPanEnd);
        cardsCounter ++;
      }
      
      backCardSize = new Size(contextSize.width * maxPerWidthBack, contextSize.height * maxPerHeightBack);
      frontCardOffset = defaultFrontCardOffset;
      frontCardRot = 0.0;
    });
  }
}
