import 'package:flutter/material.dart';

class CustomScreen extends StatelessWidget {
  final Widget customWidget;
  final double height;
  final double containerHeight;
  final String title;
  const CustomScreen({
    super.key,
    required this.customWidget,
    required this.height,
    required this.title,
    required this.containerHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height,
          ),
          Center(
            child: Text(
              title,
            ),
          ),
          const SizedBox(height: 32),
          Container(
            height: containerHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.pink.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: customWidget,
          ),
        ],
      ),
    );
  }
}
