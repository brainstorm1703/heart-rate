import 'package:flutter/material.dart';

class MainPageErrorWidget extends StatelessWidget {
  const MainPageErrorWidget({super.key, required this.exception});

  final Object exception;

  @override
  Widget build(BuildContext context) {
    final errorMessage = 'Exception: ${exception.toString()}';
    return Center(
      child: Text(errorMessage),
    );
  }
}
