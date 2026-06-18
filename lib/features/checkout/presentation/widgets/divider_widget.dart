import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: double.infinity,
      color: Theme.of(context).colorScheme.surfaceDim,
    );
  }
}
