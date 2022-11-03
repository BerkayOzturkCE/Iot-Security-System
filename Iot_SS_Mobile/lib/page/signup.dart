import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:page_transition/page_transition.dart';
import 'package:security/page/signup.dart';
import 'package:security/util/appData.dart';
import 'package:security/widget/warn.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUpPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  double width = 400.0;
  double widthIcon = 200.0;
  String name = "";
  String mail = "";
  String password = "";
  Icon _icon = Icon(Icons.visibility_off);

  PageController _pageController;

  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        width = 190.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Page();
  }

  Widget Page() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: new Builder(
          builder: (context) => new Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColorLight
                    ])),
                child: Signup(),
              )),
    );
  }

  Widget Signup() {
    bool oku = false;
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(bottom: 40),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColorLight
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(top: 60, bottom: 40, right: 30, left: 30),
              child: Column(
                children: [
                  Text(
                    "HOŞGELDİNİZ",
                    style: TextStyle(
                      fontSize: 40,
                      letterSpacing: 1,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "KAYIT OL",
                    style: TextStyle(
                      fontSize: 40,
                      letterSpacing: 1,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextField(
                    style: TextStyle(
                      color: AppConstant.textColor,
                      fontSize: AppConstant.txtFieldSize,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (String s) {
                      name = s;
                    },
                    readOnly: oku,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: AppConstant.iconColorDark,
                      ),
                      hintText: "İsim",
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
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    style: TextStyle(
                      color: AppConstant.textColor,
                      fontSize: AppConstant.txtFieldSize,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (String s) {
                      mail = s;
                    },
                    readOnly: oku,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail_outline_outlined,
                        color: AppConstant.iconColorDark,
                      ),
                      hintText: "E-Mail",
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
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    obscureText: true,
                    style: TextStyle(
                      color: AppConstant.textColor,
                      fontSize: AppConstant.txtFieldSize,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (String s) {
                      password = s;
                    },
                    readOnly: oku,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outline_sharp,
                        color: AppConstant.iconColorDark,
                      ),
                      /*suffixIcon:
                          IconButton(onPressed: () {}, icon: Icon(Icons.visibility_off),padding: EdgeInsets.all(),),*/
                      hintText: "Şifre",
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
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      Kaydol();
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
                          "Kayıt Ol",
                          style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 1,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRight,
                      duration: Duration(milliseconds: 800),
                      child: null,
                    ));
                setState(() {
                  width = 500;
                  widthIcon = 0;
                });
              },
              child: AnimatedContainer(
                height: 65.0,
                width: width,
                duration: Duration(milliseconds: 1000),
                curve: Curves.linear,
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Hesabınız Var mı ?",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 1,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            child: Text(
                              "Giriş Yapın",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 1,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.cyan,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void Kaydol() async {
    try {
      if (name != "" || mail != "" && password != "") {
        UserCredential _credential = await _auth.createUserWithEmailAndPassword(
            email: mail, password: password);
        User _newUser = _credential.user;
        _newUser.updateProfile(displayName: name);
      

        if (!_newUser.emailVerified) {
          await _newUser.sendEmailVerification();
        }
        showResultDialog("Kayıt İşlemi Başarılı.", "Başarılı", context);
        Navigator.pop(context);

        print(_newUser.toString());
      } else {
        showResultDialog("Lütfen boş alanları doldurun.", "Başarısız", context);
      }
    } catch (e) {
      showResultDialog(e.toString(), "Hata", context);
    }
  }
}
