import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "WE-SHARE",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          leading: GestureDetector(
            onTap: () {},
            child: Icon(Icons.menu),
          ),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                // Container(
                //     alignment: Alignment.center,
                //     padding: EdgeInsets.all(10),
                //     child: Text(
                //       'WE-SHARE',
                //       style: TextStyle(
                //           color: Colors.orange,
                //           fontWeight: FontWeight.w500,
                //           fontSize: 30),
                //     )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    // controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Source',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: TextField(
                    obscureText: true,
                    // controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Destination',
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            )));
  }
}
