import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssignup_login/screens/signup.dart';
import 'package:ssignup_login/screens/home.dart';

import '../constants/colors.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers to access the form fields if needed
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Function to save email and password
  Future<void> _saveCredentials(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: primaryColor, // Set the app bar color to primary color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey, // Key to manage form validation
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Email field with standard styles
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: accentColor),
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.email, color: primaryColor),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password field with standard styles
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: accentColor),
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock, color: primaryColor),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // "Create Account" button with navigation to SignUpPage
                TextButton(
                  onPressed: () {
                    // Navigate to SignUpPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpPage(title: 'Sign Up')),
                    );
                  },
                  child: const Text("Create Account"),
                  style: TextButton.styleFrom(foregroundColor: primaryColor), // Primary color for the link
                ),

                // Login Button with standard style
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, store credentials and show a success message
                      await _saveCredentials(
                        _emailController.text,
                        _passwordController.text,
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Home(title: 'Home Page')),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logging in...', style: TextStyle(color: buttonTextColor))),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: buttonTextColor, backgroundColor: primaryColor, // Set the text color to buttonTextColor
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text('Login', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
