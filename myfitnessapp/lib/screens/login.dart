import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myfitnessapp/base.dart';

import '../base.dart';
import 'registration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController loginEmailController =
      new TextEditingController();
  final TextEditingController loginPasswordController =
      new TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      style: TextStyle(color: Colors.white),
      autofocus: false,
      controller: loginEmailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Das Textfeld ist leer");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Die Email-Adresse ist ungültig");
        }
        return null;
      },
      onSaved: (value) {
        loginEmailController.text = value!;
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );

    final passwordField = TextFormField(
      style: TextStyle(color: Colors.white),
      autofocus: false,
      controller: loginPasswordController,
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
        loginPasswordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.vpn_key,
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Passwort",
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );

    final loginButton = Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff31a6dc),
        child: MaterialButton(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () {
              signIn(loginEmailController.text, loginPasswordController.text);
            },
            child: Text(
              "Einloggen",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )));

    return Scaffold(
        backgroundColor: Color(0xff2b2c3c),
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
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text('Login',
                              style: TextStyle(
                                  fontSize: 30.0, color: Color(0xff31a6dc))),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                top: 30, left: 10, right: 10, bottom: 10),
                            child: emailField),
                        Padding(
                            padding: EdgeInsets.all(10), child: passwordField),
                        Padding(
                            padding: EdgeInsets.all(10), child: loginButton),
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Sie haben keinen Account? ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegistrationScreen()));
                                    },
                                    child: Text("Hier registrieren",
                                        style: TextStyle(
                                            color: Color(0xff31a6dc),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15)))
                              ],
                            ))
                      ])),
            ),
          ),
        ));
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login erfolgreich"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => BaseScreen()))
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
