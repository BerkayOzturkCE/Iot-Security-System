import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:security/page/login.dart';
import 'package:security/page/mainmenu.dart';
import 'package:security/util/appData.dart';
import 'package:wifi_iot/wifi_iot.dart';

class ChatPage extends StatefulWidget {
  final BluetoothDevice server;

  const ChatPage({this.server});

  @override
  _ChatPage createState() => new _ChatPage();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _ChatPage extends State<ChatPage> {
  static final clientID = 0;
  BluetoothConnection connection;
  String ssid = "", password = "";

  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool get isConnected => connection != null && connection.isConnected;

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Builder(
          builder: (context) => new Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColorLight
                    ])),
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20,top: 40),
                  child: Column(
                    children: [
                       Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child:IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.keyboard_backspace,
                                size: 30,
                              )),
                        ),
                        SizedBox(width:20 ,),
                        
                        (isConnecting
              ? Text('Bağlanılıyor ' + widget.server.name + '...',style: TextStyle(
                            fontSize: 25,
                            letterSpacing: 1,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),)
              : isConnected
                  ? Text('Bağlandı ' + widget.server.name,style: TextStyle(
                            fontSize: 25,
                            letterSpacing: 1,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),)
                  : Text('Chat log with ' + widget.server.name,style: TextStyle(
                            fontSize: 25,
                            letterSpacing: 1,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),)),
                        
                    
                      ],
                    ),


Container(
        padding: EdgeInsets.only(top: 60, bottom: 40, right: 30, left: 30),
        child: Column(children: <Widget>[
          TextField(
            style: TextStyle(
              color: AppConstant.textColor,
              fontSize: AppConstant.txtFieldSize,
              fontWeight: FontWeight.bold,
            ),
            onChanged: (String s) {
              ssid = s;
            },
            readOnly: false,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person_outline,
                color: AppConstant.iconColorDark,
              ),
              hintText: "Wifi ağının ismi",
              hintStyle: TextStyle(
                fontSize: AppConstant.txtFieldSize,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              fillColor: AppConstant.txtfieldBColors,
              contentPadding: EdgeInsets.all(20),
            ),
          ), SizedBox(
                        height: 30,
                      ),
           TextField(
            style: TextStyle(
              color: AppConstant.textColor,
              fontSize: AppConstant.txtFieldSize,
              fontWeight: FontWeight.bold,
            ),
            onChanged: (String s) {
              password = s;
            },
            readOnly: false,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock_outline_sharp,
                color: AppConstant.iconColorDark,
              ),
              hintText: "Wifi ağının Şifresi",
              hintStyle: TextStyle(
                fontSize: AppConstant.txtFieldSize,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              fillColor: AppConstant.txtfieldBColors,
              contentPadding: EdgeInsets.all(20),
            ),
          ), SizedBox(
                        height: 30,
                      ),
           GestureDetector(
                        onTap: () {
                          String mes=FirebaseAuth.instance.currentUser.email;
                          print(mes);
                          mes+="&3|";
                          mes+=ssid;
                          mes+=",";
                          mes+=password;
                          mes+=",|&";
                          _sendMessage(mes);
                          },
                        child: Container(
                          width: screenWidth,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "Kaydet",
                              style: TextStyle(
                                fontSize: AppConstant.txtSize,
                                letterSpacing: 1,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
        ]),
      ),


                      
                    ],
                  ),
                ),
              )),
    );
  }

  void _sendMessage(String text) async {
    text = text.trim();

    if (text.length > 0) {
      try {
        connection.output.add(utf8.encode(text + "\r\n"));
        await connection.output.allSent;
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }
}








