import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hade/models/readApi.dart';
import 'package:flutter/foundation.dart';
import 'package:hade/util.dart' as prefix0;
import 'package:http/http.dart' as http;
import 'package:hade/models/global.dart';
import 'dart:async';
import 'dart:convert';

import 'package:hade/cards/eventCard.dart';
import 'package:hade/screens/createEventPage.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:dynamic_theme/theme_switcher_widgets.dart';
import 'package:hade/theme.dart';

import 'package:permission/permission.dart';




class HomePage extends StatefulWidget {

  final ThemeBloc themeBloc;

  HomePage({Key key, this.themeBloc}) : super(key: key);




  

  

  @override
  State<StatefulWidget> createState() {
    return _HomePageState(themeBloc: themeBloc,);
  }
}

  enum PermissionName {
  // iOS
  Internet,
  Storage
}

class _HomePageState extends State<HomePage> {




  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();

    var refreshKey = GlobalKey<RefreshIndicatorState>();

  // Future<bool> _onWillPop() {
  //   return showDialog(
  //     context: context,
  //     builder: (context) => new AlertDialog(
  //       title: new Text('Are you sure?'),
  //       content: new Text('Do you want to exit an App'),
  //       actions: <Widget>[
  //         new FlatButton(
  //           onPressed: () => Navigator.of(context).pop(false),
  //           child: new Text('No'),
  //         ),
  //         new FlatButton(
  //           onPressed: () => Navigator.of(context).pop(true),
  //           child: new Text('Yes'),
  //         ),
  //       ],
  //     ),
  //   ) ?? false;
  // }



   final ThemeBloc themeBloc;

  _HomePageState({Key key, this.themeBloc});

  

  String _result;

  int _radioValue = 0;
  
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
  
      switch (_radioValue) {
        case 0:
          themeBloc.selectedTheme.add(_buildLightTheme());
          break;
        case 1:
          themeBloc.selectedTheme.add(_buildDarkTheme());
          break;
        
      }
    });
  }

  



   bool _enabled=false;
  Map<String, dynamic> body = {
  "query": {"key": "clubName", "value": "DSC-VIT", "specific": ""}
};



     Future fetchPosts(http.Client client) async {
 var response=await http.post(URL_READEVENT, body: json.encode(body));

    print(response.body.toString());
    print(response.statusCode);
  if(response.statusCode==200){
   final data = json.decode(response.body);
   if(data["error"]==null)
 {
      print(data['rs'][0]);
      List<RS> products = new List<RS>();
    for (int i = 0; i < data['rs'].length; i++) {
      products.add(new RS.fromJson(data['rs'][i]));
      print(data['rs'][i]);
    }
    print(products[0].clubName);
    print(products[0].fromDate);
    return products;
  }
     
     else{
    return "No Data to be Fetched";
  }
     }
     else{
       
       return "No Event found";
     }
     }
     
bool remove=true;
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return 
      Container(
        color:prefix0.backgroundColor,
      child: FutureBuilder(
        future: fetchPosts(http.Client()),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.data==null){
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );

          }
          else if((snapshot.data=='Server under Maintainence. Sorry, for Inconvinence.')|| (snapshot.data=="No Data to be Fetched")){
            print(snapshot.data);
           return
           Center(
             child: Container(
            
              child:Text(snapshot.data)
            )
           );
          
              
          }
          
          else{
           
             print(snapshot.data);
            return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hades',
           textAlign: TextAlign.center,
        ),
        centerTitle: true,
        elevation: 0.0,
       // backgroundColor: Colors.grey[50],
        
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
          
               

           
           Container(
         child:
           Row(
             children: <Widget>[
              Flexible(child:Container(
                padding: EdgeInsets.only(left:16,right: 150),
                child: Text("Light Theme"),),flex:5,)  , 
                       Flexible(child: Radio(
                         
        value: 0,
        groupValue: _radioValue,
        onChanged: _handleRadioValueChange,
      ),flex: 1,)
             ],
           ),),
       
      
       Container(
         child:
           Row(
             children: <Widget>[
              Flexible(child:Container(
                padding: EdgeInsets.only(right: 150,left: 16),
                child: Text("Dark Theme"),),flex:5,)  , 
                       Flexible(child: Radio(
                         
        value: 1,
        groupValue: _radioValue,
        onChanged: _handleRadioValueChange,
      ),flex: 1,)
             ],
           ),),
            
            
         ]
            )
            
          
          
        ),
      
      
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    Navigator.push(
   context,
   MaterialPageRoute(builder: (context) => CreateEventPage()),
 );

  },
  child: Icon(Icons.add,),
  heroTag: "Add Event",
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
),body:  Container(
              
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Flexible(child:Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
       Flexible(child: Container(
          padding: EdgeInsets.only(right: 20.0, left: 30.0, top: 16.0),
          child: Image.asset('images/dscnew.webp',
              width: 90.0, height: 90.0, fit: BoxFit.cover),
        ),flex: 4,),
        Flexible(child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Flexible(child:Container
          (padding: EdgeInsets.only(top: 40),
            child:Text(
            "Developer Student Clubs",
            style: TextStyle(fontWeight: FontWeight.w700),
          )),flex:1),
          Flexible(child:Text(
            "VIT Vellore",
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          ),flex:1),
        ]),flex:6),
      ]),flex: 3,),
      Flexible(child: Container(
              padding: EdgeInsets.only(top: 16,left:20),
              child: Row(
                children: <Widget>[
                  Flexible(child:Text(
                    "Events",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),flex: 15,),
                  Flexible(child:IconButton(
                      icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  )),flex:1),
                ],
              )),flex: 1),
                Flexible(
                  
             child:ListView.builder(
              itemCount: snapshot.data.length,
               padding: const EdgeInsets.only(bottom: 16,left: 16,right: 16),
              itemBuilder: (BuildContext context,int index){

                
                return  EventCard(snapshot.data[index],index);
                
              },
            ),flex: 8),
            

              ],)));
          }
        }
      ),
  
   
      
    );
  }
@override
  DemoTheme _buildLightTheme() {
    return DemoTheme(
        'light',
        
        ThemeData(
        //  hintColor: Colors.blue,
         // highlightColor: Colors.blue,
          //primaryColorDark: Colors.grey[50],
          // brightness: Brightness.light,
         
          // accentColor: Colors.blue,
          // backgroundColor: Colors.white,
          // primaryColor: Colors.white10,

          brightness: Brightness.light,
          accentColor: Colors.blue,
          backgroundColor: Colors.grey[50],
         primaryColor: Colors.grey[50],
          
           
           
        ));
  }
@override
  DemoTheme _buildDarkTheme() {
    return DemoTheme(
        'dark',
        ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.purple,
          primaryColor: Colors.grey[850],
          backgroundColor: Colors.grey[850]
        ));
  }


  }
 