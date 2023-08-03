
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final Widget child;
  final Widget childCategories;
  const Body({Key? key, required this.child, required this.childCategories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 210.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          childCategories,
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
