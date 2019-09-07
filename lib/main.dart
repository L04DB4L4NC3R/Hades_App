import 'package:flutter/material.dart';
import 'package:hade/screens/homePage.dart';

import 'package:hade/screens/splashScreen.dart';
import 'package:hade/theme.dart';
import 'dart:async';
import 'package:hade/screens/getOrganizationPage.dart';
import 'package:hade/screens/login.dart';


main()=>runApp(MyApp());





class MyApp extends StatelessWidget {

  
  
  @override
  Widget build(BuildContext context) {
   final ThemeBloc themeBloc = ThemeBloc();
    return StreamBuilder<ThemeData>(
      initialData: themeBloc.initialTheme().data,
      stream: themeBloc.themeDataStream,
      builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hades',
          theme: snapshot.data,
          home: SplashScreen(
            themeBloc: themeBloc,
          ),
          routes: <String, WidgetBuilder> {
    '/homepage': (BuildContext context) => HomePage(
            themeBloc: themeBloc,),
            '/getOrg':(BuildContext context)=>GetOrganizationPage(),
            '/login':(BuildContext context)=>LoginScreen(),


          },
        );
      },
    );
    
  }
}





  







