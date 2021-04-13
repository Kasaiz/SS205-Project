import 'package:flutter/material.dart';
import './menu.dart';
import './object.dart';

class Vehicle extends StatelessWidget {
  final List<Entity> entities;

  Vehicle(this.entities);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/free-vector-landscape-illustration.jpg'),
                  fit: BoxFit.fill)),
          child: Stack(
              children: List.generate(entities.length, (index) {
                return Positioned(
                    left: entities[index].left,
                    top: entities[index].top,
                    right: entities[index].right,
                    bottom: entities[index].bottom,
                    child: Container(
                        child: FlatButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute( builder:
                              (context) => Plane(entities[index].imageName, entities[index].audioName, entities[index].thaiWord, entities[index].vietWord)));
                  },
                  padding: EdgeInsets.all(0.0),
                  child:
                      Image.asset('assets/images/'+entities[index].imageName, scale: 2),
                )));
              })
          ),
        ),
        floatingActionButton: Menu());
  }
}

class Entity {
  String imageName;
  String audioName;
  String thaiWord;
  String vietWord;
  double left;
  double top;
  double right;
  double bottom;

  Entity(this.imageName, this.audioName, this.thaiWord, this.vietWord,
      this.left, this.top, this.right, this.bottom);
}
