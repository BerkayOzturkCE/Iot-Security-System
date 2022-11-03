import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:security/page/Actions.dart';
import 'package:security/page/chat.dart';
import 'package:security/page/conn.dart';
import 'package:security/page/de.dart';
import 'package:security/util/Action.dart';
import 'package:security/util/appData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Mainmenu extends StatefulWidget {
  var _user;rrrrr
  List<getAction> liste = [];rrrrrrrrrrrrrrrr
  List<hareketler> gecerli = [];
  List<hareketler> gecersiz = [];
  bool drm = true;
  bool sayfa = true;
String mail;
  Mainmenu(this._user);

  @override
  _MainmenuState createState() => _MainmenuState();
}

class _MainmenuState extends State<Mainmenu> {
  FirebaseMessaging _firebaseMessaging;
  User user;
  TooltipBehavior _tooltipBehavior;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  

  @override
  Widget build(BuildContext context) {
    
    liste_doldur();
widget.mail=widget._user.email;
    firebase_Veri_al();
    return Scaffold(
      backgroundColor: Colors.cyan,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child:IconButton(
                              onPressed: () {
                              
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => de()));
                     
                              },
                              icon: Icon(
                                Icons.add,
                                size: 30,
                              )),
                        ),
                        Text(
                          "ANA SAYFA",
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
                                  widget.gecerli.clear();
                                  widget.gecersiz.clear();
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
                      Text(
                        "Hoşgeldiniz\n" + widget._user.displayName,
                        style: TextStyle(
                          fontSize: 40,
                          letterSpacing: 1,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Action2()));
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
                              "Hareketler",
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
                      SizedBox(
                        height: 30,
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
                          : Container(
                            decoration: BoxDecoration(color: Colors.cyan,borderRadius: BorderRadius.all(Radius.circular(15))),
                            child: SfCartesianChart(
                                

                                primaryXAxis: CategoryAxis(),
                                // Chart title
                                title: ChartTitle(
                                    text: 'Hareket İstatistikleri',
                                    textStyle: TextStyle(color: Colors.black)),
                                  




                                // Enable legend
                                legend: Legend(
                                    isVisible: true,
                                    position: LegendPosition.bottom,
                                    textStyle: TextStyle(color: Colors.black)),
                                // Enable tooltip
                                tooltipBehavior: _tooltipBehavior,palette: [Colors.orange],
                                series: <LineSeries<hareketler, String>>[
                                    LineSeries<hareketler, String>(
                                      
                                        color: Colors.green,
                                        name: "geçerli",
                                        dataSource: [
                                          widget.gecerli[4],
                                          widget.gecerli[3],
                                          widget.gecerli[2],
                                          widget.gecerli[1],
                                          widget.gecerli[0]
                                        ],
                                        xValueMapper: (hareketler hareket, _) =>
                                            hareket.tarih,
                                        yValueMapper: (hareketler hareket, _) =>
                                            hareket.sayi,
                                        // Enable data label

                                        dataLabelSettings: DataLabelSettings(
                                          isVisible: true,
                                        )),
                                    LineSeries<hareketler, String>(

                                      color: Colors.red,
                                      name: "geçersiz",
                                      dataSource: <hareketler>[
                                        widget.gecersiz[4],
                                        widget.gecersiz[3],
                                        widget.gecersiz[2],
                                        widget.gecersiz[1],
                                        widget.gecersiz[0],
                                      ],
                                      xValueMapper: (hareketler hareket, _) =>
                                          hareket.tarih,

                                      yValueMapper: (hareketler hareket, _) =>
                                          hareket.sayi,
                                      // Enable data label
                                      dataLabelSettings:
                                          DataLabelSettings(isVisible: true),
                                    )
                                  ]),
                          )
                    ],
                  ),
                ),
              )),
    );
  }

  void firebase_Veri_al() async {
        AppConstant().email=FirebaseAuth.instance.currentUser.email;
print(FirebaseAuth.instance.currentUser.email);
    if (widget.drm == true) {
      var veriler = await _firestore
          .collection("Users")
          .doc("us12")
          .collection("Actions")
          .where("tarih",
              isGreaterThanOrEqualTo:
                  DateTime.now().subtract(Duration(days: 5)))
          .orderBy("tarih", descending: true)
          .get();
      for (var veri in veriler.docs) {
        getAction data = new getAction();
        print(veri.data().toString());
        data.id = veri.id.toString();
        data.cartId = veri.get("cartId").toString();
        data.durum = veri.get("durum").toString();
        Timestamp trh = veri.get("tarih");
        data.tarih = trh.toDate();
        widget.liste.add(data);
      }
      for(int j=0;j<5;j++){
      String trh = DateTime.now().subtract(Duration(days: j)).day.toString() +
          "." +
          DateTime.now().subtract(Duration(days: j)).month.toString() +
          "." +
          DateTime.now().subtract(Duration(days: j)).year.toString();

      for (int i = 0; i < widget.liste.length; i++) {
         String trh2 = widget.liste[i].tarih.day.toString() +
          "." +
          widget.liste[i].tarih.month.toString() +
          "." +
          widget.liste[i].tarih.year.toString();

          if(trh==trh2){
        if (widget.liste[i].durum == "Gecerli") {
          widget.gecerli[j].sayi += 1;
        } else {
          widget.gecersiz[j].sayi += 1;
        }
      }
    }}
      print(widget.gecersiz[0].sayi);

      setState(() {
        widget.drm = false;
        widget.sayfa = false;
      });
    }
  }

  void liste_doldur() {
    for (int i = 0; i < 5; i++) {
      hareketler hareket1 = new hareketler();
      hareketler hareket2 = new hareketler();
      String trh = DateTime.now().subtract(Duration(days: i)).day.toString() +
          "." +
          DateTime.now().subtract(Duration(days: i)).month.toString() +
          "." +
          DateTime.now().subtract(Duration(days: i)).year.toString();
      hareket1.sayi = 0;
      hareket1.tarih = trh;
      hareket2.sayi = 0;
      hareket2.tarih = trh;
      widget.gecerli.add(hareket1);
      widget.gecersiz.add(hareket2);
    }
  }
}

class hareketler {
  String tarih;
  int sayi;
}
