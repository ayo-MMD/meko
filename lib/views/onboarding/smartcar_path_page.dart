import 'package:flutter/material.dart';

import '../../ui/theme/meko_colors.dart';
import '../../ui/theme/meko_text_styles.dart';

/// Smartcar Path page — lets the user search for their car brand
/// to link via the manufacturer's cloud API.
class SmartcarPathPage extends StatefulWidget {
  const SmartcarPathPage({super.key});

  @override
  State<SmartcarPathPage> createState() => _SmartcarPathPageState();
}

class _SmartcarPathPageState extends State<SmartcarPathPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                'What make is your car?',
                style: MekoTextStyles.headlineLarge.copyWith(
                  color: MekoColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Select your car brand to link your vehicle cloud account securely. You will need to create a free account if you don't have one",
                style: MekoTextStyles.bodyLarge.copyWith(
                  color: MekoColors.textSecondary,
                ),
              ),

              const SizedBox(height: 24),

              // --- Search Field ---
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search brand (e.g BMW, Ford, Toy...)',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close, color: MekoColors.textSecondary),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                  ),
                ),
                onChanged: (_) => setState(() {}),
              ),

              const SizedBox(height: 24),

              // --- Back / Label ---
              InkWell(
                onTap: () => Navigator.of(context).maybePop(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.arrow_back,
                      size: 22,
                      color: MekoColors.textPrimary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Back',
                      style: MekoTextStyles.bodyLarge.copyWith(
                        color: MekoColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              // TODO: Populate brand list from Smartcar API
            ],
          ),
        ),
      ),
    );
  }
}
