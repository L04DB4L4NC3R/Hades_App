import 'package:flutter/material.dart';
import 'package:hade/models/readApi.dart';
import 'package:hade/screens/attendeScreens/createAttendeePage.dart';
import 'package:hade/screens/attendeScreens/readAttendeePage.dart';

class AllScreen extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return _AllScreen();
  }
}

class _AllScreen extends State<AllScreen> {


  _AllScreen();
  GlobalKey<FormState> _key = new GlobalKey();
    bool _validate = false;

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:AppBar(
              title: Text("All"),
              centerTitle: true,
              elevation:0.0,
           
             
            ),
      body:new Form(
              key: _key,
              autovalidate: _validate,
              child: FormUI(),
            ),
              );
  }
  Widget FormUI() {
  
    int flag;
    return Container(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(15.0),
              children: <Widget>[
    Container(
              padding: EdgeInsets.only(left:16.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "To",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  IconButton(
                      icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  )),
                ],
              ),),
              SingleChildScrollView(
                child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left:16.0),

            child: Text("Everyone who attends the event.",style:TextStyle(fontWeight: FontWeight.w500,),)),
                   Container(
              padding: EdgeInsets.only(left:16.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Subject",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  IconButton(
                      icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  )),
                ],
              ),),
              Container(
                padding: EdgeInsets.only(left: 16.0,right:16.0),
                  child: new Theme(
          data: new ThemeData(
            primaryColor: Theme.of(context).accentColor,
            
          ),
                child:
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  
                  
                ),
               
              )
              )),
               Container(
              padding: EdgeInsets.only(left:16.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Body",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  IconButton(
                      icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  )),
                ],
              ),),
              Container(
                padding: EdgeInsets.only(left: 16.0,right:16.0),
                  child: new Theme(
          data: new ThemeData(
            primaryColor: Theme.of(context).accentColor,
            
          ),
                child:
              TextFormField(
                 keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                 
                ),
                
                
          onSaved: (String val) {
           
          },
              )
              )),
            
             
              
        Container(padding: EdgeInsets.only(left:16),
          child:
             new RaisedButton(
                elevation: 5,
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                  color: Theme.of(context).accentColor,
                    child: Text('Submit',style: TextStyle(color: Colors.white)),
              onPressed: (){
               sendtoserver();
               
              },))
             
              ]))])


              );
   }
    sendtoserver()
    {
       _key.currentState?.reset();
    Navigator.of(context).pop();
    }
}