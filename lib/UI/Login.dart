import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _passwordVisibility = false;

  void loginSubmit() {
    var username = usernameController.text;
    var password = passwordController.text;
    // TODO login submission
  }

  void togglePasswordVisibility() {
    setState(() {
      _passwordVisibility = !_passwordVisibility;
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: .directional(start: 16, end: 16),
        child: Column(
          mainAxisAlignment: .center,
          spacing: 16,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Username"),
              controller: usernameController,
              // TODO add validator
            ),
            TextFormField(
              // TODO add validator
              obscureText: _passwordVisibility,
              decoration: InputDecoration(
                labelText: "Password",
                suffixIcon: IconButton(
                  onPressed: togglePasswordVisibility,
                  icon: Icon(
                    _passwordVisibility
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
              controller: passwordController,
            ),
            ElevatedButton(onPressed: loginSubmit, child: Text("Login")),
          ],
        ),
      ),
    );
  }
}
