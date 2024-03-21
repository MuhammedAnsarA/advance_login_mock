import 'package:advance_login_mock/core/common/widgets/animation_loader.dart';
import 'package:advance_login_mock/core/res/colours.dart';
import 'package:advance_login_mock/core/res/media_res.dart';
import 'package:advance_login_mock/features/onboarding/domain/entities/page_content.dart';
import 'package:advance_login_mock/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:advance_login_mock/features/onboarding/presentation/widgets/onboarding_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const routeName = "/";

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageController = PageController();
  @override
  void initState() {
    super.initState();
    context.read<OnboardingCubit>().checkIfUserIsFirstTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is UserCashed) {
            Navigator.pushReplacementNamed(context, "/");
          }
        },
        builder: (context, state) {
          if (state is CheckingIfUserIsFirstTimer ||
              state is CachingFirstTimer) {
            return const TAnimationLoaderWidget(
                text: "We are checking your information...",
                animation: MediaRes.docerAnimation);
          }
          return Stack(
            children: [
              PageView(
                controller: pageController,
                children: const [
                  OnboardingBody(pageContent: PageContent.first()),
                  OnboardingBody(pageContent: PageContent.second()),
                  OnboardingBody(pageContent: PageContent.third()),
                ],
              ),
              Align(
                alignment: const Alignment(0, .04),
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  onDotClicked: (index) {
                    pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  effect: const WormEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 40,
                    activeDotColor: Colours.primaryColour,
                    dotColor: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
