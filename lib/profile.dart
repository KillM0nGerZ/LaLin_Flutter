import 'package:flutter/material.dart';
import 'chat.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<ProfilePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("หน้าหลัก", style: TextStyle(fontSize: 30)),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                img(),
                mySizebox(),
                Text("ชื่อ ออฟ", style: TextStyle(fontSize: 30)),
                Text("อีเมล์ 60020671@up.ac.th",style: TextStyle(fontSize: 30)),
                mySizebox(),
                chatInput(),
                logout(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container img() {
    return Container(
      width: 300,
      height: 300,
      child: Image.asset('images/robot.png'),
    );
  }

  Container chatInput() {
    return Container(
        width: 500,
        height: 70,
        padding: EdgeInsets.all(10),
        child: RaisedButton(
          textColor: Colors.white,
          color: Colors.blue,
          child: Text('แชท', style: TextStyle(fontSize: 20)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Chat()),
            );
          },
        ));
  }

  Container logout() {
    return Container(
        width: 500,
        height: 70,
        padding: EdgeInsets.all(10),
        child: RaisedButton(
          textColor: Colors.white,
          color: Colors.red,
          child: Text('ออกจากระบบ', style: TextStyle(fontSize: 20)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ));
  }

  mySizebox() => SizedBox(
        width: 8.0,
        height: 10.0,
      );
}
