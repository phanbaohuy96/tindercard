import 'package:flutter/material.dart';

class SliderStack extends StatefulWidget {
  List<SliderItem> listItem = [];

  final int itemCount;
  final int idxSelecting;
  final BuildContext context;

  SliderStack({
    this.context,
    this.itemCount,
    this.idxSelecting
  });


  void _buildListItem()
  {
    if (itemCount <= 1) return;
    double widthBettween = 5.0;
    double itemWidth = (MediaQuery.of(context).size.width - widthBettween * itemCount) / itemCount;
    print("huy.phanbao :: " + itemWidth.toString());
    for(int i = 0; i< itemCount; i++)
    {
      listItem.add(new SliderItem(isSelecting: i == idxSelecting, itemWitdh: itemWidth, itemHeight: 3.0));
    }
  }

  @override
  _SliderStackState createState()  {
    _buildListItem();
    return _SliderStackState(itemCount: itemCount, listItem: listItem, idxSelecting: idxSelecting);
  }
}

class _SliderStackState extends State<SliderStack> {
  final List<SliderItem> listItem;
  final int idxSelecting;
  final int itemCount;

  _SliderStackState({
    this.itemCount,
    this.listItem,
    this.idxSelecting
  });

  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.0,
      color: Colors.transparent,
      child: Column(        
        children: <Widget>[
          new Flexible(            
            child: new ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: itemCount,
              itemBuilder: (_, index) => listItem[index],
            ),
          )
        ]
      ),
    );
  }

}

class SliderItem extends StatefulWidget {
  final bool isSelecting;
  final double itemWitdh;
  final double itemHeight;


  SliderItem({
    this.isSelecting,
    this.itemHeight,
    this.itemWitdh
  });

  @override
  _SliderItemState createState() => _SliderItemState(isSelecting: isSelecting, itemHeight: itemHeight, itemWitdh: itemWitdh);
}

class _SliderItemState extends State<SliderItem> {

  final bool isSelecting;
  final double itemWitdh;
  final double itemHeight;


  Color itemColor;

  _SliderItemState({
    this.isSelecting,
    this.itemHeight,
    this.itemWitdh
  }) : this.itemColor = isSelecting ? Colors.white24 : Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: itemWitdh,
      height: itemHeight,
      color: itemColor,
    );
  }
}