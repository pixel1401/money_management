import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_management/features/presentation/shared/ui/Button/button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Future<void> signIn() async {
  }

  Future<void> signOut() async {
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Text("Google"),
            Button(
              onPress: () async {
                signIn();
              },
              text: 'Sign in Google',
            ),
            Button(
              onPress: () async {
                signOut();
              },
              text: 'Sign out',
            )
          ],
        ),
      ),
    );
  }
}
