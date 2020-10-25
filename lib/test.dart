// import 'dart:convert';
// import 'package:bubble/bubble.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// void main() => runApp(MyApp());
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Chatbot Flask',
//       theme: ThemeData(
// primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter & Python'),
//     );
//   }
// }
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
// final String title;
// @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
// class _MyHomePageState extends State<MyHomePage> {
// final GlobalKey<AnimatedListState> _listKey = GlobalKey();
//   List<String> _data = [];
//   static const String BOT_URL = "https://fast-chamber-75339.herokuapp.com/bot"; // replace with server address
//   TextEditingController _queryController = TextEditingController();
// @override
//   Widget build(BuildContext context) {
// return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("LaLin"),
//       ),
//       body: Stack(
//         children: <Widget>[
//           AnimatedList(
//             // key to call remove and insert from anywhere
//             key: _listKey,
//             initialItemCount: _data.length,
//             itemBuilder: (BuildContext context, int index, Animation animation){
//               return _buildItem(_data[index], animation, index);
//             }
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: TextField(
//               decoration: InputDecoration(
//                 icon: Icon(Icons.message, color: Colors.greenAccent,),
//                 hintText: "พิมพ์...",
//               ),
//               controller: _queryController,
//               textInputAction: TextInputAction.send,
//               onSubmitted: (msg){
// this._getResponse();
//               },
// ),
//           )
//         ],
//       )
//       ,
//     );
//   }
// http.Client _getClient(){
//     return http.Client();
//   }
// void _getResponse(){
//     if (_queryController.text.length>0){
//       this._insertSingleItem(_queryController.text);
//       var client = _getClient();
//       try{
//         client.post(BOT_URL, body: {"query" : _queryController.text},)
//         ..then((response){
//           Map<String, dynamic> data = jsonDecode(response.body);
//           _insertSingleItem(data['response']+"<bot>");
// });
//       }catch(e){
//         print("Failed -> $e");
//       }finally{
//         client.close();
//         _queryController.clear();
//       }
//     }
//   }
// void _insertSingleItem(String message){
// _data.add(message);
//     _listKey.currentState.insertItem(_data.length-1);
//   }
//   Widget _buildItem(String item, Animation animation,int index){
//     bool mine = item.endsWith("<bot>");
//     return SizeTransition(
//       sizeFactor: animation,
//       child: Padding(padding: EdgeInsets.only(top: 10),
//       child: Container(
//         alignment: mine ?  Alignment.topLeft : Alignment.topRight,
// child : Bubble(
//         child: Text(item.replaceAll("<bot>", "")),
//         color: mine ? Colors.yellow : Colors.yellow,
//         padding: BubbleEdges.all(10),
// )),
//     )
// );
//   }
// }








// import 'package:bubble/bubble.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         brightness: Brightness.dark,
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final messageController = TextEditingController();
//   static const String BOT_URL = "https://fast-chamber-75339.herokuapp.com/bot";
//   List<Map> _data = List();
//   final GlobalKey<AnimatedListState> _listKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: AppBar(
//         title: Text("LALIN"),
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             Center(
//                 child: Container(
//                     padding: EdgeInsets.only(top: 15, bottom: 10),
//                     child: Text(
//                       "Today, ${DateFormat("Hm").format(DateTime.now())}",
//                       style: TextStyle(fontSize: 20),
//                     ))),
//             Flexible(
//                 child: ListView.builder(
//                     reverse: true,
//                     itemCount: 0,
//                     itemBuilder: (context, index) => chat(
//                         _data[index]["message"].toString(),
//                         _data[index]["data"]))),
//             Divider(
//               height: 5,
//               color: Colors.greenAccent,
//             ),
//             Container(
//               child: ListTile(
//                 title: Container(
//                   height: 35,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(15)),
//                       color: Color.fromRGBO(220, 220, 220, 1)),
//                   padding: EdgeInsets.only(left: 15),
//                   child: TextFormField(
//                     controller: messageController,
//                     decoration: InputDecoration(
//                       hintText: "Enter a message",
//                       hintStyle: TextStyle(color: Colors.black26),
//                       border: InputBorder.none,
//                       focusedBorder: InputBorder.none,
//                       enabledBorder: InputBorder.none,
//                       errorBorder: InputBorder.none,
//                       disabledBorder: InputBorder.none,
//                     ),
//                     style: TextStyle(fontSize: 16, color: Colors.black),
//                   ),
//                 ),
//                 trailing: IconButton(
//                     icon: Icon(
//                       Icons.send,
//                       size: 30,
//                       color: Colors.greenAccent,
//                     ),
//                     onPressed: () {
//                       if (messageController.text.isEmpty) {
//                         print("empty message");
//                       } else {
//                         setState(() {
//                           _data.insert(0,
//                               {"data": 1, "message": messageController.text});
//                           print(_data);
//                         });
//                         this._getResponse();
                        
//                         messageController.clear();
//                       }
//                       FocusScopeNode currentFocus = FocusScope.of(context);
//                       if (!currentFocus.hasPrimaryFocus) {
//                         currentFocus.unfocus();
//                       }
//                     }),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   http.Client _getClient() {
//     return http.Client();
//   }

//   void _getResponse() {
//     if (messageController.text.length > 0) {
//       this._insertSingleItem(messageController.text);
//       var client = _getClient();
//       try {
//         client.post(
//           BOT_URL,
//           body: {"query": messageController.text},
//         )..then((response) {
//             Map<String, dynamic> data = jsonDecode(response.body);
//             _insertSingleItem(data['response'] + "<bot>");
//           });
//       } catch (e) {
//         print("Failed -> $e");
//       } finally {
//         client.close();
//         messageController.clear();
//       }
//     }
//   }

//   void _insertSingleItem(String message) {
//     _data.insert(0, {"data": 1, "message": messageController.text});
//     // print(_data.length);
//     // _listKey.currentState.insertItem(_data.length - 1);
//     // _listKey.currentState.insertItem(_data.length - 1);
//   }

//   Widget _buildItem(String item, Animation animation, int index) {
//     bool mine = item.endsWith("<bot>");
//     return SizeTransition(
//         sizeFactor: animation,
//         child: Padding(
//           padding: EdgeInsets.only(top: 10),
//           child: Container(
//               alignment: mine ? Alignment.topLeft : Alignment.topRight,
//               child: Bubble(
//                 child: Text(item.replaceAll("<bot>", "")),
//                 color: mine ? Colors.yellow : Colors.yellow,
//                 padding: BubbleEdges.all(10),
//               )),
//         ));
//   }

//   Widget chat(String message, int data) {
//     return Container(
//       padding: EdgeInsets.only(left: 20, right: 20),
//       child: Row(
//         mainAxisAlignment:
//             data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
//         children: [
//           data == 0
//               ? Container(
//                   height: 60,
//                   width: 60,
//                   child: CircleAvatar(
//                     backgroundImage: AssetImage("assets/robot.png"),
//                   ),
//                 )
//               : Container(),
//           Padding(
//             padding: EdgeInsets.all(10),
//             child: Bubble(
//               radius: Radius.circular(15),
//               color: data == 0
//                   ? Color.fromRGBO(23, 157, 139, 1)
//                   : Colors.orangeAccent,
//               elevation: 0,
//               child: Padding(
//                 padding: EdgeInsets.all(2),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Flexible(
//                         child: Container(
//                       constraints: BoxConstraints(maxWidth: 200),
//                       child: Text(
//                         message,
//                         style: TextStyle(
//                             color: Colors.white, fontWeight: FontWeight.bold),
//                       ),
//                     ))
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           data == 1
//               ? Container(
//                   height: 60,
//                   width: 60,
//                   child: CircleAvatar(
//                     backgroundImage: AssetImage("assets/robot.png"),
//                   ),
//                 )
//               : Container(),
//         ],
//       ),
//     );
//   }
// }