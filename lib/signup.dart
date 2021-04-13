import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget{

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final repassController = TextEditingController();

  bool pressed = false;

  @override
  Widget build(BuildContext context) {
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
                            "Sign up",
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
                padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
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
                                  hintText: "Enter Email",
                                  hintStyle:
                                  TextStyle(color: Colors.grey[400])),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                    BorderSide(color: Colors.grey[100]))),
                            child: TextField(
                              obscureText: true,
                              controller: passController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle:
                                  TextStyle(color: Colors.grey[400])),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              obscureText: true,
                              controller: repassController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Confirm Password",
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
                        child: Text('Sign up', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          if(pressed==false) {
                            pressed = true;
                            if (passController.text.isEmpty ||
                                emailController.text.isEmpty) {
                              showDialog(context: context, builder: (context) {
                                return AlertDialog(
                                  content: Text('Empty field(s)!'),);
                              });
                            } else {
                              if (passController.text !=
                                  repassController.text) {
                                showDialog(
                                    context: context, builder: (context) {
                                  return AlertDialog(content: Text(
                                      'Passwords are not the same!'),);
                                });
                              } else {
                                if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(emailController.text)) {
                                  showDialog(
                                      context: context, builder: (context) {
                                    return AlertDialog(
                                      content: Text('Invalid Email!'),);
                                  });
                                } else {
                                  try {
                                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passController.text
                                    );
                                    showDialog(
                                        context: context, builder: (context) {
                                      return AlertDialog(
                                        content: Text('Register successful!'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],);
                                    });
                                    pressed = false;
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'weak-password') {
                                      print(
                                          'The password provided is too weak.');
                                      showDialog(
                                          context: context, builder: (context) {
                                        return AlertDialog(content: Text(
                                            'The password provided is too weak.'),);
                                      });
                                    } else
                                    if (e.code == 'email-already-in-use') {
                                      print(
                                          'The account already exists for that email.');
                                      showDialog(
                                          context: context, builder: (context) {
                                        return AlertDialog(content: Text(
                                            'The account already exists for that email.'),);
                                      });
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                }
                              }
                            }
                          }
                        },
                      ),
                    ),
                    // SizedBox(
                    //   height: 70,
                    // ),
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Login', style: TextStyle(color: Colors.blueAccent, fontStyle: FontStyle.italic),)
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