import 'package:flutter/material.dart';

import '../../ui/theme/meko_colors.dart';
import '../../ui/theme/meko_text_styles.dart';
import '../../ui/widgets/meko_button.dart';

/// Authentication screen — first page of the onboarding flow.
///
/// Collects the user's Garage ID and Customer ID before proceeding
/// to the Connect Vehicle selection screen.
class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final _garageIdController = TextEditingController();
  final _customerIdController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _garageIdController.dispose();
    _customerIdController.dispose();
    super.dispose();
  }

  Future<void> _handleProceed() async {
    final garageId = _garageIdController.text.trim();
    final customerId = _customerIdController.text.trim();

    if (garageId.isEmpty || customerId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both IDs')),
      );
      return;
    }

    setState(() => _isLoading = true);

    // TODO: Validate IDs against Supabase
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.of(context).pushNamed('/connectVehicle');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MekoColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),

              // --- Heading ---
              Text(
                "Let's go in",
                style: MekoTextStyles.headlineLarge.copyWith(
                  color: MekoColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your garage ID and customer ID',
                style: MekoTextStyles.bodyLarge.copyWith(
                  color: MekoColors.textSecondary,
                ),
              ),

              const SizedBox(height: 40),

              // --- Garage ID Field ---
              TextField(
                controller: _garageIdController,
                decoration: const InputDecoration(
                  hintText: 'Enter your Garage ID',
                ),
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: 16),

              // --- Customer ID Field ---
              TextField(
                controller: _customerIdController,
                decoration: const InputDecoration(
                  hintText: 'Enter your customer ID',
                ),
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _handleProceed(),
              ),

              const Spacer(),

              // --- Proceed Button ---
              MekoButton(
                label: 'Proceed',
                onPressed: _handleProceed,
                isLoading: _isLoading,
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
