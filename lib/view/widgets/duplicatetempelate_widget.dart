import 'package:flutter/material.dart';

import 'duplicatecontainer_widget.dart';
class DuplicateTemplate extends StatelessWidget {
  const DuplicateTemplate({
    Key? key,
    required this.child,
    required this.title,
  }) : super(key: key);

  final Widget child;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
        ),
      ),
      body: Container(
        child: duplicateContainer(child: child),
      ),
    );
  }
}
