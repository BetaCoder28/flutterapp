import 'package:eccomerce/features/auth/presentation/widgets/auth_switch_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/auth_provider.dart';
import '../widgets/login_form.dart';
import '../widgets/register_form.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/themes/app_themes.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isLogin = true;

  void _switchAuthMode() {
    setState(() {
      _isLogin = !_isLogin;
      _formKey.currentState?.reset();
    });
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      if (_isLogin) {
        await authProvider.login(
          _emailController.text,
          _passwordController.text,
        );
      } else {
        await authProvider.register(
          name: _nameController.text,
          lastname: _lastNameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          password: _passwordController.text,
        );
      }

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar(e.toString(), isError: true);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Header con logo y título
                    _buildHeader(),

                    // Card principal con el formulario
                    _buildMainCard(authProvider),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: Column(
        children: [
          // Logo o ícono
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.shopping_bag_outlined,
              size: 40,
              color: Colors.white,
            ),
          ).animate().scale(duration: 600.ms).fadeIn(),

          const SizedBox(height: 20),

          // Título principal
          Text(
                'E-Commerce',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              )
              .animate(delay: 200.ms)
              .slideY(begin: 0.3, duration: 600.ms)
              .fadeIn(),

          const SizedBox(height: 8),

          // Subtítulo
          Text(
                'Tu tienda digital de confianza',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                ),
              )
              .animate(delay: 400.ms)
              .slideY(begin: 0.3, duration: 600.ms)
              .fadeIn(),
        ],
      ),
    );
  }

  Widget _buildMainCard(AuthProvider authProvider) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Título del formulario
            Text(
                  _isLogin ? 'Iniciar Sesión' : 'Crear Cuenta',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                )
                .animate(delay: 600.ms)
                .slideY(begin: 0.3, duration: 600.ms)
                .fadeIn(),

            const SizedBox(height: 8),

            Text(
                  _isLogin
                      ? 'Bienvenido de vuelta'
                      : 'Únete a nuestra comunidad',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
                  textAlign: TextAlign.center,
                )
                .animate(delay: 800.ms)
                .slideY(begin: 0.3, duration: 600.ms)
                .fadeIn(),

            const SizedBox(height: 30),

            // Formulario
            _buildForm(authProvider)
                .animate(delay: 1000.ms)
                .slideY(begin: 0.3, duration: 600.ms)
                .fadeIn(),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(AuthProvider authProvider) {
    return Column(
      children: [
        if (!_isLogin)
          RegisterForm(
            nameController: _nameController,
            lastNameController: _lastNameController,
            phoneController: _phoneController,
            emailController: _emailController,
            passwordController: _passwordController,
            confirmPasswordController: _confirmPasswordController,
          )
        else
          LoginForm(
            emailController: _emailController,
            passwordController: _passwordController,
          ),

        const SizedBox(height: 30),

        // Botón principal
        Container(
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: authProvider.isLoading ? null : _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: authProvider.isLoading
                ? const LoadingIndicator()
                : Text(
                    _isLogin ? 'Iniciar Sesión' : 'Crear Cuenta',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
          ),
        ),

        const SizedBox(height: 20),

        // Botón de cambio de modo
        AuthSwitchButton(
          isLogin: _isLogin,
          onPressed: authProvider.isLoading ? null : _switchAuthMode,
        ),
      ],
    );
  }
}
