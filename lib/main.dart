import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:money_management/config/theme/theme.dart';
import 'package:money_management/features/presentation/bloc/sheet/sheet_cubit.dart';
import 'package:money_management/features/presentation/bloc/user/user_cubit.dart';
import 'package:money_management/features/presentation/bloc/user/user_state.dart';
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
        BlocProvider(
          create: (BuildContext context) => sl<SheetCubit>(),
        ),
      ],
      child: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is Authorized) {
            final AuthClient? authClient = state.authClient;
            if (authClient != null) {
              BlocProvider.of<SheetCubit>(context).initSheet(authClient);
            }
          }
        },
        child: MaterialApp.router(
          routerConfig: router,
          title: 'Money Management',
          debugShowCheckedModeBanner: false,
          theme: theme(),
          // home: const WelcomePage(),
        ),
      ),
    );
  }
}






// keytool -genkey -v -keystore C:\Users\User\mykey.jks ^
//         -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 ^
//         -alias androiddebugkey


//  .\keytool.exe  -genkey -v -keystore C:\Users\User\mykey.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000  -alias androiddebugkeyё