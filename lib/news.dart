import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expandable_card/expandable_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_card/expandable_card.dart';
import 'package:ssuet/news_details.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}


class NewsRecord { //model of news
  final String title;
  final String text;
  final String image;

  final DocumentReference reference;

  NewsRecord.fromMap(Map<String, dynamic> map, {this.reference})  //fromMap we retrieve data and save it in local variable
      : assert(map['title'] != null),
        assert(map['text'] != null),
        assert(map['image'] != null),
        title = map['title'],
        text = map['text'],
        image = map['image'];

  NewsRecord.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data, reference: snapshot.reference);  //snapshot simplifies accessing and converting properties in a JSON like oobject
// @override
// String toString() => "Record<$name:$votes>";
}


class _NewsPageState extends State<NewsPage> {


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
        elevation: 2.0,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
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
        appBar: AppBar(
          title: Text("News"),
          backgroundColor: Color(0xFF67388c),
        ),
        body: Container(
          color: Colors.white54,
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('news').orderBy('time',descending: true).snapshots(), //fetching, the latest one comes on top
             
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(
                  child: CircularProgressIndicator(),    //if loading loading icon
                );
                return _buildNews(context, snapshot.data.documents);  //if loaded then display
              },
            ),
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