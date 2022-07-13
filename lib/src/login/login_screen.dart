import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:login_firebase_auth/src/home/home_screen.dart';
import 'package:login_firebase_auth/src/login/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State {
  LoginController _con = new LoginController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('INIT STATE');

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  //login function
  static Future loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseException catch (e) {
      if (e.code == 'Usuario no encontrado') {
        print('No se encontro ningunusuario para ese correo');
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    _con.init(context);
    //Creating the textfield controller

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 44.0,
            ),
            _bannerApp(context),
            const SizedBox(
              height: 44.0,
            ),
            _textFieldEmail(),
            const SizedBox(
              height: 44.0,
            ),
            _textFieldPassword(),
            const SizedBox(
              height: 12.0,
            ),
            _textDontHaveAccount(),
            const SizedBox(
              height: 88.0,
            ),
            _buttonLogin(),
          ],
        ),
      ),
    );
  }

  Widget _bannerApp(BuildContext context) {
    return ClipPath(
      clipper: WaveClipperOne(),
      child: Container(
        color: Color.fromARGB(255, 126, 52, 52),
        height: MediaQuery.of(context).size.height * 0.30,
        child: Row(
          //esto es una lista recoradndo que abjo puedo cambiar a child para un solo elemento
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            Image.asset(
              'assets/img/logo_app.png',
              width: 150,
              height: 100,
            ),
            Text(
              'elvis.com',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textFieldEmail() {
    // para introducir e-mail ojo
    return TextField(
      controller: _con.emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          hintText: "Email",
          prefixIcon: Icon(
            Icons.email,
            color: Colors.black45,
          )),
    );
  }

  Widget _textFieldPassword() {
    // para introducir e-mail ojo
    return Container(
      margin: const EdgeInsets.only(bottom: 70),
      child: TextField(
        controller: _con.passwordController,
        obscureText: true,
        decoration: const InputDecoration(
            hintText: "Password",
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.black45,
            )),
      ),
    );
  }

  Widget _textDontHaveAccount() {
    return GestureDetector(
      //onTap: _goToRegisterPage,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: const Text(
          "He olvidado mi contraseña",
          style: TextStyle(color: Color.fromARGB(255, 79, 95, 117)),
        ),
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      child: RawMaterialButton(
        fillColor: Color.fromARGB(255, 79, 95, 117),
        elevation: 0.0,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        onPressed: () async {
          //Let's test the app
          User? user = await loginUsingEmailPassword(
              email: _con.emailController.text.trim(),
              password: _con.passwordController.text.trim(),
              context: context);
          if (user != null) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen()));
          }
        },
        child: const Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
