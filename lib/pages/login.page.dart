import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signup.page.dart';
import 'tictactoe.page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLogin = prefs.getString('login');
    final savedPassword = prefs.getString('password');

    final inputLogin = _loginController.text;
    final inputPassword = _passwordController.text;

    if (inputLogin == savedLogin && inputPassword == savedPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TicTacToePage(login: inputLogin),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Identifiants incorrects')));
    }
  }

  void _goToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connexion')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _loginController,
              decoration: InputDecoration(labelText: 'Nom d\'utilisateur'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: Text('Se connecter')),
            TextButton(onPressed: _goToSignUp, child: Text('Créer un compte')),
          ],
        ),
      ),
    );
  }
}
