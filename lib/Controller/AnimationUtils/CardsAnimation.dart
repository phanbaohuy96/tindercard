import 'package:flutter/material.dart';

class CardsAnimation
{
  //Release card
  static Animation<Alignment> frontCardDisappearAlignmentAnim(AnimationController parent, Alignment beginAlign)
  {
    return new AlignmentTween
    (
      begin: beginAlign,
      end: new Alignment(beginAlign.x > 0 ? beginAlign.x + 150.0 : beginAlign.x - 150.0, 0.0) // Has swiped to the left or right?
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