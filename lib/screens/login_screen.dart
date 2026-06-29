import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() async {
    final auth = Get.find<AuthController>();
    await auth.login(
      _emailController.text.trim(),
      _passwordController.text,
    );
    if (auth.isLoggedIn.value) {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text('LawyerSpot',
                        style: AppText.displayLg.copyWith(fontSize: 24)),
                  ),
                  const SizedBox(height: 40),
                  Text('Welcome Back',
                      style: AppText.displayLg, textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to manage your practice.',
                    style: AppText.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  SoftCard(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const CapsLabel('Email address'),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'name@lawfirm.com',
                          ),
                        ),
                        const SizedBox(height: 16),
                        const CapsLabel('Password'),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscure,
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            suffixIcon: IconButton(
                              icon: Icon(_obscure
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              onPressed: () => setState(() => _obscure = !_obscure),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Obx(() {
                          if (auth.errorMessage.value != null) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Text(
                                auth.errorMessage.value!,
                                style: AppText.bodySm.copyWith(color: AppColors.error),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }),
                        Obx(() => GoldButton(
                          label: auth.isLoading.value ? 'Signing in...' : 'Sign In',
                          onPressed: auth.isLoading.value ? null : _signIn,
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Text("Don't have an account? ",
                            style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed('/signup'),
                          child: Text('Sign Up',
                              style: AppText.bodySm.copyWith(
                                  color: AppColors.navy, fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
