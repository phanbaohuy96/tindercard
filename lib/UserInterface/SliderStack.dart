import 'package:flutter/material.dart';

class SliderStackItem extends StatelessWidget {
  final bool isSelected;
  SliderStackItem(this.isSelected);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        child: Container(
          margin: EdgeInsets.all(3),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.grey,
              borderRadius: BorderRadius.circular(3.0)
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
    sliderItems = List();
    for(int i =0; i< numItems ; i++) sliderItems.add(SliderStackItem(selectedIdx == i));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      child: Row(        
        children: sliderItems,
      ),
    );
    
  }
}