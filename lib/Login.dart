import 'package:flutter/material.dart';

import 'Homepage.dart';
import 'Register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void register() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Register()));
  }

  void homepage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Homepage()));
  }

  bool _secureText = true;

  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Sample App'),
        // ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  height: 200,
                  child: Image(image: AssetImage("images/start.png")),
                ),
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
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // borderSide:
                        //     BorderSide(color: Colors.orange, width: 1.0)
                        labelText: 'Email',
                        suffixIcon: Icon(Icons.email)),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: _secureText,
                    // controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(_secureText ? Icons.lock : Icons.lock_open),
                        onPressed: () {
                          setState(() {
                            _secureText = !_secureText;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                // ignore: deprecated_member_use
                FlatButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  textColor: Colors.orange,
                  child: Text('Forgot Password'),
                ),
                SizedBox(height: 5.0),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.orange,
                      child: Text('Login',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      // onPressed: homepage,
                      onPressed: () {
                        print("Email : " + _emailController.text);
                      },
                      // print(nameController.text);
                      // print(passwordController.text);
                    )),
                SizedBox(height: 10.0),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    // ignore: deprecated_member_use
                    FlatButton(
                      textColor: Colors.orange,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: register,
                      //signup screen
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
