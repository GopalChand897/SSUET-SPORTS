import 'package:flutter/material.dart';
import 'package:ssuet/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class NewsDetailsFull extends StatefulWidget {
  final DocumentSnapshot news;
  NewsDetailsFull({Key key, this.news}) : super(key: key);
  @override
  _NewsDetailsFullState createState() => _NewsDetailsFullState();
}

class _NewsDetailsFullState extends State<NewsDetailsFull> {

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    try {
      Navigator.pop(context);
    }catch(e){

    }
    return true;
  }

  @override
  void initState() {
    BackButtonInterceptor.add(myInterceptor);
    super.initState();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        backgroundColor: Color(0xff67388c),
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
          children: <Widget>[
            Image.network(widget.news.data['image']),
            Divider(),
            Text(widget.news.data['title'], style: TextStyle(fontSize:24, fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Text(widget.news.data['text'], style: TextStyle(fontSize:18),),
            SizedBox(height:50),
            Divider(),
            RaisedButton(
              child: Text("Back to all news"),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ],
        )
    );
  }
}