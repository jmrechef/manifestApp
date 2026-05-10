import 'package:flutter/material.dart';

import '../../../../shared/widgets/ambient_background.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AmbientBackground(
      child: SafeArea(
        child: Center(
          child: Text(
            'Profile screen',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
