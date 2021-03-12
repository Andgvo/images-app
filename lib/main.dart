import 'package:flutter/material.dart';
import 'package:images_app/src/bloc/provider.dart';
import 'package:images_app/src/pages/home_page.dart';
import 'package:images_app/src/pages/login_page.dart';
import 'package:images_app/src/pages/product_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login': (context) => LoginPage(),
          'home': (context) => HomePage(),
          'product': (context) => ProductPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      )
    );
    
  }
}