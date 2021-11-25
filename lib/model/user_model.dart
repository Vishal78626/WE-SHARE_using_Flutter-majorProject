class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  //here
  String? source;
  String? mode;

  //here
  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.secondName,
      this.source,
      this.mode});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      source: map['source'], //here
      mode: map['mode'],
    );
  }

  // sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'source': source,
      'mode': mode,
    };
  }
}
