import 'package:flutter/material.dart';

class SliderStackItem extends StatelessWidget {
  final bool isSelected;
  SliderStackItem(this.isSelected);

  @override
  Widget build(BuildContext context) {
    return new Flexible(
      child: Container(
        child: new Container(
          margin: EdgeInsets.all(3),
          child: new Container(
            decoration: new BoxDecoration(
              color: isSelected ? Colors.white : Colors.grey,
              borderRadius: new BorderRadius.circular(3.0)
            ),
          ),
        ),
      ),
    );   
  }
}


List<SliderStackItem> sliderItems;

class SliderStack extends StatelessWidget {
  

  final Size size;
  final int numItems;  
  
  final int selectedIdx;
  SliderStack(this.size, this.numItems, this.selectedIdx){
    sliderItems = new List();
    for(int i =0; i< numItems ; i++) sliderItems.add(new SliderStackItem(selectedIdx == i));
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: size.width,
      height: size.height,
      child: Row(        
        children: sliderItems,
      ),
    );
    
  }
}