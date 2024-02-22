import 'package:flutter/material.dart';
import 'package:heart_rate/router/router.dart';
import 'package:heart_rate/theme/theme.dart';

class HeartRateApp extends StatelessWidget {
  const HeartRateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heart Rate',
      theme: theme,
      routes: routes,
    );
  }
}
