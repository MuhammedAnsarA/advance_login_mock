import 'package:advance_login_mock/core/common/widgets/animation_loader.dart';
import 'package:advance_login_mock/core/res/media_res.dart';
import 'package:advance_login_mock/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:advance_login_mock/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:advance_login_mock/features/home/presentation/widgets/home_appbar.dart';
import 'package:advance_login_mock/features/user/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = "/home-screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getSingleUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is SingleUserLoaded) {
          final currentUser = state.user;
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: HomeAppBar(currentUser: currentUser),
            body: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      context.read<AuthBloc>().add(const SignOutEvent());
                      await Navigator.pushNamedAndRemoveUntil(
                          context, SignInScreen.routeName, (route) => false);
                    },
                    child: const Text("Sign Out"),
                  ),
                );
              },
            ),
          );
        }
        return const TAnimationLoaderWidget(
            text: "We are processing your information...",
            animation: MediaRes.docerAnimation);
      },
    );
  }
}
