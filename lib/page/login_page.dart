import 'dart:async';
import 'package:flutter/material.dart';
import 'package:note_database/page/Program_home_page.dart';
import 'package:note_database/src/texttovoice.dart';
import 'package:note_database/style/animationAlert.dart';
import 'package:note_database/style/textinput_style.dart';
import 'package:local_auth/local_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final form_key = GlobalKey<FormState>();
  TextEditingController username_text = TextEditingController();
  TextEditingController password_text = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  SpeakText speaktovoice = SpeakText();

  Future<void> authinticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to our application',
        options: const AuthenticationOptions(
            useErrorDialogs: false, biometricOnly: false),
      );
      if (didAuthenticate == true) {
        speaktovoice.speak('Login Succes ');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NotesPage()));
      }
    } catch (e) {
      print(e.toString());
      if (e.toString().contains('notEnrolled') ||
          e.toString().contains('not available')) {
        const AlertAnimate(title: 'title', message: 'message');
        speaktovoice.speak('Security credentials not available');
      } else if (e.toString().contains('lockedOut') ||
          e.toString().contains('permanentlyLockedOut')) {
        // Handle case when the user is locked out of biometrics
      } else {
        AwesomeDialog dialog = AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.scale,
          title: 'credentials check',
          desc: e.toString(),
          autoDismiss: true,
          headerAnimationLoop: true,
          //transitionAnimationDuration: Duration(seconds: 3),
        );
        dialog.show();
        Timer(const Duration(seconds: 5), () {
          setState(() {
            dialog.dismiss();
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const Text('Login'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://e0.pxfuel.com/wallpapers/66/826/desktop-wallpaper-dew-drop-leaves-reflection-green-leaf-beautiful-grass-bubble-dew.jpg'),
              fit: BoxFit.cover),
        ),
        child: Form(
          key: form_key,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                  controller: username_text,
                  decoration: inputtext('USER NAME'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please Enter valid User name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                  controller: password_text,
                  decoration: inputtext('PASSWORD'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please Enter Password can't to be empty ";
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // if (form_key.currentState!.validate()) {
                  //   gotomain;
                  // }
                  print(form_key.currentState!.validate());
                  form_key.currentState!.validate()
                      ? gotomain()
                      : authinticate();
                },
                child: const Text('SIGN IN'),
              ),
              // Image(image: AssetImage("loginbgdrop.png")),
            ]),
          ),
        ),
      ),
    );
  }

  void gotomain() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NotesPage()));
  }
}
