import 'package:advance_login_mock/core/common/widgets/animation_loader.dart';
import 'package:advance_login_mock/core/common/widgets/rounded_button.dart';
import 'package:advance_login_mock/core/extensions/context_extensions.dart';
import 'package:advance_login_mock/core/res/fonts.dart';
import 'package:advance_login_mock/core/res/media_res.dart';
import 'package:advance_login_mock/core/utils/core_utils.dart';
import 'package:advance_login_mock/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:advance_login_mock/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:advance_login_mock/features/auth/presentation/widgets/sign_up_form.dart';
import 'package:advance_login_mock/features/home/presentation/pages/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const routeName = "/sign-up";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is SignedUp) {
            context.read<AuthBloc>().add(
                  SignInEvent(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  ),
                );
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
                  SizedBox(height: context.height * 0.105),
                  const Text(
                    textAlign: TextAlign.center,
                    'Create account',
                    style: TextStyle(
                      fontFamily: Fonts.aeonik,
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: context.height * 0.025),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: context.height * 0.40,
                      width: double.maxFinite,
                      child: SignUpForm(
                        emailController: emailController,
                        fullNameController: fullNameController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                        formKey: formKey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Create",
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
                              context.read<AuthBloc>().add(
                                    SignUpEvent(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      name: fullNameController.text.trim(),
                                    ),
                                  );
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
                              "Already have an account? ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    SignInScreen.routeName, (route) => false);
                              },
                              child: const Text(
                                "Sign In.",
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
                        child: SvgPicture.asset(MediaRes.linearThree),
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
