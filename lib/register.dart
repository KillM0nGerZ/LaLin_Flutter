import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<RegisterPage> {
  final databaseReference = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
            signUp();
            insertValueMem();
            // readAllData();
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
        obscureText: true,
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
          'LaLin',
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 70),
        ));
  }

  Future<void> insertValueMem() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    Map<String, dynamic> map = Map();
    map['name'] = name.text;
    map['password'] = passwordController.text;
    map['email'] = emailController.text;

    await firestore.collection('member').doc(emailController.text).set(map).then((value) {
      print('Insert Success');
    });
  }


  signUp() {
    String _username = emailController.text.trim();
    String _password = passwordController.text.trim();
    String confirmPassword = cpasswordController.text.trim();
    if (_password == confirmPassword && _password.length >= 6) {
      _auth
          .createUserWithEmailAndPassword(email: _username, password: _password)
          .then((user) {
        print("Sign up user successful.");
        welcome();
      }).catchError((error) {
        _checkEmail();
        print(error.message);
      });
    } else {
      _showMyDialog();
      print("Password and Confirm-password is not match.");
    }
  }

  Future<void> welcome() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ยินดีต้อนรับ'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('สมัครเสร็จสิ้น'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ตกลง'),
              onPressed: () {
                Navigator.of(context).pop();
                MaterialPageRoute materialPageRoute = MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage());
                Navigator.of(context).pushAndRemoveUntil(
                    materialPageRoute, (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('รหัสผ่านไม่ตรงกัน'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ตกลง'),
              onPressed: () {
                Navigator.of(context).pop();
                cpasswordController.text = "";
                passwordController.text = "";
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _checkEmail() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('อีเมลล์ซ้ำ'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ตกลง'),
              onPressed: () {
                Navigator.of(context).pop();
                emailController.text = "";
                // password.text = "";
              },
            ),
          ],
        );
      },
    );
  }
}
