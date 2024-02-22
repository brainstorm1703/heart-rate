import 'package:flutter/material.dart';

class HistoryPageErrorWidget extends StatelessWidget {
  const HistoryPageErrorWidget({super.key, required this.exception});

  final Object exception;

  @override
  Widget build(BuildContext context) {
    final errorMessage = 'Exception: ${exception.toString()}';
    return Center(
      child: Text(errorMessage),
    );
  }
}
