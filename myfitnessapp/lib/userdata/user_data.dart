class UserData {
  String? uid;
  String? email;
  String? username;

  UserData({this.uid, this.email, this.username});

  factory UserData.fromMap(map) {
    return UserData(
        uid: map['uid'], email: map['email'], username: map['username']);
  }

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email, 'username': username};
  }
}
