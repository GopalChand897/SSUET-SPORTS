import 'package:flutter/material.dart';
import 'package:ssuet/Screens/Login/components/background.dart';
import 'package:ssuet/Screens/Signup/signup_screen.dart';
import 'package:ssuet/components/already_have_an_account_acheck.dart';
import 'package:ssuet/components/rounded_button.dart';
import 'package:ssuet/components/rounded_input_field.dart';
import 'package:ssuet/components/rounded_password_field.dart';
import 'package:ssuet/dashboard.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _loading = false;

  String email = "";
  String password = "";

  void _login(email,password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).then((response) {
        print(response.user);
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
      _showDialog("Invalid email or password!");
      setState(() {
        _loading = false;
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

  final inputEmail = TextEditingController();

  @override
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50,),
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36,
              color: Color(0xFF67388c),
             // color: Colors.purple[800]
              ),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),
            _loading ? CircularProgressIndicator() : RoundedButton(
              text: "LOGIN",
              press: () {
                if(email.length > 0){
                  if(password.length > 0){
                    setState(() {
                      _loading = true;
                    });
                    _login(email, password);
                  }else{
                    _showDialog("Please enter your password");
                  }
                }else{
                  _showDialog("Please enter your email");
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 10,),
            GestureDetector(
              child: Text("Forgot Password ?"),
              onTap: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("Forgot Password ?"),
                      content: TextField(
                        // initialValue: name,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: "Enter Your Name",
                        ),
                        controller: inputEmail,
                      ),
                      actions: <Widget>[

                        new FlatButton(
                          child: new Text("Done"),
                          onPressed: () async{
                            print(inputEmail.text);
                            resetPassword(inputEmail.text);
                                //.then((value) => _showDialog("Email Sent!"));
                            Navigator.of(context).pop();
                          },
                        ),

                      ],
                    );
                  },
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