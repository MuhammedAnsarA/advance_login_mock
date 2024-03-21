part of 'router.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      final prefs = sl<SharedPreferences>();
      return _pageBuilder(
        (context) {
          if (prefs.getBool(kFirstTimerKey) ?? true) {
            return const OnboardingScreen();
          } else if (sl<FirebaseAuth>().currentUser != null) {
            return const HomeScreen();
          }
          return const SignInScreen();
        },
        settings: settings,
      );
    case SignInScreen.routeName:
      return _pageBuilder(
        (_) => const SignInScreen(),
        settings: settings,
      );

    case SignUpScreen.routeName:
      return _pageBuilder(
        (_) => const SignUpScreen(),
        settings: settings,
      );
    case HomeScreen.routeName:
      return _pageBuilder(
        (_) => const HomeScreen(),
        settings: settings,
      );
    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}
