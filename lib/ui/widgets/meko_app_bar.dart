import 'package:flutter/material.dart';

import '../theme/meko_colors.dart';

/// Maroon-background AppBar used on Settings, Fault List, and Fault Detail pages.
///
/// Provides a consistent back-arrow + white title pattern matching the mockups.
class MekoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MekoAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.onBack,
  });

  final String title;
  final bool showBack;
  final VoidCallback? onBack;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MekoColors.primary,
      foregroundColor: MekoColors.textOnPrimary,
      elevation: 0,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBack ?? () => Navigator.of(context).maybePop(),
            )
          : null,
      title: Text(title),
      centerTitle: false,
    );
  }
}
