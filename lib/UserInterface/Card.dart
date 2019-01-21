import 'package:flutter/material.dart';
import 'package:tinder_card/UserInterface/SliderStack.dart';
import 'package:tinder_card/Control/data.dart';
import 'CardItem.dart';

class TinderCard extends StatefulWidget {

  final BuildContext mContext;

  TinderCard({
    @required this.mContext
  });

  @override
  _TinderCardState createState() => _TinderCardState(mContext: mContext);
}

class _TinderCardState extends State<TinderCard> with TickerProviderStateMixin{

  final BuildContext mContext;

  _TinderCardState({
    this.mContext
  });

  AnimationController _buttonController;
  Animation<double> aniRotate;
  Animation<double> aniRight;
  Animation<double> aniBottom;
  Animation<double> aniWidth;

  int flag = 0;

  //List data = imageData;
  List selectedData = [];
  void initState() {
    super.initState();

    _buttonController = new AnimationController(duration: new Duration(milliseconds: 1000), vsync: this);

    aniRotate = new Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    aniRotate.addListener(() {
      setState(() {
        if (aniRotate.isCompleted) {
          var i = data.removeLast();
          data.insert(0, i);

          _buttonController.reset();
        }
      });
    });

    aniRight = new Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    aniBottom = new Tween<double>(
      begin: 15.0,
      end: 100.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    aniWidth = new Tween<double>(
      begin: 20.0,
      end: 25.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  Future<Null> _swipeAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }

  dismissImg(DecorationImage img) {
    setState(() {
      data.remove(img);
    });
  }

  addImg(DecorationImage img) {
    setState(() {
      data.remove(img);
      selectedData.add(img);
    });
  }

  swipeRight() {
    if (flag == 0)
      setState(() {
        flag = 1;
      });
    _swipeAnimation();
  }

  swipeLeft() {
    if (flag == 1)
      setState(() {
        flag = 0;
      });
    _swipeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    
    var dataLength = data.length;
    return new Container(
      child: dataLength > 0
              ? new Stack(
                  alignment: AlignmentDirectional.center,
                  children: data.map((item) {
                    if (data.indexOf(item) == dataLength - 1) {
                      return cardItem(
                          item,
                          aniBottom.value,
                          aniRight.value,
                          0.0,
                          aniRotate.value,
                          aniRotate.value < -10 ? 0.1 : 0.0,
                          mContext,
                          dismissImg,
                          flag,
                          addImg,
                          swipeRight,
                          swipeLeft);
                    } else {
                      return cardItem(
                        item,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        mContext,
                        null,
                        0,
                        null,
                        null,
                        null);
                    }
                  }).toList())
              : new Center(
                child: new Text("Out of stock",
                  style: new TextStyle(color: Colors.blueAccent, fontSize: 30.0)),
              )
              
    );
  }
}