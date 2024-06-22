import 'package:fl_chart/fl_chart.dart';
import 'package:json_annotation/json_annotation.dart';

class FlSpotConverter implements JsonConverter<FlSpot, Map<String, dynamic>> {
  const FlSpotConverter();

  @override
  FlSpot fromJson(Map<String, dynamic> json) {
    return FlSpot(
      (json['x'] as num).toDouble(),
      (json['y'] as num).toDouble(),
    );
  }

  @override
  Map<String, dynamic> toJson(FlSpot object) {
    return {
      'x': object.x,
      'y': object.y,
    };
  }
}
