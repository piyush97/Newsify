import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:flutter/material.dart" ;

void main() =>runApp(new MaterialApp(
  home: new HomePage(),
));
// Stateful similar to real time fetches
class HomePage extends StatefulWidget{
@override
HomePageState createState()=> new HomePageState();

}

class HomePageState extends State<HomePage>{
  final String url = "https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=5915defd1d264ab489add55da5bc6552";
  List data;
  @override
  void initState(){
    super.initState();
    this.getJsonData();

  }
  //Similar to Promises in ES 6 and like async await
  Future<String> getJsonData() async{
    var response = await http.get(
//encoding the url
Uri.encodeFull(url),
//only accept json response
headers: {'accept':'application/json'}

    );

    print(response.body);
    setState((){
      var convertDataToJson = JSON.decode(response.body);
      data = convertDataToJson['articles'];
    });

    return 'Success!!!! yayyy';
  }
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title:new Text("Newsify"),
        ) ,
        body: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context,int index){
      return new Container(
child: new Center(
  child: new Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: <Widget>[
    new Card(
      child:new Container(
        child: new Text(data[index]['title']),
        padding:const EdgeInsets.all(20.0)
      ),
    )
  ],
),
      ),
      );
    },
    ),
    );
  }
}