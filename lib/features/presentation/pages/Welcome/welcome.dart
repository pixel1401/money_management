import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:money_management/core/helpers/helpers.dart';
import 'package:money_management/features/presentation/shared/ui/Button/button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState(); 
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: HexColor('#EA1E77'),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                child: Lottie.asset('assets/lottie/welcome.json'),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                width: double.infinity,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Simple solution for your budget.',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w700),
                        
                      ),
                      SizedBox(height: 15,),
                      Text(
                        'Counter and distribute the income correctly...',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 30,),
                      Align(
                        alignment: Alignment.center,
                        child: Button(
                          onPress: () async {
                              context.go('/');
                          },
                          text: 'Continue',
                          styleBtn: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15)
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
