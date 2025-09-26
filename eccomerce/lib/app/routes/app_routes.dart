import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/auth_screen.dart';
import '../../features/auth/presentation/pages/home_screen.dart';

class AppRoutes {
  static const String auth = '/auth';
  static const String home = '/home';

  static Map<String, WidgetBuilder> get routes => {
        auth: (context) => const AuthScreen(),
        home: (context) => const HomeScreen(),
      };
}