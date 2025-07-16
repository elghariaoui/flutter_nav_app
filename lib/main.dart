import 'package:flutter/material.dart';
import 'package:flutter_nav_app/pages/login.page.dart';
import 'package:flutter_nav_app/pages/tictactoe.page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<Widget> _getInitialScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLogin = prefs.getString('login');
    final savedPassword = prefs.getString('password');

    if (savedLogin != null && savedPassword != null) {
      return TicTacToePage(login: savedLogin); // auto-login
    } else {
      return LoginPage(); // default screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder<Widget>(
        future: _getInitialScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data!;
          } else {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}
