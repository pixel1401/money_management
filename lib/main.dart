import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/features/presentation/bloc/user/user_cubit.dart';
import 'package:money_management/features/presentation/pages/AddTrans/addTrans.dart';
import 'package:money_management/features/presentation/pages/Auth/auth.dart';
import 'package:money_management/features/presentation/pages/Welcome/welcome.dart';
import 'package:money_management/features/presentation/pages/wrapper.dart';
import 'package:money_management/injection_container.dart' as di;
import 'package:money_management/injection_container.dart';
import 'package:money_management/routing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (BuildContext context) => sl<UserCubit>()..getUserData(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Money Management',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: const WelcomePage(),
      ),
    );
  }
}






// keytool -genkey -v -keystore C:\Users\User\mykey.jks ^
//         -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 ^
//         -alias androiddebugkey


//  .\keytool.exe  -genkey -v -keystore C:\Users\User\mykey.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000  -alias androiddebugkey