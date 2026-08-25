import 'package:flutter/material.dart';

import 'routing/app_router.dart';
import 'ui/theme/meko_theme.dart';

/// Root application widget for Meko.
///
/// This is the top-level widget that configures the app's theme,
/// routing, and global providers. Feature-specific configuration
/// will be added here as the app is built out.
class MekoApp extends StatelessWidget {
  const MekoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meko',
      debugShowCheckedModeBanner: false,
      theme: MekoTheme.light,
      initialRoute: AppRouter.initialRoute,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
