import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../controllers/auth_controller.dart';

class SignupFlow extends StatefulWidget {
  const SignupFlow({super.key});

  @override
  State<SignupFlow> createState() => _SignupFlowState();
}

class _SignupFlowState extends State<SignupFlow> {
  final _pageController = PageController();
  int _step = 0;
  static const _totalSteps = 4;

  // Step 1
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  // Step 2
  final _practiceController = TextEditingController();
  final _barIdController = TextEditingController();
  String? _citySlug;

  // Step 3
  final Set<String> _specialization = {};
  static const _allSpecializations = [
    'Divorce', 'Family Law', 'Property', 'Corporate',
    'Criminal', 'GST & Tax', 'Immigration', 'Cyber Crime',
    'Intellectual Property', 'Real Estate', 'Banking', 'Insurance',
  ];

  // Step 4
  final _bioController = TextEditingController();
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _practiceController.dispose();
    _barIdController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _goToStep(int step) {
    setState(() => _step = step);
    if (step < _totalSteps) {
      _pageController.animateToPage(step,
          duration: const Duration(milliseconds: 280), curve: Curves.easeOut);
    }
  }

  void _next() {
    if (_step < _totalSteps - 1) {
      _goToStep(_step + 1);
    } else {
      _register();
    }
  }

  void _register() async {
    final auth = Get.find<AuthController>();
    await auth.lawyerSignup(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
      practice: _practiceController.text.trim(),
      barId: _barIdController.text.trim().isEmpty ? null : _barIdController.text.trim(),
      citySlug: _citySlug,
    );
    if (auth.isLoggedIn.value) {
      setState(() => _step = _totalSteps);
    }
  }

  void _back() {
    if (_step == 0) {
      Navigator.of(context).maybePop();
    } else {
      _goToStep(_step - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    if (_step == _totalSteps) {
      return _SuccessScreen(
        onContinue: () =>
            Navigator.of(context).pushNamedAndRemoveUntil('/home', (r) => false),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: _back,
                  ),
                  Expanded(
                    child: Center(
                      child: Text('Sign Up', style: AppText.displayLgMobile.copyWith(fontSize: 22)),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CapsLabel('Step ${_step + 1} of $_totalSteps', color: AppColors.onSurfaceVariant),
                      CapsLabel(_stepTitle(_step), color: AppColors.onSurfaceVariant),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: LinearProgressIndicator(
                      value: (_step + 1) / _totalSteps,
                      minHeight: 4,
                      backgroundColor: AppColors.surfaceContainer,
                      color: AppColors.navyContainer,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _stepWrapper(_buildStep1()),
                  _stepWrapper(_buildStep2()),
                  _stepWrapper(_buildStep3()),
                  _stepWrapper(_buildStep4(auth)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Obx(() => GoldButton(
                label: auth.isLoading.value
                    ? 'Creating account...'
                    : _step == _totalSteps - 1
                        ? 'Create Account'
                        : 'Next Step',
                icon: _step == _totalSteps - 1 ? Icons.check_circle : Icons.arrow_forward,
                background: _step == _totalSteps - 1 ? AppColors.navyContainer : AppColors.goldDark,
                onPressed: auth.isLoading.value || (_step == _totalSteps - 1 && !_agreedToTerms)
                    ? null
                    : _next,
              )),
            ),
          ],
        ),
      ),
    );
  }

  String _stepTitle(int step) {
    switch (step) {
      case 0: return 'Basic Info';
      case 1: return 'Practice';
      case 2: return 'Specialization';
      default: return 'Profile';
    }
  }

  Widget _stepWrapper(Widget child) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: child,
    );
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const CapsLabel('Full Name'),
        const SizedBox(height: 8),
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(hintText: 'Adv. Full Name'),
        ),
        const SizedBox(height: 16),
        const CapsLabel('Email Address'),
        const SizedBox(height: 8),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: 'name@example.com'),
        ),
        const SizedBox(height: 16),
        const CapsLabel('Password'),
        const SizedBox(height: 8),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(hintText: 'Min 6 characters'),
        ),
        const SizedBox(height: 16),
        const CapsLabel('Phone (Optional)'),
        const SizedBox(height: 8),
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(hintText: '+91 9876543210'),
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const CapsLabel('Primary Practice Area'),
        const SizedBox(height: 8),
        TextField(
          controller: _practiceController,
          decoration: const InputDecoration(hintText: 'e.g. Divorce, Corporate, Criminal'),
        ),
        const SizedBox(height: 16),
        const CapsLabel('Bar ID (Optional)'),
        const SizedBox(height: 8),
        TextField(
          controller: _barIdController,
          decoration: const InputDecoration(hintText: 'MH/1234/2020'),
        ),
        const SizedBox(height: 16),
        const CapsLabel('City'),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _citySlug,
          decoration: const InputDecoration(),
          hint: const Text('Select City'),
          items: const ['mumbai', 'delhi', 'bangalore', 'kolkata', 'chennai', 'pune', 'hyderabad', 'ahmedabad']
              .map((s) => DropdownMenuItem(value: s, child: Text(s[0].toUpperCase() + s.substring(1))))
              .toList(),
          onChanged: (v) => setState(() => _citySlug = v),
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const CapsLabel('Specialization (select multiple)'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _allSpecializations.map((area) {
            final selected = _specialization.contains(area);
            return SelectableChip(
              label: area,
              selected: selected,
              onTap: () => setState(() {
                selected ? _specialization.remove(area) : _specialization.add(area);
              }),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStep4(AuthController auth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Column(
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surfaceContainerHigh,
                  border: Border.all(
                      color: AppColors.outlineVariant, width: 2, style: BorderStyle.solid),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo_outlined, color: AppColors.onSurfaceVariant, size: 28),
                    const SizedBox(height: 2),
                    Text('UPLOAD',
                        style: AppText.labelCaps.copyWith(fontSize: 9)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text('Professional headshot recommended',
                  style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const CapsLabel('Short Bio'),
        const SizedBox(height: 8),
        TextField(
          controller: _bioController,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: 'Briefly describe your background, approach, and what clients can expect...',
          ),
        ),
        const SizedBox(height: 16),
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
        InkWell(
          onTap: () => setState(() => _agreedToTerms = !_agreedToTerms),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: _agreedToTerms,
                onChanged: (v) => setState(() => _agreedToTerms = v ?? false),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: RichText(
                    text: TextSpan(
                      style: AppText.bodySm.copyWith(color: AppColors.onSurface),
                      children: [
                        const TextSpan(text: 'I agree to the '),
                        TextSpan(
                          text: 'Terms of Service',
                          style: TextStyle(
                            color: AppColors.goldDark,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(
                            text: ' and confirm that my Bar Council information is accurate.'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SuccessScreen extends StatelessWidget {
  const _SuccessScreen({required this.onContinue});
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: const BoxDecoration(
                    color: AppColors.navyContainer,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_circle, color: AppColors.gold, size: 48),
                ),
                const SizedBox(height: 24),
                Text('Profile Created!', style: AppText.displayLg, textAlign: TextAlign.center),
                const SizedBox(height: 12),
                Text(
                  'Your account has been created. Welcome to LawyerSpot!',
                  textAlign: TextAlign.center,
                  style: AppText.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(height: 32),
                GoldButton(label: 'Continue to Dashboard', onPressed: onContinue),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
