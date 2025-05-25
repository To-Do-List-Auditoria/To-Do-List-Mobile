import 'package:flutter/material.dart';

class CardComponent extends StatelessWidget {
  final Widget child;
  final double? width;

  const CardComponent({super.key, required this.child, this.width});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: SizedBox(
        width: width,
        child: Padding(padding: const EdgeInsets.all(4.0), child: child),
      ),
    );
  }
}
