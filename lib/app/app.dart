import 'package:banking_app/blocs/auth/auth_bloc.dart';
import 'package:banking_app/blocs/user_profile/user_profile_bloc.dart';
import 'package:banking_app/data/repositories/user_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../data/repositories/auth_repository.dart';
import '../screens/routes.dart';
import '../services/local_notification_service.dart';

class App extends StatelessWidget {
  App({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    LocalNotificationService.localNotificationService.init(navigatorKey);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => UserProfileRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
            AuthBloc(authRepository: context.read<AuthRepository>())
              ..add(
                CheckAuthenticationEvent(),
              ),
          ),
          BlocProvider(
              create: (context) =>
                  UserBloc(userProfileRepository: context.read<UserProfileRepository>())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RouteNames.splashScreen,
          navigatorKey: navigatorKey,
          onGenerateRoute: AppRoutes.generateRoute,
        ),
      ),
    );
  }
}