import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:io';

class Menu extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      curve: Curves.easeOutExpo,
      animatedIcon: AnimatedIcons.menu_close,
      overlayColor: Colors.black12,
      backgroundColor: Colors.blueAccent,
      animatedIconTheme: IconThemeData.fallback(),
      children: [
        SpeedDialChild(
            child: Icon(Icons.highlight_off_rounded),
            backgroundColor: Colors.lightBlue,
            label: 'Quit app',
            onTap: () => exit(0)
        ),
        SpeedDialChild(
          child: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,),
          backgroundColor: Colors.green,
          label: 'Back',
          onTap: (){
            Navigator.pop(context);
          },
        )
      ],
    );
  }

}