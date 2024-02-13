import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_management/features/presentation/shared/ui/Button/button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {


  Future<void> signIn () async {
    GoogleSignIn(
      clientId: '484095062673-bubg4k1m93h9n0va5q3299rd0ol33kto.apps.googleusercontent.com'
    ).signIn();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Text("Google"),
            Button(onPress: () {
              signIn();
            },
            text: 'Sign in Google',)
          ],
        ),
      ),
    );
  }
}