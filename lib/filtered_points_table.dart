import 'package:flutter/material.dart';
import 'package:expandable_card/expandable_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ssuet/config.dart';

class FilteredPointsTable extends StatefulWidget {
  FilteredPointsTable({Key key}) : super(key: key);
  @override
  _FilteredPointsTableState createState() => _FilteredPointsTableState();
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
Widget _buildNews(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _buildNewsItem(context, data)).toList(),
  );
}
Widget _buildNewsItem(BuildContext context, DocumentSnapshot data) {
  final record = NewsRecord.fromSnapshot(data);
  return _news(record, context);
}
Widget _news(record, context) {
  return GestureDetector(
    onTap: (){
      showModalBottomSheet<void>(
          isScrollControlled:true,
          context: context,
          builder: (BuildContext context){
            return new Container(
              padding: new EdgeInsets.all(15.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/images/news.png"),
                  SizedBox(height: 15,),
                  Text(record.title, style: TextStyle(fontSize:36, fontWeight: FontWeight.bold),),
                  SizedBox(height: 15,),
                  Text(record.text),
                ],
              ),
            );
          }
      );
    },
    child: Card(
      elevation: 2.0,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width * 0.25,
                child: Image.asset(
                  "assets/images/news.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.50,
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

class Score {
  final String team1;
  final String team2;
  final String team1_score;
  final String team2_score;
  final String seperator;
  final String title;
  final String sub_title;

  final DocumentReference reference;

  Score.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['team1'] != null),
        assert(map['team2'] != null),
        assert(map['team1_score'] != null),
        assert(map['team2_score'] != null),
        assert(map['seperator'] != null),
        assert(map['title'] != null),
        assert(map['sub_title'] != null),
        team1 = map['team1'],
        team2 = map['team2'],
        team1_score = map['team1_score'],
        team2_score = map['team2_score'],
        seperator = map['seperator'],
        title = map['title'],
        sub_title = map['sub_title'];

  Score.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data, reference: snapshot.reference);
// @override
// String toString() => "Record<$name:$votes>";
}
Widget _buildFixture(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _buildFixtureItem(context, data)).toList(),
  );
}
Widget _buildFixtureItem(BuildContext context, DocumentSnapshot data) {
  final record = Score.fromSnapshot(data);
  return score(record, context);
}
Widget score(record, context) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    //color: Color(0xffe0ffed),
    elevation: 2.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            record.team1,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  record.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      record.team1_score,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    SizedBox(width: 8,),
                    Container(
                      width: 50,
                      height: 20,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () {},
                        child: Text(record.seperator),
                        textColor: Colors.white,
                        color: Colors.greenAccent,
                      ),
                    ),
                    SizedBox(width: 8,),
                    Text(
                      record.team2_score,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Text(record.sub_title,style: TextStyle(color: Colors.grey,fontSize: 10),)
              ],
            )
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            record.team2,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

class PointsTableRecord {
  final String team1;
  final String team2;
  final String team1_score;
  final String team2_score;
  final String seperator;
  final String title;
  final String sub_title;

  final DocumentReference reference;

  PointsTableRecord.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['team1'] != null),
        assert(map['team2'] != null),
        assert(map['team1_score'] != null),
        assert(map['team2_score'] != null),
        assert(map['seperator'] != null),
        assert(map['title'] != null),
        assert(map['sub_title'] != null),
        team1 = map['team1'],
        team2 = map['team2'],
        team1_score = map['team1_score'],
        team2_score = map['team2_score'],
        seperator = map['seperator'],
        title = map['title'],
        sub_title = map['sub_title'];

  PointsTableRecord.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data, reference: snapshot.reference);
// @override
// String toString() => "Record<$name:$votes>";
}
Widget _buildPointsTable(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _buildFixtureItem(context, data)).toList(),
  );
}
Widget _buildPointsTableItem(BuildContext context, DocumentSnapshot data) {
  final record = PointsTableRecord.fromSnapshot(data);
  return pointsTable(record, context);
}
Widget pointsTable(record, context) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    //color: Color(0xffe0ffed),
    elevation: 2.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            record.team1,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  record.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      record.team1_score,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    SizedBox(width: 8,),
                    Container(
                      width: 50,
                      height: 20,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () {},
                        child: Text(record.seperator),
                        textColor: Colors.white,
                        color: Colors.greenAccent,
                      ),
                    ),
                    SizedBox(width: 8,),
                    Text(
                      record.team2_score,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Text(record.sub_title,style: TextStyle(color: Colors.grey,fontSize: 10),)
              ],
            )
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            record.team2,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

class _FilteredPointsTableState extends State<FilteredPointsTable> {

  @override
  void initState() {
    print(filterDept);
    print(filterGame);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff67388c),
            title: Text("Feeds"),
            bottom: TabBar(
            tabs: [
              Tab(text: "Point Table"),
              Tab(text: "Fixtures"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('points_table').where('department',isEqualTo: filterDept).where('game',isEqualTo: filterGame).orderBy('time', descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Center(
                    child: CircularProgressIndicator(),
                  );

                  if(snapshot.data.documents.length == 0){
                    return Center(
                      child: Text("No data to show"),
                    );
                  }else{
                    return _buildFixture(context, snapshot.data.documents);
                  }

                },
              ),
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('fixtures').where('department',isEqualTo: filterDept).where('game',isEqualTo: filterGame).orderBy('time', descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Center(
                    child: Text("No data to show"),
                  );

                  if(snapshot.data.documents.length == 0){
                    return Center(
                      child: Text("No data to show"),
                    );
                  }else{
                    return _buildFixture(context, snapshot.data.documents);
                  }

                },
              ),
            ],
          ),
        ),
      );
      // _buildBody(context),
  }
}

