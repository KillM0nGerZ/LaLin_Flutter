import 'package:flutter/material.dart';
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
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
}
