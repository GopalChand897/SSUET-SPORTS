import 'package:flutter/material.dart';
import 'package:ssuet/filtered_points_table.dart';
import 'package:ssuet/config.dart';

class Games extends StatefulWidget {
  Games({Key key}) : super(key: key);

  @override
  _GamesState createState() => _GamesState();
}

class _GamesState extends State<Games> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Games"),
        backgroundColor: Color(0xff67388c),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom:15),
              height: 140,
              child: PageView(
                children: [
                  Image.asset("assets/images/6.jpg", fit: BoxFit.cover,),
                  Image.asset("assets/images/2.jpg", fit: BoxFit.cover,),
                  Image.asset("assets/images/3.jpg", fit: BoxFit.cover,),
                  Image.asset("assets/images/4.jpg", fit: BoxFit.cover,),
                  Image.asset("assets/images/5.jpg", fit: BoxFit.cover,),
                  Image.asset("assets/images/1.jpg", fit: BoxFit.cover,),
                ],
              ),
            ),
            Container(
              color: Color(0xFF67388c),
              padding: EdgeInsets.only(bottom:5, top:5),
              child: ListTile(
                title: Text("History", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24),),
                subtitle: Text('National rankings, environmentally friendly and state-of-the-art facilities, growing reputation for excellence in teaching and affordable cost of engineering education are some of the main attractions of SSUET.', style: TextStyle(color: Colors.white, fontSize: 18),),
              ),
            ),
            ListTile(
              title: Text("Games", style: TextStyle(color: Color(0xFF67388c),fontWeight: FontWeight.bold, fontSize: 24),),
            ),
            Container(
              height: 500,

              child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 36, top:10, left:10, right:10) ,
                  itemCount: games.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      color: Color(0xFF67388c),
                      // margin: EdgeInsets.all(5),
                      // decoration: BoxDecoration(
                      //   boxShadow: [
                      //     BoxShadow(
                      //       color: Colors.purple,
                      //       offset: Offset(0.0, 1.0), //(x,y)
                      //       blurRadius: 6.0,
                      //     ),
                      //   ],
                      // ),
                      child: ListTile(
                        leading: CircleAvatar(child: Text((index+1).toString(), style: TextStyle(fontSize: 24),),),
                        title: Text('${games[index]}', style: TextStyle(color:Colors.white),),
                        trailing: IconButton(
                          onPressed: (){
                            if(gamesLiked.contains(games[index])){
                              setState(() {gamesLiked.remove(games[index]);});
                            }else{
                              setState(() {gamesLiked.add(games[index]);});
                            }
                          },
                          icon: gamesLiked.contains(games[index]) ? Icon(Icons.favorite, color: Colors.white) : Icon(Icons.favorite_outline, color: Colors.white),
                        ),
                        onTap: (){
                          setState(() {
                            filterGame = games[index];
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return FilteredPointsTable();
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}