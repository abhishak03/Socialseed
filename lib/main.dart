import 'package:flutter/material.dart';
import 'package:socialseed/app/widgets/opacity_leaf_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const OpacityAnimationBetweenLeaves(),
      ),
    );
  }
}
