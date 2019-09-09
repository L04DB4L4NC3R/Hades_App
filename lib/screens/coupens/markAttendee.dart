import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hade/models/global.dart';
import 'package:flutter/material.dart';

import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:flutter/services.dart';
import 'package:hade/models/read_coupon.dart';
import 'package:hade/models/readApi.dart';
import 'package:toast/toast.dart';

class MarkScreen extends StatefulWidget {

  
  int pos;
  RS events;
  MarkScreen(this.pos,this.events);

  @override
  State<StatefulWidget> createState() {
    return _MarkState(pos,events);
  }
}

class _MarkState extends State<MarkScreen> {
  String result = "Press Scan";
  ReadCoupon coupon;
  int pos;
  RS events;
  Color clr;
  int index=1;
  List _colors;
  String day="0";


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   GlobalKey<FormState> _key = new GlobalKey();
    bool _validate = false;

  _MarkState(this.pos,this.events);

  Map<String, dynamic> body ={
    "attendance": {
        "eventName": "DEVRELCONF",
        "email": "a@a.COM",
        "day": 2
    }
};

 final myController = TextEditingController();
String _text = "initial";
  TextEditingController _c;
String email;
 

  @override
  initState() {
     _c = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     clr=Theme.of(context).backgroundColor;
       _colors = [
         clr,
    Colors.green[500],
    Colors.red,];
    //String result = "Hey there !";
         return Scaffold(
      appBar: AppBar(
        
        title: Text("Day : "+pos.toString(),textAlign: TextAlign.center,),
       centerTitle: true,
       elevation: 0.0,
      ),

      
      
      // backgroundColor: _colors[0],
      body:
       Container(
         color: Theme.of(context).backgroundColor,
         padding: EdgeInsets.all(35.0),
          child:Container(
        color: _colors[index],
        child: Center(

       
        child:Container(
          
          margin: EdgeInsets.all(3),
          color: Theme.of(context).backgroundColor,
          padding:EdgeInsets.all(28),
          
         
            
            child:Center(child: Column(
         children: <Widget>[
           Container(
                padding: EdgeInsets.only(left: 16.0,right:16.0,top: 16.0),
                  child: new Theme(
          data: new ThemeData(
            primaryColor: Theme.of(context).accentColor,
            
          ),
                child:
             new TextFormField(
            decoration: new InputDecoration(hintText: 'Email ID',labelText: 'Email ID',border: OutlineInputBorder(),),
            keyboardType: TextInputType.emailAddress,
            onSaved: (String val) {
              email = val;
            }),
              )),
                RaisedButton(
                elevation: 5,
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                  color: Theme.of(context).accentColor,
                    child: Text('Check',style: TextStyle(color: Colors.white),),
              onPressed: (){
                _sendToServer(email);
               
              },), Text(
           
          result,
          style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ) ] )
          
        ),
        

         
         
          
          
        ),
      ),),
        ),
      floatingActionButton: FloatingActionButton.extended(
        
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
);
  }

   String Number(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Day is Required";
    } else if(value.length > 3){
      return "Enter valid Day Number";
    }else if (!regExp.hasMatch(value)) {
      return "Day must be digits";
    }
    return null;
  }

   Future _scanQR() async {
     try {
      String qrResult =await  QRCodeReader().scan();
      if(qrResult!=null){
      setState(() {
      print(qrResult);
        _sendToServer(qrResult.toString());

      });

     }
     
     else{
       setState(() {
         index=2;
       });
Toast.show("No QR Scanned", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
     }}

    catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
        index=2;
      });
    }
   }

   void _processData(String res) {
    // Process your data and upload to server
    result=res;
    //widget.key?.currentState?.reset();
  }

   _sendToServer(String res){
    String eve=events.name.toString();
   
   
    print(eve+pos.toString()+result);
    
   body["attendance"]["day"] = pos;
    body["attendance"]["email"] = '$res';
     body["attendance"]["eventName"] = '$eve';
   
  print(body);

     Future fetchPosts(http.Client client) async {
 var response=await http.post(URL_MARKATTENDENCE, body: json.encode(body));

    
   final data = json.decode(response.body);
   
      print(data['rs']);
      print(day);
      setState(() {
       if(data['rs'].toString()=="Successfully marked present for the day")
       {
         setState(() {
           index=1;
         });
         
       }
       else{
        setState(() {
           index=2;
         });
       }
      });

         _processData(data['rs']);
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
      return Container();
          }
          });

  }


}

