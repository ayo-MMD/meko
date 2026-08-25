import 'package:flutter/material.dart';

import '../theme/meko_colors.dart';
import '../theme/meko_text_styles.dart';

/// Full-width rounded CTA button used throughout Meko.
///
/// Matches the "Proceed", "Continue", "continue" buttons in the mockups:
/// dark maroon background, white text, rounded corners, full width.
class MekoButton extends StatelessWidget {
  const MekoButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: MekoColors.primary,
          foregroundColor: MekoColors.textOnPrimary,
          disabledBackgroundColor: MekoColors.primary.withValues(alpha: 0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: MekoColors.textOnPrimary,
                ),
              )
            : Text(label, style: MekoTextStyles.button),
      ),
    );
  }
}
