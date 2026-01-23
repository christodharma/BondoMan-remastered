import 'package:flutter/material.dart';
import 'package:flutter_project_1/data/authorization/repository/auth_repo.dart';
import 'package:flutter_project_1/ui/login/login_viewmodel.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static const routeName = "/login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _passwordVisibility = false;

  static const String usernameFieldLabel = "Username";
  static const String passwordFieldLabel = "Password";
  static const String buttonLabel = "Login";

  void showLoginSnackBar(String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  String? _checkNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return "Please fill this field";
    }
    return null;
  }

  String? _checkIsValidEmail(String? email) {
    if (email == null) return null;
    if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email)) {
      return "Please enter valid email address";
    }
    return null;
  }

  String? _checkIsInjection(String? password) {
    if (password == null) return null;
    if (RegExp(r'^[\x21-\x7E]{8,}$').hasMatch(password)) {
      return "Enter valid password";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          LoginViewModel(context.read<AuthorizationRepository>()),
      child: Scaffold(
        body: Consumer<LoginViewModel>(
          builder:
              (BuildContext context, LoginViewModel value, Widget? child) =>
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: .directional(start: 16, end: 16),
                      child: Column(
                        mainAxisAlignment: .center,
                        spacing: 16,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: usernameFieldLabel,
                            ),
                            controller: usernameController,
                            validator: (value) {
                              var isEmpty = _checkNotEmpty(value);
                              if (isEmpty != null) {
                                return isEmpty;
                              }
                              var isInvalidEmail = _checkIsValidEmail(value);
                              if (isInvalidEmail != null) {
                                return isInvalidEmail;
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            validator: (value) {
                              var isEmpty = _checkNotEmpty(value);
                              if (isEmpty != null) {
                                return isEmpty;
                              }
                              var isInjection = _checkIsInjection(value);
                              if (isInjection != null) {
                                return isInjection;
                              }
                              return null;
                            },
                            obscureText: !_passwordVisibility,
                            decoration: InputDecoration(
                              labelText: passwordFieldLabel,
                              suffixIcon: IconButton(
                                onPressed: togglePasswordVisibility,
                                icon: Icon(
                                  !_passwordVisibility
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                            controller: passwordController,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) return;
                              value.submitLogin(
                                username: usernameController.text,
                                key: passwordController.text,
                              );
                            },
                            child: const Text(buttonLabel),
                          ),
                        ],
                      ),
                    ),
                  ),
        ),
      ),
    );
  }
}
