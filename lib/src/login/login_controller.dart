import 'package:flutter/material.dart';

class LoginController {
  BuildContext? context;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future? init(BuildContext context) {
    // ignore: unnecessary_this
    this.context = context;
    //_authProvider = new AuthProvider();
  }

  void login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('Email: $email');
    print('Password: $password');
/*
    try {
      bool isLogin = await _authProvider!.login(email, password);

      if (isLogin) {
        print('El usuario esta logeado');
      } else {
        print('El usuario no se pudo autenticar');
      }
    } catch (error) {
      print('Error: $error');
    }*/
  }
}
