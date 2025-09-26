import 'package:eccomerce/core/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/auth/presentation/providers/auth_provider.dart';
import 'routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Sistema de Autenticación',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.auth,
        routes: AppRoutes.routes,
      ),
    );
  }
}