import 'package:flutter/material.dart';

class IndicatorStackItem extends StatelessWidget {
  final bool isSelected;
  IndicatorStackItem(this.isSelected);

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


List<IndicatorStackItem> indicatorItems;

class IndicatorStack extends StatelessWidget {
  

  final Size size;
  final int numItems;  
  
  final int selectedIdx;
  IndicatorStack(this.size, this.numItems, this.selectedIdx){
    indicatorItems = List();
    for(int i =0; i< numItems ; i++) indicatorItems.add(IndicatorStackItem(selectedIdx == i));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      child: Row(        
        children: indicatorItems,
      ),
    );
    
  }
}