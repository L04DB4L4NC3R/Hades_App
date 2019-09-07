import 'package:flutter/material.dart';
import 'package:hade/models/readApi.dart';
import 'package:http/http.dart' as http;
import 'package:hade/models/global.dart';
import 'package:hade/models/read_attendee.dart';
import 'package:hade/cards/attendeeCard.dart';
import 'package:hade/models/read_coupon.dart';
import 'package:hade/cards/coupenCard.dart';
import 'dart:async';
import 'dart:convert';
import 'package:hade/screens/coupens/qrScanner.dart';
class ReadCouponPage extends StatefulWidget{

  RS events;
  int pos;
  ReadCouponPage(this.events,this.pos);
  @override
  @override
  State<StatefulWidget> createState() {
    return _ReadCouponPage(events,pos);
  }
}



  
  class _ReadCouponPage extends State<ReadCouponPage>{

    

     

    
 

    RS events;
    int pos;

    _ReadCouponPage(this.events,this.pos);
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
  var response=await http.post(URL_VIEWCOUPON, body: json.encode(body));
 
  final data = json.decode(response.body);
  print(data);
  if(data["error"]==null && data["rs"]!= null)
  {
       print(data['rs'][0]);
       List<ReadCoupon> products = new List<ReadCoupon>();
     for (int i = 0; i < data['rs'].length; i++) {
       products.add(new ReadCoupon.fromJson(data['rs'][i]));
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
          'Redeem',
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
                    "View",
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
                return  CouponCard(snapshot.data[index],index,events);

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
    ));
      
    //);
  }
  }