import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:io';

import 'package:thai_app/login.dart';

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
          child: Icon(Icons.exit_to_app_rounded,color: Colors.green,),
          backgroundColor: Colors.white,
          label: 'Sign out',
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight
            ]);
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyLogin()), (route) => false);
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,),
          backgroundColor: Colors.green,
          label: 'Back',
          onTap: (){
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

}