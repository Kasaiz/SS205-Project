import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      home: LoaderOverlay(
        useDefaultLoading: false,
          overlayColor: Colors.white,
          overlayWidget: Center(
            child: LoadingBouncingGrid.square(backgroundColor: Colors.blueAccent,),
          ),
          child: HomePage()
      ),
    ));
}

class HomePage extends StatelessWidget {
  final Future<FirebaseApp> dbs = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    return MyLogin();
  }
}


