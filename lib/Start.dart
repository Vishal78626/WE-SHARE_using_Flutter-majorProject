import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:major_project/Login.dart';
import 'package:major_project/Register.dart';

class Start extends StatefulWidget {
  Start({Key? key}) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  void login() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  void register() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Register()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            Container(
              height: 350,
              child: Image(image: AssetImage("images/start.png")),
              // fit: BoxFit.contain,
            ),
            SizedBox(height: 25.0),
            RichText(
                text: TextSpan(
                    text: "Welcome to ",
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: <TextSpan>[
                  TextSpan(
                      text: '<WE-SHARE>',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange))
                ])),
            SizedBox(height: 20.0),
            Text("Share Your Ride with Others",
                style: TextStyle(fontSize: 20.0, color: Colors.black)),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // ignore: deprecated_member_use
                RaisedButton(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  onPressed: login,
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  color: Colors.orange,
                ),
                SizedBox(
                  width: 20.0,
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  onPressed: register,
                  child: Text(
                    "REGISTER",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  color: Colors.orange,
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            SignInButton(
              Buttons.Google,
              text: "Sign up with Google",
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
