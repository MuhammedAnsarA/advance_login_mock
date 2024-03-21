import 'dart:async';

import 'package:advance_login_mock/core/di/injection_container.dart';
import 'package:advance_login_mock/core/res/fonts.dart';
import 'package:advance_login_mock/core/router/router.dart';
import 'package:advance_login_mock/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:advance_login_mock/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:advance_login_mock/features/user/presentation/cubit/user_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform, create firebase then uncommand
      );
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<OnboardingCubit>()),
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<UserCubit>()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: Fonts.poppins,
        ),
        onGenerateRoute: generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
