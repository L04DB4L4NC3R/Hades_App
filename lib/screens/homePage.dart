import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hade/models/readApi.dart';
import 'package:flutter/foundation.dart';
import 'package:hade/util.dart' as prefix0;
import 'package:http/http.dart' as http;
import 'package:hade/models/global.dart';
import 'dart:async';
import 'dart:convert';
import 'package:hade/screens/login.dart';
import 'package:hade/notificationScreen.dart';
import 'package:hade/cards/eventCard.dart';
import 'package:hade/models/get_Organization.dart';
import 'package:hade/userDataMangment.dart';
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


  String orgName='';
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

  List<Organization> orgList;


  SharedPreferencesTest s = new SharedPreferencesTest();

  String token = '';
  String _result;

  int _radioValue = 0;
  int orgIndex=0;

  @override
  void initState() {
    super.initState();
    Future<List<Organization>> org=s.getOrgList();
    org.then((res){
      setState(() {
        orgIndex=0;
       orgList=res;
       orgName=res[orgIndex].name;
       print(orgName);

      });
    });
    Future<String> tok = s.getToken();
    tok.then((res) {
      setState(() {
        token = res;
      });
    });
  }

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


  bool _enabled = false;
  Map<String, dynamic> body = {
    "query": {"key": "clubName", "value": "WTM","organization":"WTM"}
  };


  Future fetchPosts(http.Client client) async {
    if (token != '') {
      print("CircularProgressIndicator()ayysydyyd");
      print(token);
      print(body);
      body["query"]["value"]='$orgName';
      body["query"]["organization"]='$orgName';
      var response = await http.post(
          URL_READEVENT, headers: {"Authorization": "$token"},
          body: json.encode(body));

      print(response.body.toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["err"] == null) {
          if (data["rs"] != null) {
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
          else {
            print("dwgvdkwejgv");
            return "No Data to be Fetched";
          }
        }

        else {
          return "No Data to be Fetched";
        }
      }
      else {
        return "No Data to be Fetched";
      }
    }
  }

  bool remove = true;

  @override
  Widget build(BuildContext context) {
    return
      Container(
        color: prefix0.backgroundColor,
        child: FutureBuilder(
            future: fetchPosts(http.Client()),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              else if (snapshot.data ==
                  'Server under Maintainence. Sorry, for Inconvinence.') {
                print(snapshot.data);
                return
                  Center(
                      child: Container(

                          child: Text(snapshot.data, style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w300),)
                      )
                  );
              }
              else if (snapshot.data == "No Data to be Fetched") {
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
                                  height: double.parse((70*orgList.length).toString()),
                                  child:ListView.builder(
                                      itemCount: orgList.length,
                                      itemBuilder: (BuildContext context,int index){
                                        return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                orgIndex=index;
                                                orgName=orgList[index].name;
                                              });
                                            },
                                            child:Container(
                                              child:Row(
                                                children: <Widget>[
                                                  Flexible(child: orgList[orgIndex].tag=="default_image"?Container(
                                                    margin: EdgeInsets.all(16),
                                                    padding: EdgeInsets.all(16),
                                                    decoration: BoxDecoration(
                                                      color:Colors.blueAccent,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Text(orgList[orgIndex].name.substring(0,1).toUpperCase(),style:TextStyle(fontSize: 21,color: Colors.white),),
                                                  ):Container(
                                                    padding: EdgeInsets.only(
                                                        right: 20.0, left: 30.0, top: 16.0),
                                                    child: Image.asset(orgList[orgIndex].tag,
                                                        width: 90.0,
                                                        height: 90.0,
                                                        fit: BoxFit.cover),
                                                  ),flex: 4,),
                                                  Flexible(child: Text(orgList[index].name,style: TextStyle(fontSize: 18,color: Colors.black),),flex: 3,)
                                                ],
                                              ) ,
                                            ));
                                      }
                                  )
                              ),


//                              Container(
//                                child:
//                                Row(
//                                  children: <Widget>[
//                                    Flexible(child: Container(
//                                      padding: EdgeInsets.only(
//                                          left: 16, right: 150),
//                                      child: Text("Light Theme"),), flex: 5,),
//                                    Flexible(child: Radio(
//
//                                      value: 0,
//                                      groupValue: _radioValue,
//                                      onChanged: _handleRadioValueChange,
//                                    ), flex: 1,)
//                                  ],
//                                ),),
//
//
//                              Container(
//                                child:
//                                Row(
//                                  children: <Widget>[
//                                    Flexible(child: Container(
//                                      padding: EdgeInsets.only(
//                                          right: 150, left: 16),
//                                      child: Text("Dark Theme"),), flex: 5,),
//                                    Flexible(child: Radio(
//
//                                      value: 1,
//                                      groupValue: _radioValue,
//                                      onChanged: _handleRadioValueChange,
//                                    ), flex: 1,)
//                                  ],
//                                ),),
//
                              IconButton(icon: Icon(Icons.check_box_outline_blank),onPressed: (){
                                s.setLoginCheck(false);
                                Navigator.of(context).popUntil((route) => route.isFirst);
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
                              },)
                            ]
                        )


                    ),


                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateEventPage()),
                        );
                      },
                      child: Icon(Icons.add,),
                      heroTag: "Add Event",
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(16.0))),
                    ), body: Container(

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(child:Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Flexible(child: orgList[orgIndex].tag=="default_image"?Container(
                                margin: EdgeInsets.all(16),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color:Colors.blueAccent,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(orgList[orgIndex].name.substring(0,1).toUpperCase(),style:TextStyle(fontSize: 32,color: Colors.white),),
                              ):Container(
                                padding: EdgeInsets.only(
                                    right: 20.0, left: 30.0, top: 16.0),
                                child: Image.asset(orgList[orgIndex].tag,
                                    width: 90.0,
                                    height: 90.0,
                                    fit: BoxFit.cover),
                              ),flex: 4,),
                              Flexible(child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(child:Container
                                      (padding: EdgeInsets.only(top: 40),
                                        child:Text(
                                          orgList[orgIndex].name,
                                          style: TextStyle(fontWeight: FontWeight.w700),
                                        )),flex:1),
                                    Flexible(child:Text(
                                      orgList[orgIndex].location,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                                    ),flex:1),
                                  ]),flex:6),
                            ]),flex: 3,),
                        Flexible(child: Container(
                            padding: EdgeInsets.only(top: 16, left: 20),
                            child: Row(
                              children: <Widget>[
                                Flexible(child: Text(
                                  "Events",
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ), flex: 15,),
                                Flexible(child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.grey,
                                    )), flex: 1),
                              ],
                            )), flex: 1),
                        Flexible(

                            child:Center(child: Container(child: Text("No Events"),)),
                            flex: 8),


                      ],)));
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
       actions: <Widget>[
         IconButton(icon: Icon(Icons.notifications),onPressed: (){
           Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) =>NotificationScreen(orgName,token),
             ),
           );
         },)
       ],
       // backgroundColor: Colors.grey[50],
        
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
          Container(
            height: double.parse((70*orgList.length).toString()),
            child:ListView.builder(
              itemCount: orgList.length,
                itemBuilder: (BuildContext context,int index){
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      orgIndex=index;
                    });
                  },
                  child:Container(
                child:Row(
                  children: <Widget>[
                    Flexible(child: orgList[orgIndex].tag=="default_image"?Container(
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color:Colors.blueAccent,
                        shape: BoxShape.circle,
                      ),
                      child: Text(orgList[orgIndex].name.substring(0,1).toUpperCase(),style:TextStyle(fontSize: 21),),
                    ):Container(
                      padding: EdgeInsets.only(
                          right: 20.0, left: 30.0, top: 16.0),
                      child: Image.asset(orgList[orgIndex].tag,
                          width: 90.0,
                          height: 90.0,
                          fit: BoxFit.cover),
                    ),flex: 4,),
                   Flexible(child: Text(orgList[index].name,style: TextStyle(fontSize: 18,color: Colors.black),),flex: 3,)
                  ],
                ) ,
              ));
                }
            )
          ),
               

//
//           Container(
//         child:
//           Row(
//             children: <Widget>[
//              Flexible(child:Container(
//                padding: EdgeInsets.only(left:16,right: 150),
//                child: Text("Light Theme"),),flex:5,)  ,
//                       Flexible(child: Radio(
//
//        value: 0,
//        groupValue: _radioValue,
//        onChanged: _handleRadioValueChange,
//      ),flex: 1,)
//             ],
//           ),),
//
//
//       Container(
//         child:
//           Row(
//             children: <Widget>[
//              Flexible(child:Container(
//                padding: EdgeInsets.only(right: 150,left: 16),
//                child: Text("Dark Theme"),),flex:5,)  ,
//                       Flexible(child: Radio(
//
//        value: 1,
//        groupValue: _radioValue,
//        onChanged: _handleRadioValueChange,
//      ),flex: 1,)
//             ],
//           ),),
            IconButton(icon: Icon(Icons.check_box_outline_blank),onPressed: (){
              s.setLoginCheck(false);
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
            },)
            
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
       Flexible(child: orgList[orgIndex].tag=="default_image"?Container(
         margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:Colors.blueAccent,
            shape: BoxShape.circle,
          ),
          child: Text(orgList[orgIndex].name.substring(0,1).toUpperCase(),style:TextStyle(fontSize: 32,color: Colors.white),),
        ):Container(
         padding: EdgeInsets.only(
             right: 20.0, left: 30.0, top: 16.0),
         child: Image.asset(orgList[orgIndex].tag,
             width: 90.0,
             height: 90.0,
             fit: BoxFit.cover),
       ),flex: 4,),
        Flexible(child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Flexible(child:Container
          (padding: EdgeInsets.only(top: 40),
            child:Text(
              orgList[orgIndex].name,
            style: TextStyle(fontWeight: FontWeight.w700),
          )),flex:1),
          Flexible(child:Text(
            orgList[orgIndex].location,
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

                
                return  EventCard(snapshot.data[index],index,orgName);
                
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
 