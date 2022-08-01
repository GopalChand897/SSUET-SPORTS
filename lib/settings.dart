import 'package:flutter/material.dart';
import 'package:ssuet/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  bool noti1 = false;
  bool noti2 = false;
  bool noti3 = false;

  _getSharedPref() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();  //SharedPreferences is used for storing data key-value pair in the Android 
    setState(() {
      noti1   = prefs.getBool('noti1') ?? false;
      noti2   = prefs.getBool('noti2') ?? false;
      noti3   = prefs.getBool('noti3') ?? false;

      print(noti1);
      print(noti2);
      print(noti3);
    });
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
          backgroundColor: Color(0xff67388c),
        title: Text("Settings")
      ),
      body: ListView(
          children: <Widget>[

            ListTile(
              leading: Padding(child: Icon(Icons.notifications, color: Color(0xFF67388c)), padding: new EdgeInsets.all(8.0),),
              subtitle: Text("Get Department Notification"),
              title: Text("Department Notifications"),
              trailing: noti1 ? Icon(Icons.check_box, color: Color(0xFF67388c)) : Icon(Icons.check_box_outline_blank),
              onTap: () async{
                setState(() {
                  noti1 = !noti1;
                });
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('noti1',noti1);
              },
            ),
            Divider(),
            ListTile(
              leading: Padding(child: Icon(Icons.notifications, color: Color(0xFF67388c)), padding: new EdgeInsets.all(8.0),),
              subtitle: Text("Get Games Notification"),
              title: Text("Games Notifications"),
                trailing: noti2 ? Icon(Icons.check_box, color: Color(0xFF67388c),) : Icon(Icons.check_box_outline_blank),
              onTap: () async{
                setState(() {
                  noti2 = !noti2;
                });
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('noti2',noti2);
              },
            ),
            Divider(),
            ListTile(
              leading: Padding(child: Icon(Icons.notifications, color: Color(0xFF67388c)), padding: new EdgeInsets.all(8.0),),
              subtitle: Text("Get SSUET News Notification"),
              title: Text("News Notifications"),
                trailing: noti3 ? Icon(Icons.check_box, color: Color(0xFF67388c)) : Icon(Icons.check_box_outline_blank),
              onTap: () async{
                setState(() {
                  noti3 = !noti3;
                });
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('noti3',noti3);
              },
            ),

          ],
        )
    );
  }
}