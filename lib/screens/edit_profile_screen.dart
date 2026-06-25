import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'notifications_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _available = true;
  final Set<String> _practiceAreas = {'Corporate Law', 'Intellectual Property', 'Contract Negotiation'};
  final _bioController = TextEditingController(
    text: 'With over 15 years of experience in corporate litigation, I specialize in '
        'complex commercial disputes, intellectual property defense, and high-stakes negotiations.',
  );
  final _yearsController = TextEditingController(text: '15');
  final _feeController = TextEditingController(text: '350');
  final _cityController = TextEditingController(text: 'New York City, NY');

  @override
  void dispose() {
    _bioController.dispose();
    _yearsController.dispose();
    _feeController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrandAppBar(
        onNotificationsTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const NotificationsScreen())),
      ),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
              children: [
                Center(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: [
                                BoxShadow(color: AppColors.navy.withOpacity(0.08), blurRadius: 10),
                              ],
                            ),
                            child: const CircleAvatar(
                              backgroundColor: AppColors.surfaceContainerHigh,
                              child: Icon(Icons.person, size: 40, color: AppColors.navy),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 2,
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: AppColors.navyContainer,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: const Icon(Icons.check_circle, size: 16, color: AppColors.gold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text('Eleanor Vance, Esq.', style: AppText.headlineMd),
                      const SizedBox(height: 2),
                      Text('Senior Partner at Vance & Associates',
                          style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.visibility_outlined, size: 18),
                        label: const Text('Preview as Client'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.navy,
                          side: BorderSide(color: AppColors.navy.withOpacity(0.2)),
                          shape: const StadiumBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                SoftCard(
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Availability Status', style: AppText.titleLg),
                            Text('Currently accepting consultations',
                                style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                          ],
                        ),
                      ),
                      Switch(
                        value: _available,
                        activeTrackColor: AppColors.navyContainer,
                        onChanged: (v) => setState(() => _available = v),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                _section(
                  title: 'Bio & Experience',
                  children: [
                    const CapsLabel('Professional Biography'),
                    const SizedBox(height: 8),
                    TextField(controller: _bioController, maxLines: 4),
                    const SizedBox(height: 16),
                    const CapsLabel('Years of Experience'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _yearsController,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                SoftCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Practice Areas', style: AppText.headlineMd.copyWith(fontSize: 19)),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add_circle_outline, color: AppColors.goldDark),
                          ),
                        ],
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _practiceAreas.map((area) {
                          return Chip(
                            label: Text(area, style: AppText.bodySm.copyWith(color: AppColors.navy)),
                            backgroundColor: AppColors.gold.withOpacity(0.1),
                            side: BorderSide(color: AppColors.gold.withOpacity(0.4)),
                            shape: const StadiumBorder(),
                            deleteIcon: const Icon(Icons.close, size: 16),
                            onDeleted: () => setState(() => _practiceAreas.remove(area)),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                _section(
                  title: 'Consultation Details',
                  children: [
                    const CapsLabel('Initial Consultation Fee (Hourly)'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _feeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(prefixText: '\$ '),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _section(
                  title: 'Locations & Jurisdictions',
                  children: [
                    const CapsLabel('Primary City'),
                    const SizedBox(height: 8),
                    TextField(controller: _cityController),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile changes saved.')),
                  );
                },
                icon: const Icon(Icons.save_outlined, size: 18),
                label: const Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  foregroundColor: AppColors.navy,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  elevation: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section({required String title, required List<Widget> children}) {
    return SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppText.headlineMd.copyWith(fontSize: 19)),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}
