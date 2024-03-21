import 'package:advance_login_mock/core/common/widgets/i_field.dart';
import 'package:advance_login_mock/core/res/colours.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    required this.fullNameController,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController fullNameController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          IField(
            controller: widget.fullNameController,
            hintText: 'Full Name',
            keyboardType: TextInputType.name,
            inputAction: TextInputAction.next,
            prefixIcon: const Icon(
              IconlyBold.profile,
              color: Colours.neutralTextColour,
              size: 22,
            ),
          ),
          const SizedBox(height: 25),
          IField(
            controller: widget.emailController,
            hintText: 'Email address',
            keyboardType: TextInputType.emailAddress,
            inputAction: TextInputAction.next,
            prefixIcon: const Icon(
              Icons.email,
              color: Colours.neutralTextColour,
              size: 21,
            ),
          ),
          const SizedBox(height: 25),
          IField(
            controller: widget.passwordController,
            hintText: 'Password',
            obscureText: obscurePassword,
            keyboardType: TextInputType.visiblePassword,
            inputAction: TextInputAction.next,
            prefixIcon: const Icon(
              IconlyBold.lock,
              size: 22,
              color: Colours.neutralTextColour,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
              icon: Icon(
                obscurePassword ? IconlyLight.hide : IconlyLight.show,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 25),
          IField(
            controller: widget.confirmPasswordController,
            hintText: 'Confirm Password',
            obscureText: obscureConfirmPassword,
            keyboardType: TextInputType.visiblePassword,
            inputAction: TextInputAction.done,
            prefixIcon: const Icon(
              IconlyBold.lock,
              size: 22,
              color: Colours.neutralTextColour,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureConfirmPassword = !obscureConfirmPassword;
                });
              },
              icon: Icon(
                obscureConfirmPassword ? IconlyLight.hide : IconlyLight.show,
                color: Colors.grey,
              ),
            ),
            overrideValidator: true,
            validator: (value) {
              if (value != widget.passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
