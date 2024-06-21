import 'package:flutter/material.dart';

class LayoutResolver extends StatelessWidget {
  final Widget landscapeWidget;
  final Widget portraitWidget;
  const LayoutResolver({
    Key? key,
    required this.landscapeWidget,
    required this.portraitWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      return !(constraints.maxWidth > constraints.maxHeight)
          ? portraitWidget
          : Center(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width >= 600
                      ? 600
                      : MediaQuery.of(context).size.width,
                  child: landscapeWidget));
    }));
  }
}