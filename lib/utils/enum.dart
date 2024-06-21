enum OptionType { call, put }

enum OptionLongShort { short, long }

// enum PageRouteAnimation { Fade, Scale, Rotate, Slide, SlideBottomTop }

extension OptionTypeExtension on OptionType {
  String get text {
    switch (this) {
      case OptionType.call:
        return 'Call';
      case OptionType.put:
        return 'Put';
    }
  }
}
