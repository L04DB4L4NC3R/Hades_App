import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:hade/models/global.dart';
import 'package:hade/util.dart';
import 'package:hade/models/organization.dart';

// import 'package:fluttertoast/fluttertoast.dart';

class JoinOrganization extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    
    return JoinOrganizationState();
  }

}
class JoinOrganizationState extends State<JoinOrganization>{

  bool hide=false;
  String search;
  TextEditingController editingController ;

  Requests requests=null;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      body:SingleChildScrollView(
        child:GestureDetector(
        onTap: (){
      FocusScope.of(context).requestFocus(new FocusNode());
    },
    child:Column(
    children: <Widget>[
    Container(
    margin: EdgeInsets.only(top: 50,right: 16,left: 16,bottom: 16),

    height: 50.0,
    width: double.infinity,
    decoration: BoxDecoration(
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.grey[400],
        offset: Offset(0.5, 0.5),
        blurRadius: 10.0,
      ),
    ],
    shape: BoxShape.rectangle,
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(10))),

    child: TextField(
    cursorColor: Colors.blue,
    controller: editingController,


    decoration:  InputDecoration(
//                                    icon: Container( margin: EdgeInsets.all(5), child: Icon(Icons.search, color: Colors.black,),),
    hintText: "Search Organization",
    suffixIcon:GestureDetector(
    onTap: (){
    setState(() {
    hide=true;
    
    editingController.clear();
    FocusScope.of(context).requestFocus(new FocusNode());

    });

    },
    child: Container( child: Icon(Icons.clear, color: Colors.black,),)),
    border: InputBorder.none,
    contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
    ),
    onChanged: (value){
    setState(() {
    hide=false;
    search=value;
    _SearchOption(value);

    });

    },
    ),
    ),
  requests==null?Container():  Container(
    height: 300,
      child:Container(
            child: ListView.builder(
                itemCount: requests.requested.length,
                itemBuilder: (context, index) {
                  print(requests.requested[index].fullName);
                  return Container(
                      decoration: continerDecor,
                      padding: containerPad,
                      margin: containerMargin,
                      child: Column(
                          children: <Widget>[
                            Row(
                                children: <Widget>[
                                  Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: bluegrey
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.all(2),
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.circle,


                                            // borderRadius: BorderRadius.all(Radius.circular(20)),
                                            image: new DecorationImage(
                                                fit: BoxFit.fill,

                                                image: new NetworkImage(
                                                   requests.requested[index].photoUrl,)),
                                          ),
                                        ),
                                      )
                                  ),

                                  Container(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            Container(child: Text(
                                              requests.requested[index].fullName,
                                              style: TextStyle(fontSize: 14,color: Colors.black,decoration: TextDecoration.none,fontWeight: FontWeight.w400),)),
                                            Container(child: Text(
                                              requests.requested[index].location,
                                              style: TextStyle(fontSize: 12.0,color:Colors.grey ,fontWeight: FontWeight.w400,decoration: TextDecoration.none,fontFamily: 'Raleway'),)),
                                            Padding(padding: EdgeInsets.only(
                                                top: 5),),
                                            // Row(
                                            //     crossAxisAlignment: CrossAxisAlignment
                                            //         .end,
                                            //     mainAxisAlignment: MainAxisAlignment
                                            //         .end,
                                            //     children: <Widget>[

                                            //       GestureDetector(
                                            //           onTap: () {
                                            //             _checkStatusToServer(
                                            //                 true.toString(),
                                            //                 request
                                            //                     .requested[index]
                                            //                     .id,index);
                                            //           },
                                            //           child: Container(
                                            //             width: 100,
                                            //             margin: EdgeInsets.only(
                                            //                 left: 16),
                                            //             padding: EdgeInsets
                                            //                 .only(top: 3,
                                            //                 bottom: 3,
                                            //                 left: 10,
                                            //                 right: 10),
                                            //             decoration: new BoxDecoration(
                                            //                 border: Border.all(
                                            //                   width: 1.0,
                                            //                   color: Colors
                                            //                       .green,),
                                            //                 borderRadius: new BorderRadius
                                            //                     .all(
                                            //                     Radius.circular(
                                            //                         10.0)),
                                            //                 color: Colors
                                            //                     .green),
                                            //             child: Row(
                                            //               mainAxisAlignment: MainAxisAlignment
                                            //                   .center,
                                            //               children: <Widget>[
                                            //                 Container(
                                            //                     padding: EdgeInsets
                                            //                         .all(
                                            //                         3),
                                            //                     child: Text(
                                            //                       'Accept',
                                            //                       style: whiteBtnText,)
                                            //                 )
                                            //               ],
                                            //             ),
                                            //           )), GestureDetector(
                                            //           onTap: () {
                                            //             _checkStatusToServer(
                                            //                 false.toString(),
                                            //                 request
                                            //                     .requested[index]
                                            //                     .id,index);
                                            //           },
                                            //           child: Container(
                                            //             width: 100,
                                            //             margin: EdgeInsets.only(
                                            //                 left: 16),
                                            //             padding: EdgeInsets
                                            //                 .only(top: 3,
                                            //                 bottom: 3,
                                            //                 left: 10,
                                            //                 right: 10),
                                            //             decoration: new BoxDecoration(
                                            //                 border: Border.all(
                                            //                   width: 1.0,
                                            //                   color: Colors
                                            //                       .red,),
                                            //                 borderRadius: new BorderRadius
                                            //                     .all(
                                            //                     Radius.circular(
                                            //                         10.0)),
                                            //                 color: Colors.white),
                                            //             child: Row(
                                            //               mainAxisAlignment: MainAxisAlignment
                                            //                   .center,
                                            //               children: <Widget>[
                                            //                 Container(
                                            //                     padding: EdgeInsets
                                            //                         .all(
                                            //                         3),
                                            //                     child: Text(
                                            //                       'Reject',
                                            //                       style: redBtnText,)
                                            //                 )
                                            //               ],
                                            //             ),
                                                      // )),
                                                // ]
                                            // )
                                          ]
                                      ))
                                ]
                            )

                          ]
                      )

                  );
                })
        ))
    ]))));
  }

  _SearchOption(String res) {



print(res+")))))))))))))))))");

    Future fetchPosts(http.Client client) async {
      var response = await http.get(URL_SEARCHORG+"$res");
      print(response.body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
      print(data);
      if(this.mounted){
        setState(() {
          requests=Requests.fromJson(data);
        });
      }
      
      }
    }



    return FutureBuilder(

        future: fetchPosts(http.Client()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });

}



}