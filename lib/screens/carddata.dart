import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:major_project/model/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CardDetail extends StatefulWidget {
  CardDetail({Key? key}) : super(key: key);

  @override
  _CardDetailState createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        // title: Text("geeksforgeeks"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            // .where("source", isEqualTo: "Haibowal")
            .where("mode", isEqualTo: "Find Ride")
            .orderBy("source")
            // .where("email", isNotEqualTo: "${loggedInUser.email}")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: snapshot.data!.docs.map((document) {
                return Container(
                  child: Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.orange),
                      ),
                      color: Colors.grey.shade200,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          _launchURL(
                              document['email'], 'WE-SHARE Ride', 'Message');
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => CardDetail()));
                          // print('Card tapped.');
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.account_circle),
                              title: Row(
                                children: <Widget>[
                                  Text(document['firstName'],
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      )),
                                  SizedBox(width: 5),
                                  Text(document['secondName'],
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      )),
                                ],
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Column(
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          document['source'],
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        Text(" -> GNDEC",
                                            style: TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          document["email"],
                                          style: TextStyle(
                                              fontSize: 16, letterSpacing: 0.8),
                                        )
                                      ],
                                    )
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
                                    document['mode'],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {/* ... */},
                                ),
                                SizedBox(width: 8),
                              ],
                            ),
                          ],
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
    );

    // Scaffold(
    //   body: Center(
    //     child: Padding(
    //       padding: const EdgeInsets.all(30.0),
    //       child: Container(
    //         child: Column(
    //           children: <Widget>[
    //             ElevatedButton(
    //               onPressed: () {
    //                 FirebaseFirestore.instance
    //                     .collection('users')
    //                     .get()
    //                     .then((QuerySnapshot querySnapshot) {
    //                   querySnapshot.docs.forEach((doc) {
    //                     print(doc["source"]);
    //                   });
    //                 });
    //               },
    //               child: Text("click me"),
    //             ),
    //             ListTile(
    //               title: Text("hello"),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
      Fluttertoast.showToast(msg: "Send to Gmail");
    } else {
      throw 'Could not launch $url';
    }
  }
}
