part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initOnBoarding();
  await _initAuth();
  await _initUser();
}

Future<void> _initOnBoarding() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerFactory(() => OnboardingCubit(sl(), sl()));
  sl.registerLazySingleton(() => CacheFirstTimerUsecase(sl()));
  sl.registerLazySingleton(() => CheckIfUserIsFirstTimerUsecase(sl()));
  sl.registerLazySingleton<OnboardingRepo>(() => OnboardingRepoImpl(sl()));
  sl.registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSourceImpl(sl()));
  sl.registerLazySingleton(() => prefs);
}

Future<void> _initAuth() async {
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => SignInUserUsecase(sl()));
  sl.registerLazySingleton(() => SignUpUserUsecase(sl()));
  sl.registerLazySingleton(() => SignOutUsecase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUsecase(sl()));
  sl.registerLazySingleton(() => UpdateUserUsecase(sl()));
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(() =>
      AuthRemoteDataSourceImpl(auth: sl(), firestore: sl(), storage: sl()));
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
}

Future<void> _initUser() async {
  sl.registerFactory(
      () => UserCubit(getSingleUserUsecase: sl(), getAllUsersUsecase: sl()));
  sl.registerLazySingleton(() => GetSingleUserUsecase(sl()));
  sl.registerLazySingleton(() => GetAllUsersUsecase(sl()));
  sl.registerLazySingleton<UserRepo>(() => UserRepoImpl(sl()));
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(auth: sl(), firestore: sl()));
}
