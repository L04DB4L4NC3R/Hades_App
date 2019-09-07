import 'package:flutter/material.dart';
import 'package:hade/util.dart';
import 'package:http/http.dart' as http;
import 'package:hade/models/global.dart';
import 'dart:async';
import 'dart:convert';
import 'package:hade/createOrganisationPage.dart';
import 'package:hade/screens/joinOrganization.dart';
import 'package:hade/models/get_Organization.dart';
import 'package:hade/userDataMangment.dart';
import 'package:hade/screens/login.dart';


class GetOrganizationPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GetOrganizationPageState();
  }

}


class GetOrganizationPageState extends State<GetOrganizationPage>{

  SharedPreferencesTest s=new SharedPreferencesTest();

  String token='';
  @override
  initState(){
    super.initState();

  Future<String> tok=s.getToken();
  tok.then((res){
    setState(() {
     token=res; 
    });
  });
  }

  toHomePage(){
     Navigator.of(context).pushReplacementNamed('/homepage');
  }

Data _data;
 Future fetchPosts(http.Client client) async {
   if(token!=''){
 var response=await http.get(URL_GETORG,headers:{"Authorization": "$token"} );

    print(response.body.toString());
    print(response.statusCode);
  if(response.statusCode==200){
   final data = json.decode(response.body);
   if(data["message"].compareTo("Successful")==0) {
     if (data["data"]["organizations"] == null) {
return "yo";
     }
     else {
       _data = Data.fromJson(data["data"]);
       print(data);
       s.setOrgList(_data.organization);
       toHomePage();
       return _data;
     }
   }
  
     }
  else{
    return "Server Error";
  }
   }
 }
     


toCreate(){
   Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateOrganisationScreen()));
}

toJoin(){
   Navigator.push(
        context, MaterialPageRoute(builder: (context) => JoinOrganization(token)));
}
 
  @override
  Widget build(BuildContext context) {
    return 
 Container(
        color:backgroundColor,
      child: FutureBuilder(
        future: fetchPosts(http.Client()),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.data==null){
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );

          }else if(snapshot.data=="Server Error"){
            return Container(
              child: Center(
                child: Text(snapshot.data),
              ),
            );
          }
          else if(snapshot.data=="yo"){

            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                title: Text("Hades",style: TextStyle(color: Colors.black),),
              actions: <Widget>[
//                IconButton(icon: Icon(Icons.check_box_outline_blank),onPressed: (){
//                  s.setLoginCheck(false);
//                  Navigator.of(context).popUntil((route) => route.isFirst);
//                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
//                },)
              ],
              ),
              body: Container(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                onTap:(){
toJoin();
                } ,child: Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                   Container(
                  height: 150,
                  width: 150,
                    margin: EdgeInsets.all(16),
                   decoration:BoxDecoration(
                     color: Colors.white,
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.grey[400],
        offset: Offset(0.5, 0.5),
        blurRadius: 10.0,
      ),
    ],
    shape: BoxShape.rectangle,
   
    
    borderRadius: BorderRadius.all(Radius.circular(10))),
                  child:Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 2),
                        child:Icon(Icons.check_circle,size: 90,color: Colors.amber,)
                      ),
                       Container(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 2),
                        child:Text("Join",style: TextStyle(fontWeight: FontWeight.w500,decoration: TextDecoration.none,fontSize: 16),)
                      )

                      
                    ],
                  )
                ),
                ]
                
                ,)),
              GestureDetector(
                onTap:(){
toCreate();
                } ,
           child:  Container(
                height: 150,
                  width: 150,
                   decoration:BoxDecoration(
                     color: Colors.white,
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.grey[400],
        offset: Offset(0.5, 0.5),
        blurRadius: 10.0,
      ),
    ],
    shape: BoxShape.rectangle,
    
    borderRadius: BorderRadius.all(Radius.circular(10))),
    margin: EdgeInsets.all(16),
                  child:Column(
                    children: <Widget>[
Container(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 2),
                        child:Icon(Icons.add_circle,size: 90,color: Colors.green,)
                      ),
                       Container(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 2),
                        child:Text("Create",style: TextStyle(fontWeight: FontWeight.w500,decoration: TextDecoration.none,fontSize: 16),)
                      )

                    ],
                  )
                ))

              ],)));
          }
          else{
            return Container(
                child: Center(
                child: CircularProgressIndicator(),
          ),
          );
          }
        }));
  }
 
 


}