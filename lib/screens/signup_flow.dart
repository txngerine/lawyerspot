import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class SignupFlow extends StatefulWidget {
  const SignupFlow({super.key});

  @override
  State<SignupFlow> createState() => _SignupFlowState();
}

class _SignupFlowState extends State<SignupFlow> {
  final _pageController = PageController();
  int _step = 0; // 0..3 = steps 1-4, 4 = success
  static const _totalSteps = 4;

  // Step 1
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _barNumberController = TextEditingController();
  String? _barState;

  // Step 2
  int _yearsExperience = 5;
  final Set<String> _practiceAreas = {'Corporate', 'Property'};
  static const _allPracticeAreas = [
    'Corporate', 'Criminal', 'Divorce', 'Family', 'GST & Tax',
    'Immigration', 'Property', 'Startup', 'Cyber Crime',
  ];

  // Step 3
  final List<String> _cities = ['New York, NY', 'Brooklyn, NY'];
  final _cityController = TextEditingController();
  final _feeController = TextEditingController(text: '250');

  // Step 4
  final _bioController = TextEditingController();
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _barNumberController.dispose();
    _cityController.dispose();
    _feeController.dispose();
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
      setState(() => _step = _totalSteps); // success screen
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
            // Header
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
            // Progress
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
                  _stepWrapper(_buildStep4()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: GoldButton(
                label: _step == _totalSteps - 1 ? 'Create Account' : 'Next Step',
                icon: _step == _totalSteps - 1 ? Icons.check_circle : Icons.arrow_forward,
                background: _step == _totalSteps - 1 ? AppColors.navyContainer : AppColors.goldDark,
                onPressed: _step == _totalSteps - 1 && !_agreedToTerms ? null : _next,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _stepTitle(int step) {
    switch (step) {
      case 0:
        return 'Basic Info';
      case 1:
        return 'Expertise';
      case 2:
        return 'Logistics';
      default:
        return 'Profile';
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
          decoration: const InputDecoration(hintText: 'Enter your full legal name'),
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
        const CapsLabel('Bar Council Number'),
        const SizedBox(height: 8),
        TextField(
          controller: _barNumberController,
          decoration: const InputDecoration(hintText: 'e.g. BAR/1234/56'),
        ),
        const SizedBox(height: 16),
        const CapsLabel('Bar Council State'),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _barState,
          decoration: const InputDecoration(),
          hint: const Text('Select State'),
          items: const ['New York', 'California', 'Texas', 'Florida', 'Illinois']
              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
              .toList(),
          onChanged: (v) => setState(() => _barState = v),
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SoftCard(
          child: Column(
            children: [
              const CapsLabel('Years of Experience'),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _stepperButton(Icons.remove, () {
                    if (_yearsExperience > 0) setState(() => _yearsExperience--);
                  }),
                  SizedBox(
                    width: 64,
                    child: Text(
                      '$_yearsExperience',
                      textAlign: TextAlign.center,
                      style: AppText.displayLg,
                    ),
                  ),
                  _stepperButton(Icons.add, () => setState(() => _yearsExperience++)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const CapsLabel('Practice Areas (select multiple)'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _allPracticeAreas.map((area) {
            final selected = _practiceAreas.contains(area);
            return SelectableChip(
              label: area,
              selected: selected,
              onTap: () => setState(() {
                selected ? _practiceAreas.remove(area) : _practiceAreas.add(area);
              }),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _stepperButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 48,
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Icon(icon, color: AppColors.navy),
      ),
    );
  }

  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const CapsLabel('Cities Served'),
        const SizedBox(height: 8),
        TextField(
          controller: _cityController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Search cities...',
          ),
          onSubmitted: (value) {
            if (value.trim().isEmpty) return;
            setState(() {
              _cities.add(value.trim());
              _cityController.clear();
            });
          },
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _cities.map((city) {
            return Chip(
              label: Text(city, style: AppText.bodySm.copyWith(color: Colors.white)),
              backgroundColor: AppColors.navyContainer,
              deleteIcon: const Icon(Icons.close, size: 16, color: Colors.white70),
              onDeleted: () => setState(() => _cities.remove(city)),
              shape: const StadiumBorder(),
              side: BorderSide.none,
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        const CapsLabel('Consultation Fee (Hourly)'),
        const SizedBox(height: 8),
        TextField(
          controller: _feeController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(prefixText: '\$ ', hintText: '250'),
        ),
        const SizedBox(height: 8),
        Text('This will be displayed on your public profile.',
            style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
      ],
    );
  }

  Widget _buildStep4() {
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
            hintText:
                'Briefly describe your background, approach, and what clients can expect when working with you...',
          ),
        ),
        const SizedBox(height: 16),
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
                            text:
                                ' and confirm that my Bar Council information is accurate.'),
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
                  'Your application has been received. We have sent a verification link to your '
                  'email address to confirm your identity.',
                  textAlign: TextAlign.center,
                  style: AppText.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(height: 32),
                GoldButton(label: 'Continue to Dashboard', onPressed: onContinue),
                const SizedBox(height: 16),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text("Didn't receive it? ",
                        style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                    Text('Resend email',
                        style: AppText.bodySm.copyWith(
                            color: AppColors.navy, fontWeight: FontWeight.w700)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
