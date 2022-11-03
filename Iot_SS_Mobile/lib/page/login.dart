import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:security/page/mainmenu.dart';
import 'package:security/page/signup.dart';
import 'package:security/util/appData.dart';
import 'package:security/widget/warn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  double width = 200.0;
  double widthIcon = 200.0;
  String mail = "";
  String password = "";
  bool obscuretxt = true;
  bool mailFocus = false;
  bool passwordFocus = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    mailFocus = false;
    passwordFocus = false;
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
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColorLight
                    ])),
                child: Login(),
              )),
    );
  }

  Widget Login() {
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
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(top: 60, bottom: 20, right: 30, left: 30),
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
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "GİRİŞ YAPINIZ",
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
                        autofocus: mailFocus,
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
                            Icons.mail_outline,
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
                        autofocus: passwordFocus,
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
                          MailGiris();
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
                              "Giriş",
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
                        height: 20,
                      ),
                      Text(
                        "YADA",
                        style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 1,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.cyan,
                                borderRadius: BorderRadius.circular(45)),
                            child: IconButton(
                              onPressed: () {
                                GoogleGiris();
                              },
                              icon: Image.asset(
                                AppConstant.google,
                              ),
                              iconSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 800),
                                child: SignUpPage()))
                        .then((value) {
                      Future.delayed(Duration(milliseconds: 300), () {
                        setState(() {
                          width = 200;
                          widthIcon = 200;
                        });
                      });
                    });
                    setState(() {
                      width = 500.0;
                      widthIcon = 0;
                    });
                  },
                  child: AnimatedContainer(
                    height: 65.0,
                    width: width,
                    duration: Duration(milliseconds: 1000),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
//                          margin: EdgeInsets.only(right: 8,top: 15),
                                child: Text(
                                  "Hesabınız Yok mu ?",
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
//                          margin: EdgeInsets.only(right: 8,top: 15),
                                child: Text(
                                  "Kayıt Olun",
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
                      ],
                    ),
                    curve: Curves.linear,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                      color: Colors.cyan,
                    ),
                  ),
                ),
              ],
            )));
  }

  void MailGiris() async {
    try {
      if (mail != "" && password != "") {
        UserCredential _credential = await _auth.signInWithEmailAndPassword(
            email: mail, password: password);
        User _user = _credential.user;
        Navigator.push(context,
                MaterialPageRoute(builder: (context) => Mainmenu(_user)))
            .then((value) =>  Navigator.pop(context));
      } else {
        showResultDialog("Lütfen boş alanları doldurun.", "Başarısız", context);
      }
    } catch (e) {
      showResultDialog(e.toString(), "Hata", context);
    }
  }

  void GoogleGiris() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Mainmenu(googleUser))).then((value) => Navigator.pop(context));
    } catch (e) {
      showResultDialog(e.toString(), "Hata", context);
    }
  }
}
