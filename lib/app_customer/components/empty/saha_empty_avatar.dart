import 'package:flutter/material.dart';

class SahaEmptyAvata extends StatelessWidget {
  final double? height;
  final double? width;
  final double? sizeIcon;

  const SahaEmptyAvata({Key? key, this.height, this.width, this.sizeIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.person, color: Colors.grey, size: sizeIcon ?? 40,)
    );
  }
}
