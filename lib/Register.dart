import 'package:flutter/material.dart';

import 'Login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  void login() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  bool _secureText = true;
  bool _secureText1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'WE-SHARE',
                      style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    // controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.orange, width: 1.0)),
                      labelText: 'Email',
                      suffixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    obscureText: _secureText,
                    // controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      // labelStyle: TextStyle(fontSize: 30.0),
                      suffixIcon: IconButton(
                        icon: Icon(_secureText ? Icons.lock : Icons.lock_open
                            // size: 20.0,
                            ),
                        onPressed: () {
                          setState(() {
                            _secureText = !_secureText;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    obscureText: _secureText1,
                    // controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                      suffixIcon: IconButton(
                        icon: Icon(_secureText1 ? Icons.lock : Icons.lock_open
                            // size: 20.0,
                            ),
                        onPressed: () {
                          setState(() {
                            _secureText1 = !_secureText1;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.orange,
                      child: Text('Register',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onPressed: () {
                        // print(nameController.text);
                        // print(passwordController.text);
                      },
                    )),
                SizedBox(height: 5.0),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Already have account?'),
                    // ignore: deprecated_member_use
                    FlatButton(
                      textColor: Colors.orange,
                      child: Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: login,
                      //signup screen
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
