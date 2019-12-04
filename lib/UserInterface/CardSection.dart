import 'dart:math';

import 'package:flutter/material.dart';
import 'ProfileCardItem.dart';
import 'package:tinder_card/Controller/AnimationUtils/CardsAnimation.dart';

Size backCardSize, contextSize;
double maxPerWidthBack = 0.9, maxPerHeightBack = 0.7;

class CardSection extends StatefulWidget {

  
  CardSection (BuildContext context)
  {
    contextSize = Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    backCardSize = Size(contextSize.width * maxPerWidthBack, contextSize.height * maxPerHeightBack);
  }

  @override  
  _CardSectionState createState() => _CardSectionState();
}

class _CardSectionState extends State<CardSection>  with SingleTickerProviderStateMixin
{
  int cardsCounter = 0;

  List<ProfileCardItem> cards = List();
  AnimationController _controller;

  @override
  void initState() {
    
    //create card
    for (cardsCounter = 0; cardsCounter < 3; cardsCounter++)
    {
      cards.add(ProfileCardItem(
        cardNum: cardsCounter + 1,
        numImages: 9, 
        onCardPanUpdateCallBack: _onFontCardPanUpdate, 
        onReleaseCallback: changeCardOder, 
        onCardRollBackCallBack: _onCardRollBack,
        onComplete: _onCardReleaseCompleted,
        )
      );
    }

    _controller = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _controller.addListener(() => setState( () {} ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[ 
          backCard(),
          frontCard()
        ],
      ),
    );
  }

  _onFontCardPanUpdate(double perbackCard)
  {
    setState(() {
      backCardSize = Size(
        contextSize.width * (maxPerWidthBack + (1 - maxPerWidthBack) * perbackCard * 2), 
        contextSize.height * (maxPerHeightBack + (1 - maxPerHeightBack) * perbackCard / 2)
      );
    });
  }

  _onCardReleaseCompleted() {
    setState(() {
      cards.removeAt(0);
    });
  }

  _onCardRollBack()
  {
    print("_onCardRollBack");
    _controller.stop();
    _controller.value = 0.0;
    _controller.forward(); 
  }

  frontCard()
  {
    return Align(
      child: SizedBox.fromSize(
        child: cards[0],
      )
    );
  }

  backCard()
  {
    return Align(      
      child: SizedBox.fromSize(
        size: _controller.status == AnimationStatus.forward ? CardsAnimation.backCardRollBackResizeAnim(_controller, backCardSize, Size(contextSize.width * maxPerWidthBack, contextSize.height * maxPerHeightBack)).value : backCardSize,
        child: cards[1],
      )
    );
  } 

  void changeCardOder() {
    cards.add(ProfileCardItem(
      cardNum: cardsCounter + 1,
      numImages: 3, 
      onCardPanUpdateCallBack: _onFontCardPanUpdate, 
      onReleaseCallback: changeCardOder, 
      onCardRollBackCallBack: _onCardRollBack,
      onComplete: _onCardReleaseCompleted,
      )
    );
    cardsCounter ++;      
    backCardSize = Size(contextSize.width * maxPerWidthBack, contextSize.height * maxPerHeightBack);
  }
}
