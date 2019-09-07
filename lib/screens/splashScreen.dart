import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hade/screens/homePage.dart';
import 'package:hade/theme.dart';
import 'package:hade/userDataMangment.dart';

class SplashScreen extends StatefulWidget {

  final ThemeBloc themeBloc;

  SplashScreen({Key key, this.themeBloc}) : super(key: key);
 @override
  State<StatefulWidget> createState() {
    return _SplashScreenState(themeBloc: themeBloc,);
  }
}
class _SplashScreenState extends State<SplashScreen> {

   final ThemeBloc themeBloc;

  _SplashScreenState({Key key, this.themeBloc});
  @override
  void initState() {
    checktext();
    // TODO: implement initState
    super.initState();
 go();

  }
    void go() {

      Future.delayed(const Duration(seconds: 3), () {
       
          if (set.compareTo(true.toString()) == 0) {
            new Future.delayed(
                const Duration(seconds: 0),

                    () =>
              Navigator.of(context).pushReplacementNamed('/getOrg')
            );
          }
          else if (set.compareTo(false.toString()) == 0) {
            print(set);
            new Future.delayed(
                const Duration(seconds: 0),

                   () => Navigator.of(context).pushReplacementNamed('/login')
            );
          }
          else {
            new Future.delayed(
                const Duration(seconds: 0),

                    () => Navigator.of(context).pushReplacementNamed('/login')

            );
          }
        
      });


  }

SharedPreferencesTest s=new SharedPreferencesTest();
  String set="yo";
  Future<bool> check;
   String checktext() {

     check = s.getLoginCheck();
     check.then((resultString) {
       setState(() {
         print("wsl;rgtyui");

         set = resultString.toString();
         print(set);
       });
     });

   }


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                       Image.asset('images/dscnew.webp',
              width: 90.0, height: 90.0, fit: BoxFit.cover),
        
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Text(
                        "Developer Student Clubs",
                        style: TextStyle(
                            //color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 21.0),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "Loading...",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                         // color: Colors.white),
                    )
                    )],
                ),
              )
            ],
          )
        ],
      ),
    );
    
  }
}