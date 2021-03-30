import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import './menu.dart';

class Plane extends StatelessWidget{
  final AudioCache player = AudioCache();
  final String imageName;
  final String audioName;
  final String thaiWord;
  final String vietWord;

  Plane(this.imageName, this.audioName, this.thaiWord, this.vietWord);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5)
          ),
          child: Align(
            alignment: Alignment.center,
            child: AspectRatio(
              aspectRatio: 1/1,
              child: Container(
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        child: Container(
                          // margin: EdgeInsets.only(bottom: 150),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/'+imageName),
                                  // image: AssetImage('assets/images/airplane-3993.png'),
                                scale: 2,
                              )
                          ),
                        )
                    ),
                    Positioned(
                      child: FlatButton(
                        onPressed: () {
                          // player.load('audio/plane.mp3');
                          // player.play('audio/plane.mp3');
                          player.play('audio/'+audioName);
                        },
                        padding: EdgeInsets.all(0.0),
                        child: Image.asset('assets/images/sound-on.png'),
                      ),
                      bottom: 50,
                      right: 50,
                      width: 64,
                      height: 64,
                    ),
                    Positioned(
                      bottom: 80,
                      left: 30,
                      // child: Text('ระนาบ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                      child: Text(thaiWord, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                    ),
                    Positioned(
                      bottom: 40,
                      left: 30,
                      // child: Text('máy bay', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                      child: Text(vietWord, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
      floatingActionButton: Menu(),
    );
  }
}