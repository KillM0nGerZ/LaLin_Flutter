import 'package:flutter/material.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

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
                nickname(),
                username(),
                password(),
                cpassword(),
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
            'ยกเลิก',
            style: TextStyle(fontSize: 16),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
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
        height: 70,
        padding: EdgeInsets.all(10),
        child: RaisedButton(
          textColor: Colors.white,
          color: Colors.blue,
          child: Text('บันทึก'),
          onPressed: () {
            print(emailController.text);
            print(passwordController.text);
          },
        ));
  }
  mySizebox() => SizedBox(
        width: 8.0,
        height: 10.0,
      );


  Container cpassword() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: cpasswordController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'ยืนยันรหัสผ่านอีกครั้ง',
        ),
      ),
    );
  }
  Container password() {
    return Container(
      padding: EdgeInsets.all(10),
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
  Container nickname() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: name,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'ชื่อเล่น',
        ),
      ),
    );
  }

  Container logo_text() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Text(
          'Codeplayon',
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 30),
        ));
  }
}
