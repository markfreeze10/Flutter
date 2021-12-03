import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myfitnessapp/screens/exercises.dart';
import 'package:myfitnessapp/screens/login.dart';
import 'package:myfitnessapp/userdata/userdata.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController regUserNameController =
      new TextEditingController();
  final TextEditingController regEmailEditingController =
      new TextEditingController();
  final TextEditingController regPasswordEditingController =
      new TextEditingController();
  final TextEditingController regConfirmPWEditingController =
      new TextEditingController();

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final userNameField = TextFormField(
        style: TextStyle(color: Colors.white),
        autofocus: false,
        controller: regUserNameController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Das Textfeld ist leer");
          }
          if (!regex.hasMatch(value)) {
            return ("Der Username muss mindestens 3 Zeichen haben");
          }
        },
        onSaved: (value) {
          regUserNameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: Colors.grey,
            ),
            contentPadding: EdgeInsets.fromLTRB(30, 15, 20, 15),
            hintText: "Username",
            hintStyle: TextStyle(color: Colors.grey),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))));

    final emailField = TextFormField(
        style: TextStyle(color: Colors.white),
        autofocus: false,
        controller: regEmailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Das Textfeld ist leer");
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Die Email-Adresse ist ungültig");
          }
          return null;
        },
        onSaved: (value) {
          regEmailEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.mail,
              color: Colors.grey,
            ),
            contentPadding: EdgeInsets.fromLTRB(30, 15, 20, 15),
            hintText: "Email",
            hintStyle: TextStyle(color: Colors.grey),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))));

    final passwordField = TextFormField(
        style: TextStyle(color: Colors.white),
        autofocus: false,
        controller: regPasswordEditingController,
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Das Textfeld ist leer");
          }
          if (!regex.hasMatch(value)) {
            return ("Das Passwort muss mindestens 6 Zeichen haben");
          }
        },
        onSaved: (value) {
          regPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.vpn_key,
              color: Colors.grey,
            ),
            contentPadding: EdgeInsets.fromLTRB(30, 15, 20, 15),
            hintText: "Passwort",
            hintStyle: TextStyle(color: Colors.grey),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))));

    final confirmPasswordField = TextFormField(
        style: TextStyle(color: Colors.white),
        autofocus: false,
        controller: regConfirmPWEditingController,
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (regPasswordEditingController.text !=
              regConfirmPWEditingController.text) {
            return ("Passwörter stimmen nicht überein");
          }
          return null;
        },
        onSaved: (value) {
          regConfirmPWEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.vpn_key,
              color: Colors.grey,
            ),
            contentPadding: EdgeInsets.fromLTRB(30, 15, 20, 15),
            hintText: "Passwort bestätigen",
            hintStyle: TextStyle(color: Colors.grey),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))));

    final registrationButton = Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        color: Colors.blueAccent,
        child: MaterialButton(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () {
              signUp(regEmailEditingController.text,
                  regPasswordEditingController.text);
            },
            child: Text(
              "Registrierung",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )));

    return Scaffold(
        backgroundColor: Color(0xff2b2c3c),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          //elevation
          elevation: 0,
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      //color: Colors.black,
                      border: Border.all(color: Colors.black),
                      //color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.transparent, spreadRadius: 3),
                      ],
                    ),
                    //decoration: new BoxDecoration(
                    //    color: Colors.white,
                    //    borderRadius: BorderRadius.all(Radius.circular(20))),
                    margin: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 30.0, bottom: 30.0),
                    child: Form(
                        key: _formKey,
                        child:
                            Column(mainAxisAlignment: MainAxisAlignment.center,
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.all(15),
                                  child: userNameField),
                              Padding(
                                  padding: EdgeInsets.all(15),
                                  child: emailField),
                              Padding(
                                  padding: EdgeInsets.all(15),
                                  child: passwordField),
                              Padding(
                                  padding: EdgeInsets.all(15),
                                  child: confirmPasswordField),
                              Padding(
                                  padding: EdgeInsets.all(10),
                                  child: registrationButton)
                            ]))))));
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {sendDataToFireStore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  sendDataToFireStore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserData userData = UserData();

    userData.email = user!.email;
    userData.uid = user.uid;
    userData.username = regUserNameController.text;

    await firebaseFirestore
        .collection("userdata")
        .doc(user.uid)
        .set(userData.toMap());
    Fluttertoast.showToast(msg: "Account wurde erstellt");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => ExerciseScreen()),
        (route) => false);
  }
}
