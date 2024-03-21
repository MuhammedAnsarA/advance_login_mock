import 'package:advance_login_mock/core/common/widgets/i_field.dart';
import 'package:advance_login_mock/core/res/colours.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          IField(
            controller: widget.emailController,
            hintText: 'Email Address',
            keyboardType: TextInputType.emailAddress,
            inputAction: TextInputAction.next,
            prefixIcon: const Icon(
              Icons.email,
              color: Colours.neutralTextColour,
              size: 21,
            ),
          ),
          const SizedBox(height: 35),
          IField(
            controller: widget.passwordController,
            hintText: 'Password',
            obscureText: obscurePassword,
            inputAction: TextInputAction.done,
            keyboardType: TextInputType.visiblePassword,
            prefixIcon: const Icon(
              IconlyBold.lock,
              color: Colours.neutralTextColour,
              size: 22,
            ),
            suffixIcon: IconButton(
              onPressed: () => setState(() {
                obscurePassword = !obscurePassword;
              }),
              icon: Icon(
                obscurePassword ? IconlyLight.hide : IconlyLight.show,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
