import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssuet/components/text_field_container.dart';
import 'package:ssuet/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Registration extends StatefulWidget {
  Registration({Key key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String name,email,phone,dept,batch,roll,sports,gender;

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
        backgroundColor: Color(0xff67388c),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[

            dept == null ? Center(child: CircularProgressIndicator(),) : StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('reg_lock').where('dept',isEqualTo: departments[deptCode.indexOf(dept)]).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(
                  child: CircularProgressIndicator(),
                );


                if(snapshot.data.documents[0]['lock']){
                  return Center(
                      child: Text("Registration is closed for ${departments[deptCode.indexOf(dept)]}!", style: TextStyle(fontSize: 24, color: Colors.red),textAlign: TextAlign.center,),
                  );

                }else{
                  return SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height-100,
                      child: ListView(
                        children: [
                          ListTile(
                            title: Text("Name:",style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF67388c))),
                            subtitle: Text(name ?? ''),
                          ),
                          ListTile(
                            title: Text("Email:",style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF67388c))),
                            subtitle: Text(email ?? ''),
                          ),

                          ListTile(
                            title: Text("Roll Number:",style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF67388c))),
                            subtitle: Text(roll ?? ''),
                          ),
                          ListTile(
                            title: Text("Department:",style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF67388c))),
                            subtitle: Text(dept ?? ''),
                          ),
                          ListTile(
                            title: Text("Batch:",style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF67388c))),
                            subtitle: Text(batch ?? ''),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("Phone:",style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF67388c))),
                            subtitle: TextField(
                              decoration: InputDecoration(
                                isDense: true,

                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (String _phone){
                                phone = _phone;
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("Sports:",style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF67388c))),
                            subtitle: DropdownButton<String>(
                              isExpanded: true,
                              hint: Text("Select Sports"),
                              value: sports,
                              items: games.map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                  onTap: (){
                                    print(value);
                                    setState(() {
                                      sports = value;
                                    });
                                  },
                                );
                              }).toList(),
                              onChanged: (_) {
                                setState(() {
                                  sports = _;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("Gender:",style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF67388c))),
                            subtitle: DropdownButton<String>(
                              isExpanded: true,
                              hint: Text("Select Gender"),
                              value: gender,
                              items: ['Male','Female'].map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                  onTap: (){
                                    print(value);
                                    setState(() {
                                      gender = value;
                                    });
                                  },
                                );
                              }).toList(),
                              onChanged: (_) {
                                setState(() {
                                  gender = _;
                                });
                              },
                            ),
                          ),
                          SizedBox(height:25),
                          Center(
                            child: RaisedButton(
                              padding: EdgeInsets.all(15),
                              color: Color(0xFF67388c),
                              child: Text("Register", style: TextStyle(color: Colors.white),),
                              onPressed: (){
                                Firestore.instance.collection('registration').add({
                                  'name': name,
                                  'email': email,
                                  'phone': phone,
                                  'roll': roll,
                                  'dept': dept,
                                  'batch': batch,
                                  'fcm': fcm,
                                  'sports': sports,
                                  'gender': gender,
                                  'timestamp': DateTime.now().millisecondsSinceEpoch,
                                });

                                if(sports == null || phone == null || gender == null){
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      // return object of type Dialog
                                      return AlertDialog(
                                        title: new Text("Phone, Sports and Gender are required!"),
                                        // content: new Text("Alert Dialog body"),
                                        actions: <Widget>[
                                          // usually buttons at the bottom of the dialog
                                          new FlatButton(
                                            child: new Text("Okay"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }else{
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext _context) {
                                      // return object of type Dialog
                                      return AlertDialog(
                                        title: new Text("Successfully Registered"),
                                        // content: new Text("Alert Dialog body"),
                                        actions: <Widget>[
                                          // usually buttons at the bottom of the dialog
                                          new FlatButton(
                                            child: new Text("Okay"),
                                            onPressed: () {
                                              Navigator.of(_context).pop();
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }


                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              },
            ),


        ],
      ),
      ),
    );
  }

}
