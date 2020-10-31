import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {
  final String valueFromHome;
  ProfilePage({Key key, this.valueFromHome}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<ProfilePage> {
  // String valuename = this.valueFromHome;
  String name;
  // @override
  // void initState() {
  //   super.initState();
  //   _selectdata();
  // }

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
                Text("ชื่อ ${_selectdata()}", style: TextStyle(fontSize: 30)),
                Text("อีเมล์ ${widget.valueFromHome}",
                    style: TextStyle(fontSize: 30)),
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
              MaterialPageRoute(builder: (context) => Chat(valueFromHome: widget.valueFromHome)),
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
            // selectdata();
          },
        ));
  }

  mySizebox() => SizedBox(
        width: 8.0,
        height: 10.0,
      );
  
  String _selectdata() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // String item;
    firestore
        .collection("member")
        .doc(widget.valueFromHome)
        .get()
        .then((value) {
          setState(() {
            this.name = value.get('name');
          });
      // print(value.data());
    });
    // print(this.name);
    return this.name;
  }

  
}
