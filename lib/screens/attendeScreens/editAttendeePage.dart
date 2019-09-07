import 'package:flutter/material.dart';
import 'package:hade/models/read_attendee.dart';
import 'package:hade/models/readApi.dart';
import 'package:http/http.dart' as http;
import 'package:hade/models/global.dart';
import 'dart:async';
import 'dart:convert';

class EditAttendeePage extends StatefulWidget {
   ReadAttendee attendee;
  int pos;
  RS events;

  EditAttendeePage(this.attendee,this.pos,this.events);
  @override
  @override
  State<StatefulWidget> createState() {
    return _EditAttendeePage(attendee,pos,events);
  }
}

class _EditAttendeePage extends State<EditAttendeePage> {
  ReadAttendee attendee;
  int pos;
  RS events;


  _EditAttendeePage(this.attendee,this.pos,this.events);

  Map<String, dynamic> body ={
    "query": {
        "key": "name",
        "Value": "dhruv sharma",
        "changeKey": "DSC",
        "changeValue": "DEVFEST 2019"
    }
};

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View',
         textAlign: TextAlign.center,
        ),
        centerTitle: true,
        elevation: 0.0,  
      ),
      body:Container(child:Column(
        children: <Widget>[
         Container(
        padding: EdgeInsets.all(28.0),
        height: 400,
        width: 500,
        child: Card(
          
          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
          child:Column(
            
          children: <Widget>[
            
            Flexible(
            child:Container(
             
              padding: EdgeInsets.all(16.0),
              child:Center(child:Container(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                      IconButton(
              icon: Icon(
                Icons.person,size: 80,
              ),
              padding: EdgeInsets.all(16.0),
            )])))),
                  
                flex: 6,),
                
                
           Flexible(child: Container(
              padding: EdgeInsets.all(16.0),
              child:Row(

              children: <Widget>[
                Text("Name: ",style: TextStyle(fontWeight: FontWeight.w600),),
                Text(attendee.name)
              ],
            )),flex: 3,),
           Flexible(child:Container(
              padding: EdgeInsets.all(16.0),
             child: Row(
              children: <Widget>[
                Text("Email: ",style: TextStyle(fontWeight: FontWeight.w600)),
                Text(attendee.email)
              ],
            )),flex:3),
           Flexible(child:Container(
              padding: EdgeInsets.all(16.0),
             child: Row(
              children: <Widget>[
                Text("Registration Number: ",style: TextStyle(fontWeight: FontWeight.w600)),
                Text(attendee.registrationNumber)
              ],
            )),flex:3),
            Flexible(child:Container(
               padding: EdgeInsets.all(16.0),
              child:Row(
              children: <Widget>[
                Text("Mobile Number: ",style: TextStyle(fontWeight: FontWeight.w600)),
                Text(attendee.phoneNumber)
              ],
            )),flex:3),
            Flexible(child:Container(
               padding: EdgeInsets.all(16.0),
              child:Row(
              children: <Widget>[
                Text("Gender: ",style: TextStyle(fontWeight: FontWeight.w600)),
                Text(attendee.gender)
              ],
            )),flex: 3,),
          ],
        ),
        elevation: 5.0,
      ),
      ),
      Center(child:      Container(
        
        padding: EdgeInsets.all(16.0),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child:
          RaisedButton(
            
                elevation: 5,
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                  color: Colors.red,
                    child: Text('Delete',style: TextStyle(color: Colors.white),),
              onPressed: (){
                _sendToServer();
               
              },)),
              // RaisedButton(
              //   elevation: 5,
              //     shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
              //     color: Theme.of(context).accentColor,
              //       child: Text('Edit',style: TextStyle(color: Colors.white),),
              // onPressed: (){
              //  // _sendToServer();
               
              // },)
        ],
      ))
       ) ] )));
  }

  void _processData() {
    // Process your data and upload to server
    //_key.currentState?.reset();
    Navigator.of(context).pop();
    //widget.key?.currentState?.reset();
  }

  _sendToServer(){
    String eve=attendee.name.toString();
    String evt=events.name.toString();
    String nm=events.clubName.toString();
     print(attendee.name);
   body["query"]["changeValue"] = '$evt';
   body["query"]["Value"] = '$eve';
    body["query"]["changeKey"] = '$nm';
  

     Future fetchPosts(http.Client client) async {
 var response=await http.post(URL_DELETEATTENDEE, body: json.encode(body));

    
   final data = json.decode(response.body);
      print(data['rs']);
      //  Fluttertoast.showToast(
      //   msg: data['rs'].toString(),
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIos: 1,
      //   backgroundColor: Colors.grey[700],
      //   textColor: Colors.white);
        _processData();
  }
    
     
   print(body);
   
   return FutureBuilder(

        future: fetchPosts(http.Client()),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.data==null){
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );

          }
          else{
        //     Fluttertoast.showToast(
        // msg: "Check Your Connection",
        // toastLength: Toast.LENGTH_SHORT,
        // gravity: ToastGravity.BOTTOM,
        // timeInSecForIos: 1,
        // backgroundColor: Colors.grey[700],
        // textColor: Colors.white);
          }
          });



   
     
    
   

  }
}
