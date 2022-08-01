import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssuet/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String name = '';
  String email = '';
  String dept = '';
  String batch = '';
  String roll = '';

  String bio = 'Something about you..';

  _getSharedPref() async{
    Future<FirebaseUser> user = FirebaseAuth.instance.currentUser();
    user.then((value){

      Firestore.instance.collection('users').where('uid',isEqualTo: value.uid).limit(1).getDocuments().then((firestoreData){
        setState(() {
          name = firestoreData.documents[0].data['name'];
          email = firestoreData.documents[0].data['email'];
          dept   = email.substring(2,4).toUpperCase();
          batch  = email.substring(4,6).toUpperCase();
          roll   = email.substring(7,email.indexOf("@")).toUpperCase();
        });
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

  @override
  void initState() {
    _getSharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final inputName = TextEditingController();
    final inputBio = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color(0xff67388c),
      ),
      body: SingleChildScrollView(
        child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter, 
                colors: [Color(0xFF67388c), Color(0xFF67388c)],
               // colors: [Color(0xFF67388c), Color(0xFF67388c)]
              )
            ),
            child: Container(
              width: double.infinity,
              height: 250.0,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // CircleAvatar(
                    //   backgroundImage: NetworkImage(
                    //     "https://s3.amazonaws.com/37assets/svn/765-default-avatar.png",
                    //   ),
                    //   radius: 50.0,
                    // ),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    GestureDetector(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              title: new Text("Edit Name"),
                              content: TextField(
                                // initialValue: name,
                                autofocus: true,
                                decoration: InputDecoration(
                                  hintText: "Enter Your Name",                                  
                                ),
                                controller: inputName,
                              ),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                new FlatButton(
                                  child: new Text("Save"),
                                  onPressed: () async{
                                    setState(() {
                                      name = inputName.text.toString();
                                    });
                                    SharedPreferences prefs
                                    = await SharedPreferences.getInstance();
                                    prefs.setString('name',name);


                                    Future<FirebaseUser> user = FirebaseAuth.instance.currentUser(); //Long-running tasks are common in mobile apps. The way this is handled in Flutter / Dart is by using a Future
                                    user.then((value){

                                      Firestore.instance.collection('users').where('uid',isEqualTo: value.uid).limit(1).getDocuments().then((firestoreData){
                                        setState(() {
                                          String documentID = firestoreData.documents[0].documentID;
                                          Firestore.instance.collection('users').document(documentID).updateData({
                                            'name': name,
                                          });
                                        });
                                      });
                                    });




                                    Navigator.of(context).pop();
                                  },
                                ),
                                
                              ],
                            );
                          },
                        );

                      },
                      child: Column(
                        children: [
                          Text(
                            name ?? '',
                            style: TextStyle(
                              fontSize: 36.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Tap to update",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      )
                    ),
                    SizedBox(height: 15),
                    Text(
                      email ?? '',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.white,
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 22.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(

                                children: <Widget>[
                                  Text(
                                    "Dept.",
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    dept ?? '',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.pinkAccent,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(

                                children: <Widget>[
                                  Text(
                                    "Batch",
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    batch ?? '',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.pinkAccent,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(

                                children: <Widget>[
                                  Text(
                                    "Roll",
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    roll ?? '',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.pinkAccent,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      "Bio:",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontStyle: FontStyle.normal,
                      fontSize: 28.0
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                  GestureDetector(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              title: new Text("Edit Bio"),
                              content: TextField(
                                // initialValue: name,
                                autofocus: true,
                                decoration: InputDecoration(
                                  hintText: "Write something about you",                                  
                                ),
                                controller: inputBio,
                              ),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                new FlatButton(
                                  child: new Text("Save"),
                                  onPressed: () async{
                                    setState(() {
                                      bio = inputBio.text.toString();
                                    });
                                    SharedPreferences prefs
                                    = await SharedPreferences.getInstance();
                                    prefs.setString('bio',bio);

                                    Navigator.of(context).pop();
                                  },
                                ),
                                
                              ],
                            );
                          },
                        );
                    },
                    child: Text(bio,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
          ),          
        ],
      ),
      ),
    );
  }

}
