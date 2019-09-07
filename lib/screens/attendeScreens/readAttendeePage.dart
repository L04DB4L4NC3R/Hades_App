import 'package:flutter/material.dart';
import 'package:hade/models/readApi.dart';
import 'package:http/http.dart' as http;
import 'package:hade/models/global.dart';
import 'package:hade/models/read_attendee.dart';
import 'package:hade/cards/attendeeCard.dart';
import 'dart:async';
import 'dart:convert';

class ReadAttendeePage extends StatefulWidget{

   RS events;
  int pos;

   ReadAttendeePage(this.events,this.pos);
  @override
  @override
  State<StatefulWidget> createState() {
    return _ReadAttendeePage(events,pos);
  }
}



  
  class _ReadAttendeePage extends State<ReadAttendeePage>{

    

     

    
 

    RS events;
    int pos;

    _ReadAttendeePage(this.events,this.pos);
    String selectedgender;



  @override
  Widget build(BuildContext context) {
//      var details = {
//     '"event"': "WomenTechies"
// }; 
Map<String, dynamic> body = {
    "event": "WomenTechies"
}; 

     String eve=events.name.toString();
   body["event"] = '$eve';   
   print(body);

    Future fetchPosts(http.Client client) async {
 var response=await http.post(URL_ALLPARTICIPANTS, body: json.encode(body));
 
 final data = json.decode(response.body);
 if(data["error"]==null)
 {
      print(data['rs'][0]);
      List<ReadAttendee> products = new List<ReadAttendee>();
    for (int i = 0; i < data['rs'].length; i++) {
      products.add(new ReadAttendee.fromJson(data['rs'][i]));
      print(data['rs'][i]);
    }
    print(products[0].name);
    return products;
  } 
  else{
    return "No Data to be Fetched";
  }
    }
    
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Read',
         textAlign: TextAlign.center,
        ),
        centerTitle: true,
        elevation: 0.0,
      
        
      ),
      body:Container(
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
          else{
            if(snapshot.data!="No Data to be Fetched")
            {
            return Container(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                
      Flexible(child: Container(
              padding: EdgeInsets.only(top: 16,left:20),
              child: Row(
                children: <Widget>[
                  Flexible(child:Text(
                    "Participants",
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
                Flexible(child:ListView.builder(
              itemCount: snapshot.data.length,
               padding: const EdgeInsets.only(bottom: 16,left: 16,right: 16),
              itemBuilder: (BuildContext context,int index){
                return  AttendeeCard(snapshot.data[index],index,events);
                
              },
            ),flex: 8)

              ],));
            }
            else{
              return Center(child:Container(
                child: Text(snapshot.data),
              ),);
            }
              
          }
        },
      ),
    )
      
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:hade/models/readApi.dart';
// import 'package:http/http.dart' as http;
// import 'package:hade/models/global.dart';
// import 'package:hade/models/read_attendee.dart';
// import 'package:hade/cards/attendeeCard.dart';
// import 'dart:async';
// import 'dart:convert';

// class ReadAttendeePage extends StatefulWidget{

//    RS events;
//   int pos;

//    ReadAttendeePage(this.events,this.pos);
//   @override
//   @override
//   State<StatefulWidget> createState() {
//     return _ReadAttendeePage(events,pos);
//   }
// }



  
//   class _ReadAttendeePage extends State<ReadAttendeePage>{

    

     

    
 

//     RS events;
//     int pos;

//     _ReadAttendeePage(this.events,this.pos);
//     String selectedgender;

//     // var items = List<ReadAttendee>();

//     List<ReadAttendee> products = new List<ReadAttendee>();

// // void filterSearchResults(String query) {
// //     List<ReadAttendee> dummySearchList = List<ReadAttendee>();
// //     dummySearchList.addAll(products);
// //     if(query.isNotEmpty) {
// //       List<ReadAttendee> dummyListData = List<ReadAttendee>();
// //       dummySearchList.forEach((item) {
// //         if(item.name.contains(query)) {
// //           dummyListData.add(item);
// //         }
// //       });
// //       setState(() {
// //         items.clear();
// //         items.addAll(dummyListData);
// //       });
// //       return;
// //     } else {
// //       setState(() {
// //         items.clear();
// //         items.addAll(products);
// //       });
// //     }

// //   }


//   @override
//   Widget build(BuildContext context) {
// //      var details = {
// //     '"event"': "WomenTechies"
// // }; 
// Map<String, dynamic> body = {
//     "event": "WomenTechies"
// }; 
// TextEditingController editingController = TextEditingController();

//      String eve=events.name.toString();
//    body["event"] = '$eve';   
//    print(body);

//     Future fetchPosts(http.Client client) async {
//  var response=await http.post(URL_ALLPARTICIPANTS, body: json.encode(body));
 
//  final data = json.decode(response.body);
//  if(data["error"]==null)
//  {
//       print(data['rs'][0]);
      
//     for (int i = 0; i < data['rs'].length; i++) {
//       products.add(new ReadAttendee.fromJson(data['rs'][i]));
//       print(data['rs'][i]);
//     }
//     print(products[0].name);
   
//     return products;
//   } 
//   else{
//     return "No Data to be Fetched";
//   }
//     }
    
    
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Read',
//          textAlign: TextAlign.center,
//         ),
//         centerTitle: true,
//         elevation: 0.0,
      
        
//       ),
//       body:Container(
//       child: FutureBuilder(
//         future: fetchPosts(http.Client()),
//         builder: (BuildContext context,AsyncSnapshot snapshot){
//           if(snapshot.data==null){
//             return Container(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );

//           }
//           else{
            
//             if(snapshot.data!="No Data to be Fetched")
//             {
             
//             return Container(
//               child:Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
                
     
//     //          Flexible(child:Padding(
//     //           padding: const EdgeInsets.all(16.0),
//     //           child: TextField(
//     //             onChanged: (value) {
//     //                setState(() {
//     //   if(items.length!=snapshot.data.length){
//     //   items=products;
//     //   filterSearchResults(value);
//     //   } 
//     // });
//     //             },
//     //             controller: editingController,
//     //             decoration: InputDecoration(
//     //                 labelText: "Search",
//     //                 hintText: "Search",
//     //                 prefixIcon: Icon(Icons.search),
//     //                 border: OutlineInputBorder(
//     //                     borderRadius: BorderRadius.all(Radius.circular(16.0)))),
//     //           ),
//     //         ),flex: 3,),
//              Flexible(child: Container(
//               padding: EdgeInsets.only(top: 16,left:20),
//               child: Row(
//                 children: <Widget>[
//                   Flexible(child:Text(
//                     "Participants",
//                     style: TextStyle(
//                         fontSize: 15.0,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.grey),
//                   ),flex: 15,),
                  
//                 ],
//               )),flex: 1),
//                 Flexible(child:
//                 Container(
//                   padding: EdgeInsets.only(top: 8),
//                   child:
//                 ListView.builder(
//               itemCount: snapshot.data.length,
//                padding: const EdgeInsets.only(bottom: 16,left: 16,right: 16),
//               itemBuilder: (BuildContext context,int index){
//                 return  AttendeeCard(snapshot.data[index],index,events);
                
//               },
//             )),flex: 8)

//               ],));
//             }
//             else{
//               return Center(child:Container(
//                 child: Text(snapshot.data),
//               ),);
//             }
              
//           }
//         },
//       ),
//     )
      
//     );
//   }
//   }