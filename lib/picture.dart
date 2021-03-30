import 'package:flutter/material.dart';
import './menu.dart';
import './object.dart';

class Vehicle extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/free-vector-landscape-illustration.jpg'),
                  fit: BoxFit.fill
              )
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                  left: 30,
                  child: Container(
                    child: FlatButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Plane('airplane-3993.png','plane.mp3','ระนาบ','máy bay')));
                      },
                      padding: EdgeInsets.all(0.0),
                      child: Image.asset('assets/images/airplane-3993.png', scale: 2),
                    )
                  )
              ),
              Positioned(
                  left: 60,
                  bottom: 20,
                  top: null,
                  right: null,
                  child: Container(
                    child: FlatButton(
                      onPressed: null,
                      padding: EdgeInsets.all(0.0),
                      child: Image.asset('assets/images/ambulance.png', scale: 2,),
                    ),
                  )
              )
            ],
          ),
        ),
        floatingActionButton: Menu()
    );
  }
}