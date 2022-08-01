import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ssuet/news_details_full.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
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


class _NotificationState extends State<NotificationPage> {


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
    return ListTile(
      leading: Icon(Icons.notifications),
      title: Text(record.title),
      subtitle: Text(record.text),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return NewsDetailsFull(news: data,);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        backgroundColor: Color(0xff67388c),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('news').orderBy('time',descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(
            child: CircularProgressIndicator(),
          );
          return _buildNews(context, snapshot.data.documents);
        },
      ),
    );
  }

}
