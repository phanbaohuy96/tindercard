import 'package:flutter/material.dart';
import 'SliderStack.dart';
import 'package:tinder_card/Controller/AnimationUtils/CardsAnimation.dart';
import 'dart:math';

class ProfileCardItem extends StatefulWidget {

  final int cardNum, numImages;
  final List<String> imageList = new List();
  final Function onCardPanUpdateCallBack, onReleaseCallback, onCardRollBackCallBack;


  ProfileCardItem(this.cardNum, this.numImages, this.onCardPanUpdateCallBack, this.onReleaseCallback, this.onCardRollBackCallBack);
  @override
  _ProfileCardItemState createState() {
    print("createState" );
    return _ProfileCardItemState();
  }
}

class _ProfileCardItemState extends State<ProfileCardItem> with SingleTickerProviderStateMixin {

  Size _contextSize;
  int _selectedIdx = 0;
  bool _isRollback;
  Offset _offset;
  double _rotation;

  AnimationController _controller;

  @override
  void initState()
  {
    _offset = new Offset(0.0, 0.0);
    _rotation = 0.0;
    _isRollback = true;

    _controller = new AnimationController(duration: new Duration(milliseconds: 500), vsync: this);
    _controller.addListener(() => setState(() { }));
    _controller.addStatusListener((status) => _onComplete(status));

    super.initState();    
    _selectedIdx = 0;
    print("_selectedIdx = $_selectedIdx" );
  }


  _onComplete(AnimationStatus status)
  {
    if(status == AnimationStatus.completed)
    {
      if(_isRollback)
      {
        _offset = new Offset(0.0, 0.0);
        _rotation = 0.0;
      }
      _isRollback = true;
    }
  }

  _onCardPanUpdate(DragUpdateDetails details, BuildContext context)
  {
    setState(() {
      //translate card
      _offset = new Offset(
        _offset.dx + 400 * details.delta.dx / MediaQuery.of(context).size.width,
        _offset.dy + 600 * details.delta.dy / MediaQuery.of(context).size.height
      );

      //rotate card
      _rotation = _offset.dx / 500;
    });
    
    //Animation resize backcard
    double newPerX = min(max(_offset.dx, -_offset.dx) * 0.01, 1);
    double newPerY = min(max(_offset.dy , -_offset.dy) * 0.01, 1);

    widget.onCardPanUpdateCallBack(max(newPerX, newPerY));
  }

  _onCardPanEnd()
  {
    _isRollback = !(_offset.dx >= 80.0 || _offset.dx <= -80.0);
    if(_isRollback) widget.onCardRollBackCallBack();
    else widget.onReleaseCallback();
    _controller.stop();
    _controller.value = 0.0;
    _controller.forward();
  }

  _onTapUp(TapUpDetails details, BuildContext context)
  {
    if(_contextSize == null)
      _contextSize = MediaQuery.of(context).size;
    setState(() {
      if(details.globalPosition.dx < _contextSize.width / 2.0)
      {
        //previous image
        if (_selectedIdx > 0) _selectedIdx --;
      }
      else{
        //next image
        if (_selectedIdx < widget.numImages - 1) _selectedIdx ++;
      }
    });
  }

  _cardAnimRollBackOrDisappear() => !_isRollback ? CardsAnimation.frontCardDisappearOffsetAnim(_controller, _offset).value : CardsAnimation.frontCardRollBackOffsetAnim(_controller, _offset).value;

  @override
  Widget build(BuildContext context) {
    print("build" );

    return new Align(
      child: new Transform.translate(
        offset: _controller.status == AnimationStatus.forward ? _cardAnimRollBackOrDisappear() : _offset,
        child: new Transform.rotate(
          angle: _controller.status == AnimationStatus.forward && _isRollback ? CardsAnimation.frontCardRollBackRotAnim(_controller, _rotation).value : _rotation,
          child: Container(
            margin: EdgeInsets.all(3),  
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
                    margin: new EdgeInsets.only(left: 6, bottom: 6),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text('Card number ' + widget.cardNum.toString(), style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w700)),
                        new Padding(padding: new EdgeInsets.only(bottom: 4.0)),
                        new Text('A short description.', textAlign: TextAlign.start, style: new TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),

                new SliderStack(
                  new Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.012), 
                  widget.numImages, 
                  _selectedIdx
                ),

                new GestureDetector(
                  onPanUpdate: (details) => _onCardPanUpdate(details, context),
                  onPanEnd: (_) => _onCardPanEnd(),
                  onTapUp: (details) => _onTapUp(details, context),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}