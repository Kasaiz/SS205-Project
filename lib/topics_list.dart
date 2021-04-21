import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'picture.dart';

class TopicsList extends StatelessWidget {
  final List<Topic> topics;

  TopicsList(this.topics);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Topic List'),
            ),
            body: GridView.count(
              crossAxisCount: 4,
              children: List.generate(topics.length, (index) {
                return Container(
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Vehicle(topics[index].bg, topics[index].entities)));
                      },
                      padding: EdgeInsets.all(0.0),
                      child: Image.asset(
                          'assets/images/' + topics[index].topicImage,
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                );
              }),
            )),
        onWillPop: () async {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight
          ]);
          await FirebaseAuth.instance.signOut();
          final login = await SharedPreferences.getInstance();
          login.remove('email');
          return true;
        });
  }
}

class Topic {
  String topicImage;
  String bg;
  List<Entity> entities;

  Topic(this.topicImage, this.bg, this.entities);
}
