import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expandable_card/expandable_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_card/expandable_card.dart';
import 'package:ssuet/news_details.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class NewsRecord {
  final String title;
  final String text;
  final String image;

  final DocumentReference reference;

  NewsRecord.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['title'] != null),
        assert(map['text'] != null),
        assert(map['image'] != null),
        title = map['title'],
        text = map['text'],
        image = map['image'];

  NewsRecord.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data, reference: snapshot.reference);
// @override
// String toString() => "Record<$name:$votes>";
}


class _HomePageState extends State<HomePage> {


  Widget _buildNews(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => _buildNewsItem(context, data)).toList(),
    );
  }
  Widget _buildNewsItem(BuildContext context, DocumentSnapshot data) {
    final record = NewsRecord.fromSnapshot(data);
    return _news(record, context, data);
  }
  Widget _news(record, context, data) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return NewsDetails(news: data);
            },
          ),
        );
      },
      child: Card(
        color: Color(0xFF67388c),
        elevation: 2.0,
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  height: 50,
                  width: 50,
                  child: Image.network(record.image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Expanded(
              //width: MediaQuery.of(context).size.width * 0.65,
              child: Text(
                record.title,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
            children: [
              Container(
                height: 200,
                child: PageView(
                  children: [
                    Image.asset("assets/images/1.jpg", fit: BoxFit.cover,),
                    Image.asset("assets/images/2.jpg", fit: BoxFit.cover,),
                    Image.asset("assets/images/3.jpg", fit: BoxFit.cover,),
                    Image.asset("assets/images/4.jpg", fit: BoxFit.cover,),
                    Image.asset("assets/images/5.jpg", fit: BoxFit.cover,),
                    Image.asset("assets/images/6.jpg", fit: BoxFit.cover,),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Align(
                  child: Padding(
                    child: Text("News Feed", style: TextStyle(fontSize:25,color: Color(0xFF67388c), fontWeight: FontWeight.bold),),
                    padding: EdgeInsets.only(left:10, top:10, bottom: 0.5),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height-400,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection('news').orderBy('time',descending: true).snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Center(
                        child: CircularProgressIndicator(),
                      );

                      if(snapshot.data.documents.length == 0){
                        return Center(
                          child: Text("No news to show"),
                        );
                      }else {
                        return Container(
                            child: _buildNews(context, snapshot.data.documents),
                            color: Colors.white
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          )
        )
    );
  }
}

Widget Button(var tittle) {
  return RaisedButton(
    shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0)),
    onPressed: () {},
    child: Text(
      tittle,
      style: TextStyle(
          fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
    ),
    color: Colors.redAccent,
  );
}