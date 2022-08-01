import 'package:flutter/material.dart';
import 'package:ssuet/Screens/Login/login_screen.dart';
import 'package:ssuet/Screens/Signup/components/background.dart';
import 'package:ssuet/components/already_have_an_account_acheck.dart';
import 'package:ssuet/components/rounded_button.dart';
import 'package:ssuet/components/rounded_input_field.dart';
import 'package:ssuet/components/rounded_password_field.dart';
import 'package:ssuet/components/text_field_container.dart';
import 'package:ssuet/constants.dart';
import 'package:ssuet/dashboard.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  bool _loading = false;
  String name = "";
  String email = "";
  String password = "";

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


  void _register(name,email,password,_dept,_batch,_roll) async {
    try {
      email = "${email}@ssuet.edu.pk";

      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((response) async{


        try {
          await response.user.sendEmailVerification();
        } catch (e) {
          print("An error occurred while trying to send email verification");
          print(e.message);
        }

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('name',name);
        prefs.setString('email',email);
        prefs.setString('dept',_dept);
        prefs.setString('batch',_batch);
        prefs.setString('roll',_roll);

        Firestore.instance.collection("users").add({
          'uid': response.user.uid,
          'name': name,
          'email': email,
          'password': password,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        });
        setState(() {
          _loading = false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Dashboard();
            },
          ),
        );
      });
    }catch (err) {
      print(err);
      _showDialog("Invalid email address or email is already taken!");
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {




    // Future<bool> userExist(String email) async {
    //   bool exists = false;
    //   try {
    //     await Firestore.instance.collection('users').document(email).get().then((doc) {
    //       if (doc.exists)
    //         exists = true;
    //       else
    //         exists = false;
    //     });
    //     return exists;
    //   } catch (e) {
    //     return false;
    //   }
    // }

    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50,),
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36,
              color: Color(0xFF67388c),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your Name",
              onChanged: (value) {
                name = value;
              },
            ),
            TextFieldContainer(
              child: TextField(
                onChanged: (value) {
                  email = value;
                },
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  hintText: "Your Email",
                  border: InputBorder.none,
                  suffix: Text("@ssuet.edu.pk"),
                ),
              ),
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),
            _loading ? CircularProgressIndicator() : RoundedButton(
              text: "SIGNUP",
              press: () async{
                if(name.length > 0){
                  if(email.length >= 8){

                    if(email.toUpperCase().contains("BS")){
                      var _dept   = email.substring(2,4).toUpperCase();
                      var _batch  = email.substring(4,6).toUpperCase();
                      var _roll   = email.substring(7,email.length).toUpperCase();
                      if(password.length >= 8) {
                        setState(() {
                          _loading = true;
                        });
                        _register(name,email,password,_dept,_batch,_roll);
                      }else{
                        _showDialog("Password must be at least 8 characters");
                      }
                    }else{
                      _showDialog("Invalid email address");
                    }
                  }else{
                    _showDialog("Email must contains at least 8 characters");
                  }
                }else{
                  _showDialog("Please enter your name");
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}
