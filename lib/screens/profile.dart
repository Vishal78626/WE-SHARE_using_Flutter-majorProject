import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:major_project/model/user_model.dart';
import 'package:major_project/screens/Start.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
// FirebaseUser user = await FirebaseAuth.instance.currentUser();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.account_circle,
                        size: 150,
                        color: Colors.grey,
                      ),
                      TextField(
                        enabled: true,
                        readOnly: true,
                        autofocus: false,
                        decoration: InputDecoration(
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
                          labelText: "First Name",
                          labelStyle: TextStyle(
                            fontSize: 20.0,
                            color: Colors.orange,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "${loggedInUser.firstName}",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        enabled: true,
                        readOnly: true,
                        autofocus: false,
                        decoration: InputDecoration(
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
                          labelText: "Last Name",
                          labelStyle: TextStyle(
                            fontSize: 20.0,
                            color: Colors.orange,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "${loggedInUser.secondName}",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        enabled: true,
                        readOnly: true,
                        autofocus: false,
                        decoration: InputDecoration(
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
                          labelText: "Email",
                          labelStyle: TextStyle(
                            fontSize: 20.0,
                            color: Colors.orange,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "${loggedInUser.email}",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        enabled: true,
                        readOnly: true,
                        autofocus: false,
                        decoration: InputDecoration(
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
                          labelText: "Ride Mode",
                          labelStyle: TextStyle(
                            fontSize: 20.0,
                            color: Colors.orange,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "${loggedInUser.mode}",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        enabled: true,
                        readOnly: true,
                        autofocus: false,
                        decoration: InputDecoration(
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
                          labelText: "Source",
                          labelStyle: TextStyle(
                            fontSize: 20.0,
                            color: Colors.orange,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "${loggedInUser.source}",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        maxLines: 2,
                        enabled: true,
                        readOnly: true,
                        autofocus: false,
                        decoration: InputDecoration(
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
                          hintText:
                              "Guru Nanak Dev Engineering College, Ludhiana",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.orange,
                        child: MaterialButton(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {
                            showDialog(
                                barrierColor: Colors.black54,
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text("Delete Profile"),
                                      content: Text("Do you want to delete ?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            deleteUser();
                                          },
                                          child: Text(
                                            "Ok",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));

                            // signIn(emailController.text, passwordController.text);
                          },
                          child: Text(
                            "Delete Profile",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //delete user
  Future<void>? deleteUser() {
    // FirebaseUser user= await FirebaseAuth.instance.currentUser();
    user!.delete();
    FirebaseFirestore.instance.collection("users").doc(user!.uid).delete().then(
        (value) => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Start())));
    Fluttertoast.showToast(msg: "User Deleted Successful");
    return null;
  }
}
