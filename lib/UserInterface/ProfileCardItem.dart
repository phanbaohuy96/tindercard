import 'package:flutter/material.dart';
import 'SliderStack.dart';
import 'package:tinder_card/Controller/AnimationUtils/CardsAnimation.dart';
import 'dart:math';

class ProfileCardItem extends StatefulWidget {

  final int cardNum, numImages;
  final List<String> imageList = List();
  final Function onCardPanUpdateCallBack, onReleaseCallback, onCardRollBackCallBack, onComplete;

  ProfileCardItem({ 
    this.cardNum, 
    this.numImages, 
    this.onCardPanUpdateCallBack, 
    this.onReleaseCallback, 
    this.onCardRollBackCallBack,
    this.onComplete
  }) : super(key: UniqueKey());
  

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
    _offset = Offset(0.0, 0.0);
    _rotation = 0.0;
    _isRollback = true;

    _controller = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _controller.addListener(() => setState(() { }));
    _controller.addStatusListener(_onComplete);

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
        _offset = Offset(0.0, 0.0);
        _rotation = 0.0;
      } else {
        widget.onComplete();
      }
      _isRollback = true;
    }
  }

  _onCardPanUpdate(DragUpdateDetails details, BuildContext context)
  {
    setState(() {
      //translate card
      _offset = Offset(
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
    print("_onCardPanEnd");
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

  _cardAnimRollBackOrDisappear() => !_isRollback ? 
    CardsAnimation.frontCardDisappearOffsetAnim(_controller, _offset).value : 
    CardsAnimation.frontCardRollBackOffsetAnim(_controller, _offset).value;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Transform.translate(
        offset: _controller.status == AnimationStatus.forward ? _cardAnimRollBackOrDisappear() : _offset,
        child: Transform.rotate(
          angle: _controller.status == AnimationStatus.forward && _isRollback ? CardsAnimation.frontCardRollBackRotAnim(_controller, _rotation).value : _rotation,
          child: Container(
            margin: EdgeInsets.all(3),  
            child: Stack(
              children: <Widget>[
                //Create a picture
                SizedBox.expand(
                  child: Material(              
                    borderRadius: BorderRadius.circular(12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset('data/images/cf1.JPG', fit: BoxFit.cover)
                    ),
                  ),
                ),

                //make effect gradient from center widget to end
                SizedBox.expand(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black54],
                        begin: Alignment.center,
                        end: Alignment.bottomCenter
                      )
                    ),
                  ),
                ),

                //Create descristion for image
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 6, bottom: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Card number ' + widget.cardNum.toString(), style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w700)),
                        Padding(padding: EdgeInsets.only(bottom: 4.0)),
                        Text('A short description.', textAlign: TextAlign.start, style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),

                SliderStack(
                  Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.012), 
                  widget.numImages, 
                  _selectedIdx
                ),

                GestureDetector(
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