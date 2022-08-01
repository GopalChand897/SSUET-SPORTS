import 'package:flutter/material.dart';
import 'package:ssuet/config.dart';
import 'package:ssuet/games.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Departments extends StatefulWidget {
  Departments({Key key}) : super(key: key);
  @override
  _DepartmentsState createState() => _DepartmentsState();
}

class _DepartmentsState extends State<Departments> {
  
  _getSharefPref() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // setState(() {
    //   deptLiked = prefs.getString('deptLiked').split(",");
    // });
    // print(deptLiked);
    print(prefs.getString('deptLiked'));
  }

  @override
  void initState() {
    _getSharefPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Departments"),
      // ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          padding: EdgeInsets.only(bottom: 36, top:10, left:10, right:10) ,
          itemCount: departments.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Color(0xFF67388c),
                //gradient: Icons.gradient(colors: [Colors.purpleAccent, Colors.purple])
              ),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF67388c),
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: ListTile(

                  leading: CircleAvatar(child: Text((index+1).toString(), style: TextStyle(fontSize: 24),),),
                  title: Text('${departments[index]}', style: TextStyle(color:Colors.white),),
                  trailing: IconButton(
                    onPressed: () async{
                      if(deptLiked.contains(departments[index])){
                        setState(() {deptLiked.remove(departments[index]);});
                      }else{
                        setState(() {deptLiked.add(departments[index]);});
                      }

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString('deptLiked',deptLiked.toString());
                    },
                    icon: deptLiked.contains(departments[index]) ? Icon(Icons.favorite, color: Colors.white) : Icon(Icons.favorite_outline, color: Colors.white),
                  ),
                  onTap: (){
                    setState(() {
                      filterDept = departments[index];
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Games();
                        },
                      ),
                    );
                  },
                ),
              )
            );
          }
      ),
    );
  }
}