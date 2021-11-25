import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:major_project/model/user_model.dart';
import 'package:major_project/screens/login_screen.dart';
import 'package:major_project/screens/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  //radiobutton
  // int _value = 0;
  var _value = "null";

  //dropdown
  final items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
  String? value;

  final _formKey = GlobalKey<FormState>();

  final sourceEditingController = new TextEditingController();

  bool _editableText = true;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  // Source field
  final sourceField = TextFormField(
    autofocus: false,
    // controller: sourceEditingController,
    decoration: InputDecoration(
      // contentPadding: EdgeInsets.fromLTRB(5, 15, 20, 5),
      labelText: "Source",
      labelStyle: TextStyle(
        fontSize: 20.0,
      ),
      hintText: "eg. Haibowal",
    ),
  );

  // Destination field
  final destinationField = TextFormField(
    maxLines: 2,
    enabled: true,
    readOnly: true,
    autofocus: false,
    decoration: InputDecoration(
      suffixIcon: Icon(
        Icons.location_off,
        color: Colors.orange,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.orange,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.orange,
        ),
      ),
      labelText: "Destination",
      labelStyle: TextStyle(
        fontSize: 20.0,
        color: Colors.orange,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintText: "Guru Nanak Dev Engineering College, Ludhiana",
      hintStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color: Colors.black45,
      ),
    ),
  );

  final cardField = Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(color: Colors.orange),
    ),
    color: Colors.grey.shade200,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text("Abc"),
          subtitle: Text('xyz -> GNDEC'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // TextButton(
            //   child: Text('BUY TICKETS'),
            //   onPressed: () {/* ... */},
            // ),
            SizedBox(width: 8),
            TextButton(
              child: Text('Ride'),
              onPressed: () {/* ... */},
            ),
            SizedBox(width: 8),
          ],
        ),
      ],
    ),
  );
// var _value = "${loggedInUser.mode}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WE-SHARE",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0)),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Icon(
                Icons.refresh,
                size: 26.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.white),
        // leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    // enabled: false,
                    readOnly: _editableText,
                    autofocus: false,
                    controller: sourceEditingController,
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.words,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("please enter source");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      sourceEditingController.text = value!;
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _editableText = !_editableText;
                            });
                          },
                          icon: Icon(
                            _editableText ? Icons.edit : Icons.location_on,
                            // color: Colors.orange,
                          )),
                      // contentPadding: EdgeInsets.fromLTRB(5, 15, 20, 5),
                      labelText: "Source",
                      labelStyle: TextStyle(
                        fontSize: 20.0,
                        // color: Colors.orange,
                      ),
                      // errorStyle: TextStyle(color: Colors.orange),

                      hintText: "Your Saved Source is : ${loggedInUser.source}",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.black45,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  // Container(

                  //   padding: EdgeInsets.fromLTRB(15, 5, 10, 0),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     border: Border.all(
                  //       color: Colors.orange,
                  //     ),
                  //   ),
                  //   child: DropdownButtonHideUnderline(
                  //     child: DropdownButton<String>(
                  //       hint: Text("Select item"),
                  //       value: value,
                  //       iconSize: 36,
                  //       icon: Icon(
                  //         Icons.arrow_drop_down,
                  //         color: Colors.black,
                  //       ),
                  //       isExpanded: true,
                  //       items: items.map(buildMenuItem).toList(),
                  //       onChanged: (value) => setState(() => this.value = value),
                  //     ),
                  //   ),
                  // ),
                  destinationField,
                  SizedBox(
                    height: 20,
                  ),

                  // cardField,
                  // SizedBox(
                  //   height: 2,
                  // ),
                  // cardField,
                  // SizedBox(
                  //   height: 2,
                  // ),
                  // cardField,
                  // Card(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(10),
                  //     side: BorderSide(color: Colors.orange),
                  //   ),
                  //   color: Colors.grey.shade200,
                  //   child: Column(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: <Widget>[
                  //       ListTile(
                  //         leading: Icon(Icons.account_circle),
                  //         title: Text("${loggedInUser.firstName}"),
                  //         subtitle: Text('${loggedInUser.source} -> GNDEC'),
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.end,
                  //         children: <Widget>[
                  //           // TextButton(
                  //           //   child: Text('BUY TICKETS'),
                  //           //   onPressed: () {/* ... */},
                  //           // ),
                  //           SizedBox(width: 8),
                  //           TextButton(
                  //             child: Text('Ride'),
                  //             onPressed: () {/* ... */},
                  //           ),
                  //           SizedBox(width: 8),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  //here
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                              value: 'Find Ride',
                              groupValue: _value,
                              onChanged: (String? value) {
                                setState(() {
                                  if (value != null) _value = value;
                                  Fluttertoast.showToast(msg: _value);
                                });
                              }),
                          SizedBox(
                            width: 10,
                          ),
                          // SelectableText("data"),
                          Text(
                            "Find Ride",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                              value: "Offer Ride",
                              groupValue: _value,
                              onChanged: (String? value) {
                                setState(() {
                                  if (value != null) _value = value;
                                  Fluttertoast.showToast(msg: _value);
                                });
                              }),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          Text(
                            "Offer Ride",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // SelectableText(
                  //     "Sed ut perspiciatis unde omnis iste natus error sit voluptatem"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.orange,
                        child: MaterialButton(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          // minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                _value != 'null') {
                              loggedInUser.source =
                                  sourceEditingController.text;
                              loggedInUser.mode = _value;
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(user!.uid)
                                  .set(loggedInUser.toMap());
                              Fluttertoast.showToast(
                                  msg: "Source entered Successfully");
                              setState(() {
                                _editableText = true;
                                sourceEditingController.clear();
                                _value = "null";
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Select Ride Mode Please!');
                            }
                            // signUp(emailEditingController.text, passwordEditingController.text);
                          },
                          child: Text(
                            "Save",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Rides close to you : ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.orange),
                    ),
                    color: Colors.grey.shade200,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.account_circle),
                          title: Text(
                              "${loggedInUser.firstName} ${loggedInUser.secondName}",
                              style: TextStyle(fontSize: 20)),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              '${loggedInUser.source} -> GNDEC',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            // TextButton(
                            //   child: Text('BUY TICKETS'),
                            //   onPressed: () {/* ... */},
                            // ),
                            SizedBox(width: 8),
                            TextButton(
                              child: Text(
                                '${loggedInUser.mode}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {/* ... */},
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  ),

                  for (int i = 0; i < 3; i++) cardField

                  //extra
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: <Widget>[
                  //     FloatingActionButton(
                  //         child: Icon(Icons.refresh),
                  //         onPressed: () {
                  //           Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => HomeScreen()));
                  //         }),
                  //   ],
                  // ),

                  // FloatingActionButton(onPressed: () {}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
  //       value: item,
  //       child: Text(
  //         item,
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 20,
  //         ),
  //       ),
  //     );

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
