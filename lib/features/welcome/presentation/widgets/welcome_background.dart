import 'package:flutter/material.dart';

class WelcomeBackground extends StatelessWidget {
  const WelcomeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: const <Widget>[
        _BackgroundImage(),
        _BackgroundOverlay(),
      ],
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/welcome_bg.png',
      fit: BoxFit.cover,
    );
  }
}

class _BackgroundOverlay extends StatelessWidget {
  const _BackgroundOverlay();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0x66050810),
            Color(0xC90A0718),
          ],
        ),
      ),
    );
  }
}
