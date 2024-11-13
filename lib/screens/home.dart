import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? _email; // To store email data if available

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // Check login status when the widget is initialized
  }

  // Method to check if login data is available
  Future<void> _checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');


      setState(() {
        _email = email;
      });
    // }
  }

  // Method to log out
  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear login data

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage(title: 'Login')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: primaryColor, // Use primary color for the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: _email != null
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome, $_email!',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  foregroundColor: buttonTextColor, // Set text color to buttonTextColor
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.all(16.0),
                ),
                child: const Text('Logout', style: TextStyle(fontSize: 18)),
              ),
            ],
          )
              : const CircularProgressIndicator(), // Loading indicator while checking login status
        ),
      ),
    );
  }
}
