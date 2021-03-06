import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'profile.dart';

// class Chat extends StatelessWidget {
//   // This widget is the root of your application.
//   final String valueFromHome;
//   Chat({Key key, this.valueFromHome}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Chatbot Flask',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter & Python'),
//     );
//   }
// }

// class Chat extends StatefulWidget {
//   Chat({Key key, this.title}) : super(key: key);

//   final String title;
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

class Chat extends StatefulWidget {
  final String valueFromHome;
  Chat({Key key, this.valueFromHome}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<Chat> {
  String name;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  List<String> _data = [];
  static const String BOT_URL =
      "https://fast-chamber-75339.herokuapp.com/bot"; // replace with server address
      
  TextEditingController _queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("LaLin", style: TextStyle(fontSize: 30)),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage(
                        valueFromHome: widget.valueFromHome,
                      )),
            );
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
                child: Container(
                    padding: EdgeInsets.only(top: 15, bottom: 10),
                    child: Text(
                      "Today, ${DateFormat("Hm").format(DateTime.now())}",
                      style: TextStyle(fontSize: 20),
                    ))),
            Flexible(
              child: AnimatedList(
                key: _listKey,
                initialItemCount: _data.length,
                itemBuilder:
                    (BuildContext context, int index, Animation animation) {
                  return _buildItem(_data[index], animation, index);
                },
              ),
            ),
            Divider(
              height: 5,
              color: Colors.greenAccent,
            ),
            Container(
              child: ListTile(
                title: Container(
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color.fromRGBO(220, 220, 220, 1)),
                  padding: EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: _queryController,
                    decoration: InputDecoration(
                      hintText: "Enter a message",
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    onFieldSubmitted: (msg) {
                      this._getResponse();
                    },
                  ),
                ),
                trailing: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 30,
                      color: Colors.greenAccent,
                    ),
                    onPressed: () {
                      if (_queryController.text.isEmpty) {
                        print("empty message");
                      } else {
                        this._getResponse();
                      }
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  http.Client _getClient() {
    return http.Client();
  }

  void _getResponse() {
    if (_queryController.text.length > 0) {
      this._insertSingleItem(_queryController.text);
      var client = _getClient();
      try {
        client.post(
          BOT_URL,
          body: {
            "query": _queryController.text,
            "stu_id": '60020671',
            "name": _selectdata()
          },
        )..then((response) {
            Map<String, dynamic> data = jsonDecode(response.body);
            _insertSingleItem(data['response'] + "<bot>");
          });
      } catch (e) {
        print("Failed -> $e");
      } finally {
        client.close();
        _queryController.clear();
      }
    }
  }

  void _insertSingleItem(String message) {
    _data.add(message);
    _listKey.currentState.insertItem(_data.length - 1);
  }

  Widget _buildItem(String item, Animation animation, int index) {
    bool mine = item.endsWith("<bot>");
    print(item);
    return SizeTransition(
        sizeFactor: animation,
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Container(
              alignment: mine ? Alignment.topLeft : Alignment.topRight,
              child: Bubble(
                child: Text(item.replaceAll("<bot>", "")),
                color: mine ? Colors.blue[200] : Colors.green[200],
                padding: BubbleEdges.all(10),
              )),
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
          onPressed: () {},
        ));
  }

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
