import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:money_management/features/domain/entity/post.dart';
import 'package:money_management/features/presentation/bloc/user/user_cubit.dart';
import 'package:money_management/features/presentation/pages/AddTrans/edit_trans.dart';
import 'package:money_management/features/presentation/pages/Auth/auth.dart';
import 'package:money_management/features/presentation/pages/Home/home.dart';
import 'package:money_management/features/presentation/pages/Transaction/components/transaction_add.dart';
import 'package:money_management/features/presentation/pages/Welcome/welcome.dart';
import 'package:money_management/features/presentation/pages/wrapper.dart';

import 'features/presentation/bloc/user/user_state.dart';
import 'features/presentation/pages/AddTrans/create_trans.dart';
import 'features/presentation/pages/Transaction/transaction.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return Wrapper(child: child);
        },
        routes: [
          // This screen is displayed on the ShellRoute's Navigator.
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey, child: const HomePage()),
          ),
          GoRoute(
            path: '/trans',
            pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey, child: const Transaction()),
          ),
          GoRoute(
            path: '/trans/add',
            pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey, child: const TransactionAdd()),
          ),
        ],
      ),
      GoRoute(
        path: '/transaction/add',
        pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey, child: const CreateTransaction()),
      ),
      GoRoute(
        path: '/transaction/edit',
        pageBuilder: (context, state)  {
          Post post = state.extra as Post;
          return NoTransitionPage<void>(
            key: state.pageKey, child:  EditTransaction(data: post,));},
      ),
      GoRoute(
        path: '/welcome',
        builder: (BuildContext context, GoRouterState state) {
          return const WelcomePage();
        },
      ),
      GoRoute(
        path: '/auth',
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: const AuthPage()),
      ),
    ],
    redirect: (context, state) {
      var userState = context.read<UserCubit>().state;
      if (userState is UnAuthorizedState) {
        return '/welcome';
      }
    });
