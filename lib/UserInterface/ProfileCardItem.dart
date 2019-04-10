import 'package:flutter/material.dart';
import 'SliderStack.dart';

class ProfileCardItem extends StatefulWidget {

  final int cardNum, numImages;
  final List<String> imageList = new List();
  final Function onCardPanUpdate, onCardPanEnd;

  ProfileCardItem(this.cardNum, this.numImages, this.onCardPanUpdate, this.onCardPanEnd);
  @override
  _ProfileCardItemState createState() => _ProfileCardItemState();
}

class _ProfileCardItemState extends State<ProfileCardItem> {

  Size _contextSize;
  int selectedIdx = 0;

  @override
  void initState()
  {
    super.initState();    
    selectedIdx = 0;
    print("selectedIdx = $selectedIdx" );
  }

  _onTapUp(TapUpDetails details, BuildContext context)
  {
    if(_contextSize == null)
      _contextSize = MediaQuery.of(context).size;
    setState(() {
      if(details.globalPosition.dx < _contextSize.width / 2.0)
      {
        //previous image
        if (selectedIdx > 0) selectedIdx --;
      }
      else{
        //previous image
        if (selectedIdx < widget.numImages - 1) selectedIdx ++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text('Card number ' + widget.cardNum.toString(), style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w700)),
                  new Padding(padding: new EdgeInsets.only(bottom: 8.0)),
                  new Text('A short description.', textAlign: TextAlign.start, style: new TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
          new SliderStack(
            new Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.012), 
            widget.numImages, 
            selectedIdx
          ),
          new GestureDetector(
            onPanUpdate: (details) => widget.onCardPanUpdate(details, context),
            onPanEnd: (_) => widget.onCardPanEnd(),
            onTapUp: (details) => _onTapUp(details, context),
          )
        ],
      ),
    );
  }
}