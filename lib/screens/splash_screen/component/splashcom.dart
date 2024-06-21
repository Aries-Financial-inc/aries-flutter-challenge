import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum SplashType {
  fadeIn,
}

typedef SetNextScreenAsyncCallback = Future<Widget> Function();

// ignore: must_be_immutable
class SplashComponent extends StatefulWidget {
  SplashComponent({
    super.key,
    this.duration = const Duration(milliseconds: 3000),
    this.backgroundColor = Colors.black,
    this.splashScreenBody,
    required this.defaultNextScreen,
    this.setStateTimer = const Duration(milliseconds: 100),
    this.setStateCallback,
    this.onInitt,
    this.onEnd,
    this.setNextScreenAsyncCallback,
    this.useImmersiveMode = false,
  });

  Duration duration;

  Color? backgroundColor;

  Widget? splashScreenBody;

  VoidCallback? defaultNextScreen;

  SetNextScreenAsyncCallback? setNextScreenAsyncCallback;

  Duration setStateTimer;

  VoidCallback? setStateCallback;

  VoidCallback? onInitt;

  VoidCallback? onEnd;

  String? gifPath;

  /// Width of gif.
  /// ```dart
  /// ```
  double? gifWidth;

  /// Height of gif.
  /// ```dart
  /// ```
  double? gifHeight;
  //#endregion

  //#region FadeIn

  double _opacity = 0;

  // double _scale = 0;

  /// A [VoidCallback] which will be triggered after flutter splash screen [Duration].
  /// ```dart
  /// onAnimationEnd: ()  {
  ///   debugPrint("Animation End");
  /// }
  /// ```
  VoidCallback? onAnimationEnd;

  /// A child [Widget] which will be shown during opacity animation.
  /// ```dart
  /// childWidget : SizedBox(
  ///          height: 200,
  ///          width: 200,
  ///          child: Image.asset("assets/dart_bird.png"),
  ///       )
  /// ```
  Widget? childWidget;

  Duration? animationDuration;

  SplashType splashType = SplashType.fadeIn;
  Curve animationCurve = Curves.ease;
  Image? backgroundImage;
  Gradient? gradient;
  bool useImmersiveMode;

  @override
  State<SplashComponent> createState() => _SplashComponentState();

  // /// Provides ready-made fadeIn templated splash;
  SplashComponent.fadeIn({
    super.key,
    required this.defaultNextScreen,
    required this.childWidget,
    this.animationCurve = Curves.ease,
    this.animationDuration = const Duration(milliseconds: 2000),
    this.duration = const Duration(milliseconds: 3000),
    this.backgroundColor = Colors.black,
    this.setStateTimer = const Duration(milliseconds: 200),
    this.onAnimationEnd,
    this.onInitt,
    this.onEnd,
    this.setNextScreenAsyncCallback,
    this.backgroundImage,
    this.gradient,
    this.useImmersiveMode = false,
  }) {
    splashType = SplashType.fadeIn;

    setStateCallback = () {
      _opacity = 1;
    };
  }
}

class _SplashComponentState extends State<SplashComponent> {
  @override
  void initState() {
    super.initState();

    if (widget.useImmersiveMode) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    }

    Future.delayed(widget.setStateTimer, () {
      if (mounted) {
        widget.setStateCallback?.call();
        setState(() {});
      }
    });

    Future.delayed(widget.duration, () {
      widget.onEnd?.call();
      widget.defaultNextScreen;
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.useImmersiveMode) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeInSplash()
      ..opacity = widget._opacity
      ..backgroundColor = widget.backgroundColor
      ..onFadeInEnd = widget.onAnimationEnd
      ..fadeInChildWidget = widget.childWidget
      ..fadeInAnimationDuration = widget.animationDuration
      ..animationCurve = widget.animationCurve
      ..backgroundImage = widget.backgroundImage
      ..gradient = widget.gradient;
  }
}

// ignore: must_be_immutable
class FadeInSplash extends StatefulWidget {
  FadeInSplash({super.key});
  Color? backgroundColor;
  double opacity = 0;
  VoidCallback? onFadeInEnd;
  Widget? fadeInChildWidget;
  Duration? fadeInAnimationDuration;
  Curve? animationCurve = Curves.ease;
  Image? backgroundImage;
  Gradient? gradient;

  @override
  State<FadeInSplash> createState() => _FadeInSplashState();
}

class _FadeInSplashState extends State<FadeInSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          image: widget.backgroundImage != null
              ? DecorationImage(
                  image: widget.backgroundImage!.image,
                  fit: BoxFit.fill,
                )
              : null,
          gradient: widget.gradient,
        ),
        child: Center(
          child: AnimatedOpacity(
            opacity: widget.opacity,
            curve: widget.animationCurve!,
            onEnd: widget.onFadeInEnd,
            duration: widget.fadeInAnimationDuration!,
            child: widget.fadeInChildWidget,
          ),
        ),
      ),
    );
  }
}
