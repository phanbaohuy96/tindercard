import 'package:flutter/material.dart';

class CardsAnimation
{
  //Release card
  static Animation<Offset> frontCardDisappearOffsetAnim(AnimationController parent, Offset beginOffset)
  {
    return new Tween<Offset>
    (
      begin: beginOffset,
      end: new Offset(beginOffset.dx > 0 ? beginOffset.dx + 500.0 : beginOffset.dx - 500.0, 0.0) // Has swiped to the left or right?
    ).animate
    (
      new CurvedAnimation
      (
        parent: parent,
        curve: new Interval(0.0, 0.5, curve: Curves.easeIn)
      )
    );
  }

  //Rollback offset Card
  static Animation<Offset> frontCardRollBackOffsetAnim(AnimationController parent, Offset beginOffset)
  {
    return new Tween<Offset>
    (
      begin: beginOffset,
      end: new Offset(0.0, 0.0)
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
    return new Tween<double>
    (
      begin: beginRot,
      end: 0 
    ).animate
    (
      new CurvedAnimation
      (
        parent: parent,
        curve: new Interval(0.0, 0.5, curve: Curves.easeIn)
      )
    );
  }

  static Animation<Size> backCardRollBackResizeAnim(AnimationController parent, Size beginSize, Size endSize)
  {
    return new Tween<Size>
    (
      begin: beginSize,
      end: endSize 
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