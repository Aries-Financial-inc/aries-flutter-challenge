import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// import '../linker.dart';

// extension WidgetExtension on Widget? {
//   /// Launch a new screen
//   Future<T?> launch<T>(BuildContext context,
//       {bool isNewTask = false,
//       PageRouteAnimation? pageRouteAnimation,
//       Duration? duration}) async {
//     if (isNewTask) {
//       return await Navigator.of(context).pushAndRemoveUntil(
//         buildPageRoute(
//             this!, pageRouteAnimation ?? pageRouteAnimationGlobal, duration),
//         (route) => false,
//       );
//     } else {
//       return await Navigator.of(context).push(
//         buildPageRoute(
//             this!, pageRouteAnimation ?? pageRouteAnimationGlobal, duration),
//       );
//     }
//   }

//   Route<T> buildPageRoute<T>(
//     Widget child,
//     PageRouteAnimation? pageRouteAnimation,
//     Duration? duration,
//   ) {
//     if (pageRouteAnimation != null) {
//       if (pageRouteAnimation == PageRouteAnimation.Fade) {
//         return PageRouteBuilder(
//           pageBuilder: (c, a1, a2) => child,
//           transitionsBuilder: (c, anim, a2, child) {
//             return FadeTransition(opacity: anim, child: child);
//           },
//           transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
//         );
//       } else if (pageRouteAnimation == PageRouteAnimation.Rotate) {
//         return PageRouteBuilder(
//           pageBuilder: (c, a1, a2) => child,
//           transitionsBuilder: (c, anim, a2, child) {
//             return RotationTransition(
//                 child: child, turns: ReverseAnimation(anim));
//           },
//           transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
//         );
//       } else if (pageRouteAnimation == PageRouteAnimation.Scale) {
//         return PageRouteBuilder(
//           pageBuilder: (c, a1, a2) => child,
//           transitionsBuilder: (c, anim, a2, child) {
//             return ScaleTransition(child: child, scale: anim);
//           },
//           transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
//         );
//       } else if (pageRouteAnimation == PageRouteAnimation.Slide) {
//         return PageRouteBuilder(
//           pageBuilder: (c, a1, a2) => child,
//           transitionsBuilder: (c, anim, a2, child) {
//             return SlideTransition(
//               child: child,
//               position: Tween(
//                 begin: Offset(1.0, 0.0),
//                 end: Offset(0.0, 0.0),
//               ).animate(anim),
//             );
//           },
//           transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
//         );
//       } else if (pageRouteAnimation == PageRouteAnimation.SlideBottomTop) {
//         return PageRouteBuilder(
//           pageBuilder: (c, a1, a2) => child,
//           transitionsBuilder: (c, anim, a2, child) {
//             return SlideTransition(
//               child: child,
//               position: Tween(
//                 begin: Offset(0.0, 1.0),
//                 end: Offset(0.0, 0.0),
//               ).animate(anim),
//             );
//           },
//           transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
//         );
//       }
//     }
//     return MaterialPageRoute<T>(builder: (_) => child);
//   }
// }

// // int Extensions
// extension IntExtensions on int? {
//   /// Validate given int is not null and returns given value if null.
//   int validate({int value = 0}) {
//     return this ?? value;
//   }

//   Duration get milliseconds => Duration(milliseconds: validate());
// }

// String Extensions
extension AppStringExtension on String? {
  printlog() {
    if (kDebugMode) {
      print(this);
    }
  }
}
