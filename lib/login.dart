import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register.dart';
import 'profile.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String value;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                logo_text(),
                username(),
                password(),
                mySizebox(),
                login(),
                register()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container register() {
    return Container(
        child: Row(
      children: <Widget>[
        // Text('Does not have account?'),
        FlatButton(
          textColor: Colors.blue,
          child: Text(
            'สมัครสมาชิก',
            style: TextStyle(fontSize: 16),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterPage()),
            );
          },
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ));
  }

  Container login() {
    return Container(
        width: 500,
        height: 50,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: RaisedButton(
          textColor: Colors.white,
          color: Colors.blue,
          child: Text('เข้าสู่ระบบ'),
          onPressed: () {
            value = emailController.text.trim();
            print(value);
            checkAuthe();
          },
        ));
  }

  mySizebox() => SizedBox(
        width: 8.0,
        height: 20.0,
      );
  Container password() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: TextField(
        obscureText: true,
        controller: passwordController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'รหัสผ่าน',
        ),
      ),
    );
  }

  Container username() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: emailController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'อีเมล',
        ),
      ),
    );
  }

  Container logo_text() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Text(
          'LaLin',
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 70),
        ));
  }

  Future<void> checkAuthe() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    String _username = emailController.text.trim();
    String _password = passwordController.text.trim();
    await firebaseAuth
        .signInWithEmailAndPassword(email: _username, password: _password)
        .then((response) {
      print('Authen Success');
      MaterialPageRoute materialPageRoute = MaterialPageRoute(
          builder: (BuildContext context) => ProfilePage(
                valueFromHome: emailController.text,
              ));
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }).catchError((response) {
      _showMyDialog();
      print('ไม่ผ่าน');
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ไม่สามารถเข้าสู่ระบบได้'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('รหัสผ่านไม่ถูกต้อง'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ตกลง'),
              onPressed: () {
                Navigator.of(context).pop();
                emailController.text = "";
                passwordController.text = "";
              },
            ),
          ],
        );
      },
    );
  }
}
