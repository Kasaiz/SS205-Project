import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thai_app/picture.dart';
import 'package:thai_app/signup.dart';
import 'package:thai_app/topics_list.dart';

class MyLogin extends StatefulWidget{
  @override
  _MyLoginState createState() => _MyLoginState();

}

class _MyLoginState extends State<MyLogin> {

  final emailController = TextEditingController();
  final passController = TextEditingController();

  bool _checked = false;
  SharedPreferences login;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    bool pressed = false;
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
                      // height: 30,
                      child: CheckboxListTile(
                        title: Text("Remember me"),
                        controlAffinity: ListTileControlAffinity.platform,
                        value: _checked,
                        onChanged: (bool value){
                          setState(() {
                            _checked = value;
                          });
                        },
                      ),
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
                            if (passController.text.isEmpty ||
                                emailController.text.isEmpty) {
                              showDialog(context: context, builder: (context) {
                                return AlertDialog(
                                  content: Text('Empty field(s)!'),);
                              });
                              pressed=false;
                            }else {
                              UserCredential userCredential;
                              try {
                                context.loaderOverlay.show();
                                userCredential = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passController.text
                                );

                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print('No user found for that email.');
                                  showDialog(
                                      context: context, builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                          'No user found for that email.'),);
                                  });
                                } else if (e.code == 'wrong-password') {
                                  print(
                                      'Wrong password provided for that user.');
                                  showDialog(
                                      context: context, builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                          'Wrong password provided for that user.'),);
                                  });
                                }
                              }
                              if(context.loaderOverlay.visible){
                                context.loaderOverlay.hide();
                              }
                              pressed = false;
                              if (userCredential != null) {
                                if (_checked) {
                                  login.setString(
                                      'email', emailController.text);
                                }
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        TopicsList(getTopic())));
                              }
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // Text(
                    //   "Forgot Password?",
                    //   style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
                    // ),
                    TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Signup())),
                        child: Text('Sign up', style: TextStyle(color: Colors.blueAccent, fontStyle: FontStyle.italic),)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkLogin() async{
    login = await SharedPreferences.getInstance();
    String email = login.getString('email')??null;
    if(email!=null){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => TopicsList(getTopic())));
    }
  }

  List<Topic> getTopic(){
    //vehicle topic
    List<Entity> entities1 = [new Entity('airplane-3993.png', 'plane.mp3', 'ระนาบ', 'máy bay', 30, null, null, null)];
    entities1.add(new Entity('ambulance.png', 'ambulance.mp3', 'รถพยาบาล', 'xe cứu thương', 50, null, null, 30));
    entities1.add(new Entity('delivery-truck.png', 'truck.mp3', 'รถบรรทุก', 'xe tải', null, null, 50, 10));
    entities1.add(new Entity('motorcycle-delivery.png', 'motorcycle.mp3', 'รถจักรยานยนต์', 'xe máy', null, null, 250, -10));
    List<Topic> topics = [new Topic('airplane.png', 'free-vector-landscape-illustration.jpg', entities1)];

    // animal topic
    List<Entity> entities2 = [new Entity('bunny.png', 'bunny.mp3', 'กระต่าย', 'con thỏ', 50, null, null, 80)];
    entities2.add(new Entity('bear.png', 'bear.mp3', 'หมี', 'con gấu', null, null, 50, 50));
    entities2.add(new Entity('fox.png', 'fox.mp3', 'จิ้งจอก', 'cáo', 200, null, null, 60));
    entities2.add(new Entity('owl.png', 'owl.mp3', 'นกฮูก', 'con cú', 250, 40, null, null));
    entities2.add(new Entity('bird.png', 'bird.mp3', 'นก', 'chim', null, 100, 120, null));
    topics.add(new Topic('cat-7009.png', 'animal-bg.jpg', entities2));

    //classroom topic
    List<Entity> classroom = [new Entity('board.png', 'board.mp3', 'คณะกรรมการ', 'bảng', null, 100, 215, null)];
    classroom.add(new Entity('clock-object.png', 'clock.mp3', 'นาฬิกา', 'đồng hồ', 120, 100, null, null));
    classroom.add(new Entity('table.png', 'table.mp3', 'โต๊ะ', 'bàn', null, null, 280, 40));
    classroom.add(new Entity('chair.png', 'chair.mp3', 'เก้าอี้', 'cái ghế', null, null, 280, 10));
    topics.add(new Topic('opened-book.png', 'classroom-bg.png', classroom));

    //fruits topic
    List<Entity> fruits = [new Entity('melon.png', 'melon.mp3', 'แตงโม', 'dưa', null, null, 250, 70)];
    fruits.add(new Entity('orange.png', 'orange.mp3', 'ส้ม', 'trái cam', null, null, 280, 60));
    fruits.add(new Entity('nho.png', 'grape.mp3', 'องุ่น', 'nho', 210, null, null, 60));
    fruits.add(new Entity('apple.png', 'apple.mp3', 'แอปเปิ้ล', 'táo', 380, null, null, 60));
    topics.add(new Topic('apple-3155.png', 'fruits-bg.png', fruits));

    //weather topic
    List<Entity> weather = [new Entity('raindrop-1580.png', 'rain.mp3', 'ฝน', 'mưa', 100, 50, null, null)];
    weather.add(new Entity('lightning-bolt-4138.png', 'lightning.mp3', 'ฟ้าผ่า', 'tia chớp', null, 50, 100, null));
    weather.add(new Entity('sun-3334.png', 'sunny.mp3', 'แดดจัด', 'nắng', 100, null, null, 50));
    weather.add(new Entity('clouds-4269.png', 'cloud.mp3', 'เมฆ', 'đám mây', null, null, 100, 50));
    topics.add(new Topic('cooling-symbol.png', 'weather-bg.png', weather));

    //house topic
    List<Entity> house = [new Entity('sofa.png', 'sofa.mp3', 'โซฟา', 'ghế sô pha', null, null, 150, 50)];
    house.add(new Entity('light.png', 'ceilinglight.mp3', 'ไฟเพดาน', 'Đèn trần', null, 0, 250, null));
    house.add(new Entity('tv.png', 'tv.mp3', 'โทรทัศน์', 'Tivi', 125, null, null, 101));
    house.add(new Entity('window.png', 'window.mp3', 'หน้าต่าง', 'cửa sổ', null, 100, 100, null));
    house.add(new Entity('cay.png', 'tree.mp3', 'ต้นไม้', 'cây', null, null, 50, 50));
    house.add(new Entity('desk.png', 'cabinet.mp3', 'ตู้', 'tủ', 100, null, null, 50));
    topics.add(new Topic('home.png', 'livingroom-bg.png', house));

    return topics;
  }
}

