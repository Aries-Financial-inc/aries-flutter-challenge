import 'package:flutter/material.dart';

abstract class Languages {
  static Languages of(BuildContext context) =>
      Localizations.of<Languages>(context, Languages)!;
}
