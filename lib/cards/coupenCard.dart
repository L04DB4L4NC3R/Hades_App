import 'package:flutter/material.dart';
import 'package:hade/models/readApi.dart';
import 'package:hade/screens/eventPage.dart';
import 'package:hade/models/read_coupon.dart';
import 'package:hade/screens/coupens/qrScanner.dart';
import 'package:hade/screens/attendeScreens/editAttendeePage.dart';

class CouponCard extends StatefulWidget {
  String name;
  String day;
  String des;
  ReadCoupon coupon;
  int pos;
  RS events;

  CouponCard(this.coupon,this.pos,this.events);

  @override
  State<StatefulWidget> createState() {
    return CouponCardState(coupon,pos,events);
  }
}

class CouponCardState extends State<CouponCard> {
  String name;
  String clubname;
  ReadCoupon coupon;
  int pos;
  RS events;

  CouponCardState(this.coupon,this.pos,this.events);

  Widget get babyCard {
    return
    GestureDetector( 
     
      child:new Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Container(
              
                child:Text("Day: "+coupon.day.toString(),style: TextStyle(fontSize:16 ,color: Colors.blue),textAlign: TextAlign.center,) ,)
              ,
              title: Text(coupon.name),
              subtitle: Container(
                
                child:
                Row(
                  children: <Widget>[
                      Text(coupon.description)
                  ],
                )
                 
              ),
              
              onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>ScanScreen(coupon,pos,events),
          ),
        );
      },
              
            ),
            
          ]
        )
      ));
           
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
          child:  babyCard,
        );
  }
}