import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:major_project/model/user_model.dart';
import 'package:major_project/screens/login_screen.dart';
import 'package:major_project/screens/main_drawer.dart';
import 'package:major_project/screens/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  bool isSignupScreen = false;
  //radiobutton
  var _value = "null";

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
                  //Source TextField
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

                  //destination textfield
                  destinationField,
                  SizedBox(
                    height: 20,
                  ),

                  //Radio Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
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
                          Text(
                            "Find Ride",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
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
                          Text(
                            "Offer Ride",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),

                  //Save Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.orange,
                        child: MaterialButton(
                          // minWidth: 200,
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
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

                  //profile showing card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.orange),
                    ),
                    color: Colors.grey.shade200,
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.account_circle),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                        "${loggedInUser.firstName} ${loggedInUser.secondName}",
                                        style: TextStyle(fontSize: 20)),
                                  ),
                                ],
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${loggedInUser.source} -> GNDEC',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${loggedInUser.email}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                letterSpacing: 0.8),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                SizedBox(width: 8),
                                TextButton(
                                  child: Text(
                                    '${loggedInUser.mode}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {},
                                ),
                                SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //Rides matches with same Location
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Rides Matches with your Location : ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //toogle setting

                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.orange,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = false;
                                });
                              },
                              child: Column(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                                  Text(
                                    "Find ride",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: isSignupScreen
                                            ? Colors.black38
                                            : Colors.black),
                                  ),
                                  if (!isSignupScreen)
                                    Container(
                                      margin: EdgeInsets.only(top: 3),
                                      height: 2,
                                      width: 100,
                                      color: Colors.orange,
                                    ),
                                ],
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 2,
                              color: Colors.orange,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = true;
                                });
                              },
                              child: Column(children: [
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                                Text(
                                  "Offer Ride",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: isSignupScreen
                                          ? Colors.black
                                          : Colors.black38),
                                ),
                                if (isSignupScreen)
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 100,
                                    color: Colors.orange,
                                  ),
                              ]),
                            ),
                          ],
                        ),
                        //Offer Ride
                        if (isSignupScreen)
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 340,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                border: Border.all(color: Colors.orange),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .where("source",
                                        isEqualTo: "${loggedInUser.source}")
                                    .where("mode", isEqualTo: "Offer Ride")
                                    // .where("email", isNotEqualTo: "${loggedInUser.email}")
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "No Data Available",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    );
                                  }

                                  return Scrollbar(
                                    thickness: 10,
                                    radius: Radius.circular(50),
                                    // isAlwaysShown: true,
                                    child: ListView(
                                      scrollDirection: Axis.vertical,
                                      padding: EdgeInsets.all(10),
                                      children:
                                          snapshot.data!.docs.map((document) {
                                        return Container(
                                          child: Center(
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: BorderSide(
                                                    color: Colors.orange),
                                              ),
                                              color: Colors.grey.shade100,
                                              child: InkWell(
                                                splashColor:
                                                    Colors.blue.withAlpha(30),
                                                onTap: () {
                                                  _launchURL(
                                                      document['email'],
                                                      'WE-SHARE Ride',
                                                      'Message');
                                                  // Navigator.of(context).push(MaterialPageRoute(
                                                  //     builder: (context) => CardDetail()));
                                                  // print('Card tapped.');
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      ListTile(
                                                        leading: Icon(Icons
                                                            .account_circle),
                                                        title: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: RichText(
                                                                  text: TextSpan(
                                                                      text: document[
                                                                          'firstName'],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20.0,
                                                                          color: Colors
                                                                              .black),
                                                                      children: <
                                                                          TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            " "),
                                                                    TextSpan(
                                                                        text: document[
                                                                            'secondName'],
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20.0,
                                                                            color:
                                                                                Colors.black))
                                                                  ])),
                                                            ),
                                                            // Expanded(
                                                            //   child: Text(
                                                            //       "xccxcxcbxcbxbxc"
                                                            //       // document[
                                                            //       //     'firstName']
                                                            //       ,
                                                            //       style:
                                                            //           TextStyle(
                                                            //         fontSize:
                                                            //             20.0,
                                                            //       )),
                                                            // ),
                                                            // SizedBox(width: 5),
                                                            // Text(
                                                            //     document[
                                                            //         'secondName'],
                                                            //     style:
                                                            //         TextStyle(
                                                            //       fontSize:
                                                            //           20.0,
                                                            //     )),
                                                          ],
                                                        ),
                                                        subtitle: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 5),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    child:
                                                                        RichText(
                                                                            text: TextSpan(
                                                                                text: document['source'],
                                                                                style: TextStyle(fontSize: 17.0, color: Colors.black54),
                                                                                children: <TextSpan>[
                                                                          TextSpan(
                                                                              text: " -> GNDEC",
                                                                              style: TextStyle(fontSize: 16.0, color: Colors.black54))
                                                                        ])),
                                                                  ),
                                                                  // Text(
                                                                  //   document[
                                                                  //       'source'],
                                                                  //   style: TextStyle(
                                                                  //       fontSize:
                                                                  //           17),
                                                                  // ),
                                                                  // Text(
                                                                  //     " -> GNDEC",
                                                                  //     style: TextStyle(
                                                                  //         fontSize:
                                                                  //             16)),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height: 5),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      document[
                                                                          "email"],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          letterSpacing:
                                                                              0.8),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: <Widget>[
                                                          SizedBox(width: 8),
                                                          TextButton(
                                                            child: Text(
                                                              document['mode'],
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            onPressed: () {
                                                              print(Text(
                                                                  document[
                                                                      'email']));
                                                              // print(document["email"]);
                                                            },
                                                          ),
                                                          SizedBox(width: 8),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                        //Find Ride
                        if (!isSignupScreen)
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 340,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                border: Border.all(color: Colors.orange),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .where("source",
                                        isEqualTo: "${loggedInUser.source}")
                                    .where("mode", isEqualTo: "Find Ride")
                                    // .where("email",                                        isNotEqualTo: "${loggedInUser.email}")
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "No Data Available",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    );
                                  }

                                  return Scrollbar(
                                    thickness: 10,
                                    radius: Radius.circular(50),
                                    // isAlwaysShown: true,
                                    child: ListView(
                                      scrollDirection: Axis.vertical,
                                      padding: EdgeInsets.all(10),
                                      children:
                                          snapshot.data!.docs.map((document) {
                                        return Container(
                                          child: Center(
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: BorderSide(
                                                    color: Colors.orange),
                                              ),
                                              color: Colors.grey.shade100,
                                              child: InkWell(
                                                splashColor:
                                                    Colors.blue.withAlpha(30),
                                                onTap: () {
                                                  _launchURL(
                                                      document['email'],
                                                      'WE-SHARE Ride',
                                                      'Message');
                                                  // Navigator.of(context).push(MaterialPageRoute(
                                                  //     builder: (context) => CardDetail()));
                                                  // print('Card tapped.');
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      ListTile(
                                                        leading: Icon(Icons
                                                            .account_circle),
                                                        title: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: RichText(
                                                                  text: TextSpan(
                                                                      text: document[
                                                                          'firstName'],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20.0,
                                                                          color: Colors
                                                                              .black),
                                                                      children: <
                                                                          TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            " "),
                                                                    TextSpan(
                                                                        text: document[
                                                                            'secondName'],
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20.0,
                                                                            color:
                                                                                Colors.black))
                                                                  ])),
                                                            ),
                                                            // Text(
                                                            //     document[
                                                            //         'firstName'],
                                                            //     style:
                                                            //         TextStyle(
                                                            //       fontSize:
                                                            //           20.0,
                                                            //     )),
                                                            // SizedBox(width: 5),
                                                            // Text(
                                                            //     document[
                                                            //         'secondName'],
                                                            //     style:
                                                            //         TextStyle(
                                                            //       fontSize:
                                                            //           20.0,
                                                            //     )),
                                                          ],
                                                        ),
                                                        subtitle: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 5),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    child:
                                                                        RichText(
                                                                            text: TextSpan(
                                                                                text: document['source'],
                                                                                style: TextStyle(fontSize: 17.0, color: Colors.black54),
                                                                                children: <TextSpan>[
                                                                          TextSpan(
                                                                              text: " -> GNDEC",
                                                                              style: TextStyle(fontSize: 16.0, color: Colors.black54))
                                                                        ])),
                                                                  ),
                                                                  // Text(
                                                                  //   document[
                                                                  //       'source'],
                                                                  //   style: TextStyle(
                                                                  //       fontSize:
                                                                  //           17),
                                                                  // ),
                                                                  // Text(
                                                                  //     " -> GNDEC",
                                                                  //     style: TextStyle(
                                                                  //         fontSize:
                                                                  //             16)),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height: 5),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      document[
                                                                          "email"],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          letterSpacing:
                                                                              0.8),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: <Widget>[
                                                          SizedBox(width: 8),
                                                          TextButton(
                                                            child: Text(
                                                              document['mode'],
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            onPressed: () {
                                                              // print(Text(                                                                  '${loggedInUser.email}'));
                                                              print(document[
                                                                  "email"]);
                                                            },
                                                          ),
                                                          SizedBox(width: 8),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  //all available rides
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "All available Rides : ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //toogle setting in main container
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.orange,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = false;
                                });
                              },
                              child: Column(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                                  Text(
                                    "Find ride",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: isSignupScreen
                                            ? Colors.black38
                                            : Colors.black),
                                  ),
                                  if (!isSignupScreen)
                                    Container(
                                      margin: EdgeInsets.only(top: 3),
                                      height: 2,
                                      width: 100,
                                      color: Colors.orange,
                                    ),
                                ],
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 2,
                              color: Colors.orange,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = true;
                                });
                              },
                              child: Column(children: [
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                                Text(
                                  "Offer Ride",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: isSignupScreen
                                          ? Colors.black
                                          : Colors.black38),
                                ),
                                if (isSignupScreen)
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 100,
                                    color: Colors.orange,
                                  ),
                              ]),
                            ),
                          ],
                        ),

                        //Offer Ride cards
                        if (isSignupScreen)
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 340,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                border: Border.all(color: Colors.orange),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    // .where("source", isEqualTo: "${loggedInUser.source}")
                                    .where("mode", isEqualTo: "Offer Ride")
                                    .orderBy("source")
                                    // .where("email", isNotEqualTo: "${loggedInUser.email}")
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "No Data Available",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    );
                                  }

                                  return Scrollbar(
                                    thickness: 10,
                                    radius: Radius.circular(50),
                                    // isAlwaysShown: true,
                                    child: ListView(
                                      scrollDirection: Axis.vertical,
                                      padding: EdgeInsets.all(10),
                                      children:
                                          snapshot.data!.docs.map((document) {
                                        return Container(
                                          child: Center(
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: BorderSide(
                                                    color: Colors.orange),
                                              ),
                                              color: Colors.grey.shade100,
                                              child: InkWell(
                                                splashColor:
                                                    Colors.blue.withAlpha(30),
                                                onTap: () {
                                                  _launchURL(
                                                      document['email'],
                                                      'WE-SHARE Ride',
                                                      'Message');
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      ListTile(
                                                        leading: Icon(Icons
                                                            .account_circle),
                                                        title: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: RichText(
                                                                  text: TextSpan(
                                                                      text: document[
                                                                          'firstName'],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20.0,
                                                                          color: Colors
                                                                              .black),
                                                                      children: <
                                                                          TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            " "),
                                                                    TextSpan(
                                                                        text: document[
                                                                            'secondName'],
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20.0,
                                                                            color:
                                                                                Colors.black))
                                                                  ])),
                                                            ),
                                                            // Text(
                                                            //     document[
                                                            //         'firstName'],
                                                            //     style:
                                                            //         TextStyle(
                                                            //       fontSize:
                                                            //           20.0,
                                                            //     )),
                                                            // SizedBox(width: 5),
                                                            // Text(
                                                            //     document[
                                                            //         'secondName'],
                                                            //     style:
                                                            //         TextStyle(
                                                            //       fontSize:
                                                            //           20.0,
                                                            //     )),
                                                          ],
                                                        ),
                                                        subtitle: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 5),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    child:
                                                                        RichText(
                                                                            text: TextSpan(
                                                                                text: document['source'],
                                                                                style: TextStyle(fontSize: 17.0, color: Colors.black54),
                                                                                children: <TextSpan>[
                                                                          TextSpan(
                                                                              text: " -> GNDEC",
                                                                              style: TextStyle(fontSize: 16.0, color: Colors.black54))
                                                                        ])),
                                                                  ),
                                                                  // Text(
                                                                  //   document[
                                                                  //       'source'],
                                                                  //   style: TextStyle(
                                                                  //       fontSize:
                                                                  //           17),
                                                                  // ),
                                                                  // Text(
                                                                  //     " -> GNDEC",
                                                                  //     style: TextStyle(
                                                                  //         fontSize:
                                                                  //             16)),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height: 5),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      document[
                                                                          "email"],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          letterSpacing:
                                                                              0.8),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: <Widget>[
                                                          SizedBox(width: 8),
                                                          TextButton(
                                                            child: Text(
                                                              document['mode'],
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            onPressed: () {
                                                              print(Text(
                                                                  document[
                                                                      'email']));
                                                              // print(document["email"]);
                                                            },
                                                          ),
                                                          SizedBox(width: 8),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                        //Find User card
                        if (!isSignupScreen)
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 340,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                border: Border.all(color: Colors.orange),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .where("mode", isEqualTo: "Find Ride")
                                    .orderBy("source")

                                    // .where("email",
                                    //     isNotEqualTo: "${loggedInUser.email}")
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "No Data Available",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    );
                                  }

                                  return Scrollbar(
                                    thickness: 10,
                                    radius: Radius.circular(50),
                                    // isAlwaysShown: true,
                                    child: ListView(
                                      scrollDirection: Axis.vertical,
                                      padding: EdgeInsets.all(10),
                                      children:
                                          snapshot.data!.docs.map((document) {
                                        return Container(
                                          child: Center(
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: BorderSide(
                                                    color: Colors.orange),
                                              ),
                                              color: Colors.grey.shade100,
                                              child: InkWell(
                                                splashColor:
                                                    Colors.blue.withAlpha(30),
                                                onTap: () {
                                                  _launchURL(
                                                      document['email'],
                                                      'WE-SHARE Ride',
                                                      'Message');
                                                  // Navigator.of(context).push(MaterialPageRoute(
                                                  //     builder: (context) => CardDetail()));
                                                  // print('Card tapped.');
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      ListTile(
                                                        leading: Icon(Icons
                                                            .account_circle),
                                                        title: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: RichText(
                                                                  text: TextSpan(
                                                                      text: document[
                                                                          'firstName'],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20.0,
                                                                          color: Colors
                                                                              .black),
                                                                      children: <
                                                                          TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            " "),
                                                                    TextSpan(
                                                                        text: document[
                                                                            'secondName'],
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20.0,
                                                                            color:
                                                                                Colors.black))
                                                                  ])),
                                                            ),
                                                            // Text(
                                                            //     document[
                                                            //         'firstName'],
                                                            //     style:
                                                            //         TextStyle(
                                                            //       fontSize:
                                                            //           20.0,
                                                            //     )),
                                                            // SizedBox(width: 5),
                                                            // Text(
                                                            //     document[
                                                            //         'secondName'],
                                                            //     style:
                                                            //         TextStyle(
                                                            //       fontSize:
                                                            //           20.0,
                                                            //     )),
                                                          ],
                                                        ),
                                                        subtitle: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 5),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    child:
                                                                        RichText(
                                                                            text: TextSpan(
                                                                                text: document['source'],
                                                                                style: TextStyle(fontSize: 17.0, color: Colors.black54),
                                                                                children: <TextSpan>[
                                                                          TextSpan(
                                                                              text: " -> GNDEC",
                                                                              style: TextStyle(fontSize: 16.0, color: Colors.black54))
                                                                        ])),
                                                                  ),
                                                                  // Text(
                                                                  //   document[
                                                                  //       'source'],
                                                                  //   style: TextStyle(
                                                                  //       fontSize:
                                                                  //           17),
                                                                  // ),
                                                                  // Text(
                                                                  //     " -> GNDEC",
                                                                  //     style: TextStyle(
                                                                  //         fontSize:
                                                                  //             16)),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height: 5),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      document[
                                                                          "email"],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          letterSpacing:
                                                                              0.8),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: <Widget>[
                                                          SizedBox(width: 8),
                                                          TextButton(
                                                            child: Text(
                                                              document['mode'],
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            onPressed: () {
                                                              // print(Text(                                                                  '${loggedInUser.email}'));
                                                              print(document[
                                                                  "email"]);
                                                            },
                                                          ),
                                                          SizedBox(width: 8),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                              "Please Delete your profile after successful Ride",
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 16,
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //for (int i = 0; i < 2; i++) cardField
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //email opening function
  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
      Fluttertoast.showToast(msg: "Send to Gmail");
    } else {
      throw 'Could not launch $url';
    }
  }

  //Logout Function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
