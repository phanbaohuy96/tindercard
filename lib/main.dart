import 'package:flutter/material.dart';
import 'UserInterface/ButtomBarIcon.dart';
import 'UserInterface/CardSection.dart';

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
      centerTitle: true,
      backgroundColor: Colors.white,
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
      title: new IconButton(
        icon: new FlutterLogo(
          size: 30.0,
          colors: Colors.blue,
        ),
        alignment: Alignment.center,
        onPressed: () =>{
          // TODO:
        },
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
        color: Colors.white,
        padding: new EdgeInsets.only(bottom: 10.0, top: 10.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,        
          children: <Widget>[
            new ButtomBarIcon.small(
              icon: Icons.refresh,
              iconColor: Colors.orange,
              onPressed: (){
                //TODO:
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildAppBar(),
      body:
          new CardSection(context),
      bottomNavigationBar: _buildBottomBar(),
    );
  }
}   