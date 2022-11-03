import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:security/util/Action.dart';

class Action2 extends StatefulWidget {
  List <getAction>liste = [];
  bool drm = true;
  bool sayfa = true;
  _Action2State createState() => _Action2State();
}

class _Action2State extends State<Action2> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DatabaseReference itemRefShop;
  getAction veriler;
  @override
  Widget build(BuildContext context) {
    firebase_Veri_al();
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.red,
      ),*/
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
                  padding: EdgeInsets.only(left: 10, right: 10, top: 40),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.keyboard_backspace,
                                size: 30,
                              )),
                        ),
                        Text(
                          "KART HAREKETLERİ",
                          style: TextStyle(
                            fontSize: 25,
                            letterSpacing: 1,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.liste.clear();
                                  widget.drm=true;
                                  widget.sayfa=true;
                                });
                              },
                              icon: Icon(
                                Icons.replay,
                                size: 30,
                              )),
                        ),
                      ],
                    ),
                    widget.sayfa == true
                        ? Container(
                            padding:
                                EdgeInsets.only(top: 30, left: 24, right: 24),
                            child: Column(children: [
                              SizedBox(
                                height: 80,
                              ),
                              CircularProgressIndicator(
                                backgroundColor: Colors.grey,

                              ),
                            ]),
                          )
                        : Expanded(
                            child: GridView.count(
                              physics: BouncingScrollPhysics(),
                              crossAxisCount: 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1 / 0.6,
                              children: widget.liste
                                  .map((veri) => actionList(veri))
                                  .toList(),
                            ),
                          ),
                  ]),
                ),
              )),
    );
  }

  Widget actionList(getAction action) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hareket Numarası\n" + action.id,
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 1,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kart Id: " + action.cartId,
              style: TextStyle(
                fontSize: 14,
                letterSpacing: 1,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.start,
            ),
            Text(
              "Durum: " + action.durum,
              style: TextStyle(
                fontSize: 14,
                letterSpacing: 1,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "Hareket Tarihi: " +
                  action.tarih.day.toString() +
                  "." +
                  action.tarih.month.toString() +
                  "." +
                  action.tarih.year.toString(),
              style: TextStyle(
                fontSize: 14,
                letterSpacing: 1,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "Hareket Tarihi: " +
                  action.tarih.hour.toString() +
                  "." +
                  action.tarih.toUtc().minute.toString(),
              style: TextStyle(
                fontSize: 14,
                letterSpacing: 1,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ]),
    );
  }
  void firebase_Veri_al() async {
    var veriler = await _firestore
        .collection("Users")
        .doc("us12")
        .collection("Actions")
        .orderBy("tarih", descending: true)
        .get();
    for (var veri in veriler.docs) {
      getAction data = new getAction();
      print(veri.data().toString());
      data.id = veri.id.toString();
      data.cartId = veri.get("cartId").toString();
      data.durum = veri.get("durum").toString();
      Timestamp trh = veri.get("tarih");
      data.tarih=trh.toDate();
      widget.liste.add(data);
    }

     if (widget.drm == true) {
      setState(() {
        widget.drm = false;
        widget.sayfa = false;
      });
    }
  }
  
}
