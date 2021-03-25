import 'package:flutter/material.dart';
import 'package:images_app/src/bloc/provider.dart';
import 'package:images_app/src/pages/home_page.dart';
import 'package:images_app/src/pages/login_page.dart';
import 'package:images_app/src/pages/product_page.dart';
import 'package:images_app/src/pages/register_page.dart';
import 'package:images_app/src/preferences/user_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final prefs = new UserPreferences();
    print(prefs.token);
    
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login': (context) => LoginPage(),
          'home': (context) => HomePage(),
          'product': (context) => ProductPage(),
          'signup': (context) => RegisterPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      )
    );
    
  }
}