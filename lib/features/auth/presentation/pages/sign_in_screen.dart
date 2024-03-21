import 'package:advance_login_mock/core/common/widgets/animation_loader.dart';
import 'package:advance_login_mock/core/common/widgets/rounded_button.dart';
import 'package:advance_login_mock/core/extensions/context_extensions.dart';
import 'package:advance_login_mock/core/res/fonts.dart';
import 'package:advance_login_mock/core/res/media_res.dart';
import 'package:advance_login_mock/core/utils/core_utils.dart';
import 'package:advance_login_mock/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:advance_login_mock/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:advance_login_mock/features/auth/presentation/widgets/sign_in_form.dart';
import 'package:advance_login_mock/features/home/presentation/pages/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const routeName = "/sign-in";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is SignedIn) {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const TAnimationLoaderWidget(
                text: "We are uploading your information...",
                animation: MediaRes.docerAnimation);
          }
          return Stack(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(height: context.height * 0.10),
                  const Text(
                    textAlign: TextAlign.center,
                    'Hello',
                    style: TextStyle(
                      fontFamily: Fonts.aeonik,
                      fontWeight: FontWeight.w700,
                      fontSize: 70,
                    ),
                  ),
                  SizedBox(height: context.height * 0.013),
                  const Text(
                    textAlign: TextAlign.center,
                    'Sign in to your account',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: context.height * 0.05),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: context.height * 0.27,
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          SignInForm(
                            emailController: emailController,
                            passwordController: passwordController,
                            formKey: formKey,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/forgot-password');
                              },
                              child: const Text(
                                'Forgot your password?',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 15),
                        RoundedButton(
                          icon: Icons.arrow_forward,
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            FirebaseAuth.instance.currentUser?.reload();
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(SignInEvent(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      SizedBox(
                        height: context.height * 0.32,
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    SignUpScreen.routeName, (route) => false);
                              },
                              child: const Text(
                                "Create.",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 0.0,
                        bottom: 0.0,
                        child: SvgPicture.asset(MediaRes.linearTwo),
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: const Alignment(-1, -1),
                child: SvgPicture.asset(MediaRes.linear),
              ),
            ],
          );
        },
      ),
    );
  }
}
