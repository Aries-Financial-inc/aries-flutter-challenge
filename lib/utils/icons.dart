// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppIcons {
  AppIcons._();
  static const AppIconData home = AppIconData('home');
  static const AppIconData profile = AppIconData('profile');
  static const AppIconData more = AppIconData('more');
}

@immutable
class AppIconData {
  final String iconpoint;
  final String? icontype;

  const AppIconData(
    this.iconpoint, {
    this.icontype = 'svg',
  });
}

class AppIcon extends StatelessWidget {
  const AppIcon(
    this.icon, {
    super.key,
    this.size,
    this.color,
    this.semanticLabel,
    this.textDirection,
    this.shadows,
  });

  final AppIconData? icon;
  final double? size;
  final Color? color;
  final String? semanticLabel;
  final TextDirection? textDirection;
  final List<Shadow>? shadows;

  @override
  Widget build(BuildContext context) {
    // assert(this.textDirection != null || debugCheckHasDirectionality(context));
    // final TextDirection textDirection =
    //     this.textDirection ?? Directionality.of(context);

    final IconThemeData iconTheme = IconTheme.of(context);

    final double? iconSize = size ?? iconTheme.size;

    // final List<Shadow>? iconShadows = shadows ?? iconTheme.shadows;

    // if (icon == null) {
    //   return Semantics(
    //     label: semanticLabel,
    //     child: SizedBox(width: iconSize, height: iconSize),
    //   );
    // }

    // final double iconOpacity = iconTheme.opacity ?? 1.0;
    Color iconColor = color ?? iconTheme.color!;
    // if (iconOpacity != 1.0)
    //   iconColor = iconColor.withOpacity(iconColor.opacity * iconOpacity);

    Widget iconWidget = icon!.icontype! == 'png'
        ? Image.asset('assets/icons/png/${icon!.iconpoint}.png',
            width: iconSize, height: iconSize)
        : SvgPicture.asset('assets/icons/svg/${icon!.iconpoint}.svg',
            semanticsLabel: semanticLabel,
            color: iconColor,
            width: iconSize,
            height: iconSize);

    return iconWidget;

    // Semantics(
    //   label: semanticLabel,
    //   child: ExcludeSemantics(
    //     child: SizedBox(
    //       width: iconSize,
    //       height: iconSize,
    //       child: Center(
    //         child: iconWidget,
    //       ),
    //     ),
    //   ),
    // );
  }
}
