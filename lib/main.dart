import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp( 
  title: 'Flutter Tinder',
  theme: new ThemeData(
    primaryColorBrightness:  Brightness.light,
    primarySwatch: Colors.blue
    ),
  home: MainHomePage()
  )
);

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {

  Widget _buildAppBar(){
    return new AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: new IconButton(
        icon: new Icon(
          Icons.person, 
          color: Colors.grey,
          size: 30.0,
        ),
        onPressed: (){
          // TODO:
        },
      ),
      title: new FlutterLogo(
        size: 30.0,
        colors: Colors.blue,
      ),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(
            Icons.chat_bubble, 
            color: Colors.grey
          ),
          onPressed: (){
            // TODO:
          },
        )
      ],
    );
  }

  Widget _buildBottomBar(){
    return new BottomAppBar(
      color: Colors.transparent,
      elevation: 0.0,
      child: Container(
        padding: new EdgeInsets.only(bottom: 10.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,        
          children: <Widget>[
            new ButtomBarIcon.small(
              icon: Icons.refresh,
              iconColor: Colors.orange,
              onPressed: (){
                // TODO:
              },
            ),
            new ButtomBarIcon.large(
              icon: Icons.clear,
              iconColor: Colors.black,
              onPressed: (){
                // TODO:
              },
            ),
            new ButtomBarIcon.small(
              icon: Icons.star,
              iconColor: Colors.blue,
              onPressed: (){
                // TODO:
              },
            ),
            new ButtomBarIcon.large(
              icon: Icons.favorite,
              iconColor: Colors.pinkAccent,
              onPressed: (){
                // TODO:
              },
            ),
            new ButtomBarIcon.small(
              icon: Icons.lock,
              iconColor: Colors.orange,
              onPressed: (){
                // TODO:
              },
            )
          ],
        ),
      )
    );
  }

  Widget _buildCardStack(){
    return new Center(

    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildAppBar(),
      body: _buildCardStack(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }
}   

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