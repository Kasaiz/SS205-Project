import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'picture.dart';

class TopicsList extends StatelessWidget {
  List<Topic> topics;

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
                            MaterialPageRoute(builder: (context) => Vehicle(topics[index].entities)));
                      },
                      padding: EdgeInsets.all(0.0),
                      child: Image.asset(
                          'assets/images/' + topics[index].topicImage),
                    ),
                  ),
                );
              }),
              // [
              //   Container(
              //     child: ConstrainedBox(
              //       constraints: BoxConstraints.expand(),
              //       child: FlatButton(
              //         onPressed: null,
              //         padding: EdgeInsets.all(0.0),
              //         child: Image.asset('assets/images/abc.png'),
              //       ),
              //     ),
              //   ),
              //   Container(
              //     child: ConstrainedBox(
              //       constraints: BoxConstraints.expand(),
              //       child: FlatButton(
              //         onPressed: (){
              //           Navigator.push(context, MaterialPageRoute(builder: (context) => Vehicle()));
              //         },
              //         padding: EdgeInsets.all(0.0),
              //         child: Image.asset('assets/images/airplane.png'),
              //       ),
              //     ),
              //   ),
              //   Container(
              //     child: ConstrainedBox(
              //       constraints: BoxConstraints.expand(),
              //       child: FlatButton(
              //         onPressed: null,
              //         padding: EdgeInsets.all(0.0),
              //         child: Image.asset('assets/images/bulb.png'),
              //       ),
              //     ),
              //   ),
              //   Container(
              //     child: ConstrainedBox(
              //       constraints: BoxConstraints.expand(),
              //       child: FlatButton(
              //         onPressed: null,
              //         padding: EdgeInsets.all(0.0),
              //         child: Image.asset('assets/images/calendar.png'),
              //       ),
              //     ),
              //   )
              // ]
            )),
        onWillPop: () async {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight
          ]);
          return true;
        });
  }
}

class Topic {
  String topicImage;
  List<Entity> entities;

  Topic(this.topicImage, this.entities);
}
