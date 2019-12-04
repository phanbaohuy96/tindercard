import 'package:flutter/material.dart';

class CardsAnimation
{
  //Release card
  static Animation<Offset> frontCardDisappearOffsetAnim(AnimationController parent, Offset beginOffset)
  {
    return Tween<Offset>
    (
      begin: beginOffset,
      end: Offset(beginOffset.dx > 0 ? beginOffset.dx + 500.0 : beginOffset.dx - 500.0, 0.0) // Has swiped to the left or right?
    ).animate
    (
      CurvedAnimation
      (
        parent: parent,
        curve: Interval(0.0, 0.5, curve: Curves.easeIn)
      )
    );
  }

  //Rollback offset Card
  static Animation<Offset> frontCardRollBackOffsetAnim(AnimationController parent, Offset beginOffset)
  {
    return Tween<Offset>
    (
      begin: beginOffset,
      end: Offset(0.0, 0.0)
    ).animate
    (
      CurvedAnimation
      (
        parent: parent,
        curve: Interval(0.0, 0.5, curve: Curves.easeIn)
      )
    );
  }

  //Rollback rotation Card
  static Animation<double> frontCardRollBackRotAnim(AnimationController parent, double beginRot)
  {
    return Tween<double>
    (
      begin: beginRot,
      end: 0 
    ).animate
    (
      CurvedAnimation
      (
        parent: parent,
        curve: Interval(0.0, 0.5, curve: Curves.easeIn)
      )
    );
  }

  static Animation<Size> backCardRollBackResizeAnim(AnimationController parent, Size beginSize, Size endSize)
  {
    return Tween<Size>
    (
      begin: beginSize,
      end: endSize 
    ).animate
    (
      CurvedAnimation
      (
        parent: parent,
        curve: Interval(0.0, 0.5, curve: Curves.easeIn)
      )
    );
  }

}