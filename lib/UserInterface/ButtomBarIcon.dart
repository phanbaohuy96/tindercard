import 'package:flutter/material.dart';

class ButtomBarIcon extends StatelessWidget {

  final IconData icon;
  final Color iconColor;
  final double size;
  final VoidCallback onPressed;

  ButtomBarIcon.large({
    this.icon,
    this.iconColor,
    this.onPressed
  }) : size = 60.0;

  ButtomBarIcon.small({
    this.icon,
    this.iconColor,
    this.onPressed
  }) : size = 50.0;

  ButtomBarIcon({
    this.icon,
    this.iconColor,
    this.onPressed,
    this.size
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow:[
          new BoxShadow(
            color: const Color(0X11000000),
            blurRadius: 10.0
          )
        ]
      ),
      child: new RawMaterialButton(
        shape: new CircleBorder(),
        elevation: 0.0,
        child: new Icon(
          icon,
          color: iconColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}