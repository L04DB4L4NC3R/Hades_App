import 'package:flutter/material.dart';
import 'package:hade/models/readApi.dart';
import 'package:http/http.dart' as http;
import 'package:hade/models/global.dart';
import 'dart:async';
import 'dart:convert';

class CreateCoupenPage extends StatefulWidget{

   RS events;
  int pos;

   CreateCoupenPage(this.events,this.pos);
  @override
  @override
  State<StatefulWidget> createState() {
    return _CreateCoupenPage(events,pos);
  }
}



  
  class _CreateCoupenPage extends State<CreateCoupenPage>{
    
    

    RS events;
    int pos;

    _CreateCoupenPage(this.events,this.pos);
    String selectedgender;

    String name;
    String day;
    String des;
  


     GlobalKey<FormState> _key = new GlobalKey();
    bool _validate = false;

     Map<String, dynamic> body ={
    "event": "DEVRELCONF",
    "coupons": [
        {
            "name": "lunch",
            "description": "lunch",
            "day": 1
        }
    ]
};
 
  

    List _gender =
  ["Male", "Female", "Other"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedGender;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _selectedGender = _dropDownMenuItems[0].value;
    super.initState();
  }



  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String gender in _gender) {
      items.add(new DropdownMenuItem(
          value: gender,
          child: new Text(gender)
      ));
    }
    return items;
  }

   String newValue;

   final myController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       appBar: AppBar(
        title: Text(
          'Create',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        elevation: 0.0,
       
      ),
      body: new Form(
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
                    "Form",
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
                padding: EdgeInsets.only(left: 16.0,right:16.0,top:10),
                  child: new Theme(
          data: new ThemeData(
            primaryColor: Theme.of(context).accentColor,
            
          ),
                child:
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name',
                  labelText: 'Name',
                  
                ),
                controller: myController,
                
                validator: validateName,
          onSaved: (String val) {
            name = myController.text.toString();
          },
              )
              )),
              Container(
                padding: EdgeInsets.only(left: 16.0,right:16.0,top: 16.0),
                  child: new Theme(
          data: new ThemeData(
            primaryColor: Theme.of(context).accentColor,
            
          ),
                child:
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'eg: Dinner',
                  labelText: 'Description'
                ),
               //controller: myController1,
                
                 //keyboardType: TextInputType.phone,
                validator: validateName,
          onSaved: (String val) {
            des = val;
          },
              )
              )),
                
              Container(
                padding: EdgeInsets.only(left: 16.0,right:16.0,top:10),
                  child: new Theme(
          data: new ThemeData(
            primaryColor: Theme.of(context).accentColor,
            
          ),
                child:
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'eg: 1',
                  labelText: 'Day',
                  
                ),
                 keyboardType: TextInputType.phone,
                validator: Number,
          onSaved: (String val) {
            day = val;
          },
              )
              )),
              
         
              
               
                
    
        Container(padding: EdgeInsets.all(16),
          child:
             new RaisedButton(
                elevation: 5,
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                  color: Theme.of(context).accentColor,
                    child: Text('Submit',style: TextStyle(color: Colors.white),),
              onPressed: (){
                _sendToServer();
               
              },))
             
              ]))])


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
  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }
 void _processData() {
    // Process your data and upload to server
    _key.currentState?.reset();
    Navigator.of(context).pop();
    //widget.key?.currentState?.reset();
  }

   _sendToServer() {

     if(_key.currentState.validate())
     {
        _key.currentState.save();
     
     




     String eve=events.name.toString();
     print(name);
     var dd = int.parse(day);
   body["event"]= '$eve';
   body["coupons"][0]["name"] = '$name';
   body["coupons"][0]["description"] = '$des';
   body["coupons"][0]["day"] =dd;
   print(body);

     Future fetchPosts(http.Client client) async {
 var response=await http.post(URL_CREATECOUPON, body: json.encode(body));

    
   final data = json.decode(response.body);
   print(data);
      print(data['rs']);


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
            return Container();

          }
          });



   
     } 
      
   
   
   else{
     
      // validation error
      setState(() {
        _validate = true;
        });
    
   }
     
  
    
  }
  }