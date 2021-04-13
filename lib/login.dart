import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thai_app/picture.dart';
import 'package:thai_app/signup.dart';
import 'package:thai_app/topics_list.dart';

class MyLogin extends StatefulWidget{
  @override
  _MyLoginState createState() => _MyLoginState();

}

class _MyLoginState extends State<MyLogin>{

  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    bool pressed = false;

    //data
    List<Entity> entities = new List<Entity>();
    entities.add(new Entity('airplane-3993.png', 'plane.mp3', 'ระนาบ', 'máy bay', 30, null, null, null));
    entities.add(new Entity('ambulance.png', 'ambulance.mp3', 'รถพยาบาล', 'xe cứu thương', 50, null, null, 30));
    entities.add(new Entity('delivery-truck.png', 'truck.mp3', 'รถบรรทุก', 'xe tải', null, null, 50, 10));
    entities.add(new Entity('motorcycle-delivery.png', 'motorcycle.mp3', 'รถจักรยานยนต์', 'xe máy', null, null, 250, -10));
    List<Topic> topics = [new Topic('airplane.png', entities)];
    topics.add(new Topic('abc.png', null));
    topics.add(new Topic('calendar.png', null));
    topics.add(new Topic('spartan-helmet.png', null));
    topics.add(new Topic('coin.png', null));
    topics.add(new Topic('clock.png', null));
    topics.add(new Topic('cooling-symbol.png', null));
    topics.add(new Topic('home.png', null));
    topics.add(new Topic('heart.png', null));


    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                AssetImage('assets/images/light-1.png'))),
                      ),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                AssetImage('assets/images/light-2.png'))),
                      ),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 200,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/clock.png'))),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                    BorderSide(color: Colors.grey[100]))),
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle:
                                  TextStyle(color: Colors.grey[400])),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              obscureText: true,
                              controller: passController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle:
                                  TextStyle(color: Colors.grey[400])),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10),
                      //     gradient: LinearGradient(colors: [
                      //       Color.fromRGBO(143, 148, 251, 1),
                      //       Color.fromRGBO(143, 148, 251, .6)
                      //     ])),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                )
                            )
                        ),
                        child: Text('Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          if(pressed==false) {
                            pressed=true;
                            UserCredential userCredential;
                            try {
                              userCredential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passController.text
                              );
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('No user found for that email.');
                                showDialog(context: context, builder: (context) {
                                  return AlertDialog(
                                    content: Text('No user found for that email.'),);
                                });
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                                showDialog(context: context, builder: (context) {
                                  return AlertDialog(
                                    content: Text('Wrong password provided for that user.'),);
                                });
                              }
                            }
                            pressed=false;
                            if (userCredential != null) {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => TopicsList(topics)));
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // Text(
                    //   "Forgot Password?",
                    //   style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
                    // ),
                    TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Signup())),
                        child: Text('Sign up', style: TextStyle(color: Colors.blueAccent, fontStyle: FontStyle.italic),)
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}