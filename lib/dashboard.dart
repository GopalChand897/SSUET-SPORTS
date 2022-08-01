import 'dart:io';

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:ssuet/home.dart';
import 'package:ssuet/points_table.dart';
import 'package:ssuet/departments.dart';
import 'package:ssuet/Screens/Welcome/welcome_screen.dart';
import 'package:ssuet/about.dart';
import 'package:ssuet/profile.dart';
import 'package:ssuet/settings.dart';
import 'package:ssuet/config.dart';
import 'package:ssuet/notification.dart';
import 'package:ssuet/registration.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:vibration/vibration.dart';
import 'package:badges/badges.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        brightness: Brightness.light
      ),
      debugShowCheckedModeBanner: false,
      home: MyDashboard(),
    );
  }
}

class MyDashboard extends StatefulWidget {
  @override
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {

  String name = '';//
  String email = '';//
  String dept = '';//
  String batch = '';//
  String roll = '';//
  bool isEmailVerified = false;//
  double hoursSpend = 0.0;


  _getSharedPref() async{
    Future<FirebaseUser> user = FirebaseAuth.instance.currentUser();
    user.then((value){
      setState(() {
        isEmailVerified = value.isEmailVerified;
        email = value.email;
      });
      Firestore.instance.collection('users').where('uid',isEqualTo: value.uid).limit(1).getDocuments().then((firestoreData){
        setState(() {
          name = firestoreData.documents[0].data['name'];
          email = firestoreData.documents[0].data['email'];
          dept   = email.substring(2,4).toUpperCase();
          batch  = email.substring(4,6).toUpperCase();
          roll   = email.substring(7,email.length).toUpperCase();
          int timeNow = DateTime.now().millisecondsSinceEpoch ?? 0;
          int timeSignup = firestoreData.documents[0].data['timestamp'] ?? 0;
          hoursSpend = (timeNow-timeSignup)/1000/60/60 ?? 0.0;
        });

        if(isEmailVerified == false && hoursSpend > 24){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: new Text("Email is not verified!"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      exit(0);
                    },
                  ),
                ],
              );
            },
          );
        }






      });
    });

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // setState(() {
      // name  = prefs.getString('name') ?? '';
      // email = prefs.getString('email') ?? '';
      // dept  = prefs.getString('dept') ?? '';
      // batch = prefs.getString('batch') ?? '';
      // roll  = prefs.getString('roll') ?? '';

    //   print(name);
    //   print(email);
    //   print(dept);
    //   print(batch);
    //   print(roll);
    //
    // });
  }


  int currentPage = 0;

  GlobalKey bottomNavigationKey = GlobalKey();

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    print(info.currentRoute(context).settings.name);

    try {
      if(info.currentRoute(context).settings.name == "/"){

      }else{
        Navigator.pop(context);
      }
    }catch(e){

    }
    return true;
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  void _getMessage() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    if(user != null){
      //await Firestore.instance.collection('users').document(user.uid).get().then((doc) async {
        //print("B");
        //if (doc.exists){
          print("c");


          _firebaseMessaging.requestNotificationPermissions();
          _firebaseMessaging.configure();
          String token = await _firebaseMessaging.getToken();
          Firestore.instance.collection('users').where('uid',isEqualTo: user.uid).getDocuments().then((value){
              String docId = value.documents.first.documentID;

              Firestore.instance.collection('users').document(docId).updateData({ 'fcm': token });

              Firestore.instance.collection('users').document(docId).get().then((value){
                setState(() {
                  fcm = token;
                });
              });
          });
          _firebaseMessaging.configure(
            onMessage: (Map<String, dynamic> message) async {
              _showDialog(message["notification"]["body"]);
              Vibration.vibrate();
              FlutterRingtonePlayer.playNotification();
              int intTotalNoti = int.parse(totalNoti);
              intTotalNoti = intTotalNoti + 1;
              setState(() {
                totalNoti = intTotalNoti.toString();
              });
            },
            onLaunch: (Map<String, dynamic> message) async {
            },
            onResume: (Map<String, dynamic> message) async {
            },);
        // }else{
        //   Timer(Duration(seconds: 5), (){
        //     _getMessage();
        //   });
        // }
      //});
    }else{
      Timer(Duration(seconds: 5), (){
        _getMessage();
      });
    }
  }

  void _showDialog(msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(msg),
          // content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String totalNoti = "0";
  _getNewsTotal(){
    Firestore.instance.collection('news').getDocuments().then((value){
      setState(() {
        totalNoti = value.documents.length.toString();
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _getNewsTotal();
    _getMessage();
    _getSharedPref();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('Welcome, $name!', style: TextStyle(fontSize: 24)),
              accountEmail: new Text(email, style: TextStyle(fontSize: 18)),
              decoration: new BoxDecoration(
                color: Color(0xFF67388c),
              )
            ),
            new ListTile(
              title: new Text("Profile"),
              trailing: new Icon(Icons.person),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Profile();
                    },
                  ),
                );
              },
            ),
            new ListTile(
              title: new Text("Settings"),
              trailing: new Icon(Icons.settings),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Settings();
                    },
                  ),
                );
              },
            ),
            new Divider(),
            new ListTile(
              title: new Text("Registration"),
              trailing: new Icon(Icons.format_align_center),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Registration();
                    },
                  ),
                );
              },
            ),
            new ListTile(
              title: new Text("About Us"),
              trailing: new Icon(Icons.info),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MyAboutPage();
                    },
                  ),
                );
              },              
            ),
            new Divider(),
            new ListTile(
              title: new Text("Logout"),
              trailing: new Icon(Icons.arrow_back),
              onTap: () async{
                await FirebaseAuth.instance.signOut().then((value){
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return WelcomeScreen();
                      },
                    ),
                  );
                });
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(

        title: Text(currentPage == 0 ? "SSUET Sports" : currentPage == 1 ? "Feeds" : currentPage == 2 ? "Departments" : "Profile"),
        backgroundColor: Color(0xff67388c),
        actions: [
          IconButton(
            icon: isEmailVerified ? Icon(Icons.mark_email_read) : Icon(Icons.warning),
            onPressed: (){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text(isEmailVerified ? "Email is verified!": "Email is not verified!"),
                    content: new Text("Please verify your email within ${24-hoursSpend.ceil()} hours!"),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text("Close"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          IconButton(
            icon: Badge(
              badgeContent: Text(totalNoti.toString(), style: TextStyle(color: Colors.white),),
              showBadge: true,
              child:  Icon(Icons.notifications),
            ),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return NotificationPage();
                  },
                ),
              );
            },
          ),


        ],
      ),

      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: _getPage(currentPage),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        inactiveIconColor: Colors.grey,
        activeIconColor: Color(0xFF67388c),
        circleColor: Colors.white,
        textColor: Color(0xFF67388c),
        tabs: [
          TabData(iconData: Icons.home,title: "Home",),
          TabData(iconData: Icons.whatshot,title: "Games",),
          TabData(iconData: Icons.spa, title: "Departments"),
        ],
        initialSelection: 0,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return HomePage();
      case 1:
        return PointsTable();
      case 2:
        return Departments();
      default:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("This is the blank page"),
          ],
        );
    }
  }
}
