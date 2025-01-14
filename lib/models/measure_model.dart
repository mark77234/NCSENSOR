import 'package:flutter/material.dart';

enum OdorType {
  foot,
  mouth,
  armpit,
}

enum MeasureType {
  drinking,
  odor,
}

/*
 */

// level(1) > color(red) > message(면허정지)
// abstract class Level {
// //   value, maxvalue, color, message

// }

abstract class MeasureData {
  final MeasureType type;
  final double value;
  final String unit;
  final int level;
  final String message;
  final Color color;
  final DateTime dateTime;

  MeasureData({
    required this.type,
    required this.value,
    required this.unit,
    required this.level,
    required this.message,
    required this.color,
    required this.dateTime,
  });

  factory MeasureData.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case "drinking":
        return DrinkingData.fromJson(json);
      case "odor":
        return OdorData.fromJson(json);
      default:
        throw Exception("Invalid type");
    }
  }

  String typeToKor();
}

class DrinkingData extends MeasureData {
  DrinkingData({
    required super.value,
    required super.unit,
    required super.level,
    required super.message,
    required super.color,
    required super.dateTime,
  }) : super(
          type: MeasureType.drinking,
        );

  factory DrinkingData.fromJson(Map<String, dynamic> json) {
    return DrinkingData(
      value: double.parse(json['value']),
      unit: "%",
      level: int.parse(json['level']),
      message: _levelToMessage(int.parse(json['level'])),
      color: _levelToColor(int.parse(json['level'])),
      dateTime: DateTime.parse(json['dateTime']),
    );
  }

  static _levelToMessage(var level) {
    switch (level) {
      case 1:
        return "면허정지";
      case 2:
        return "면허취소";
      default:
        return "정상";
    }
  }

  static _levelToColor(level) {
    switch (level) {
      case 2:
        return Colors.red;
      case 1:
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  @override
  String typeToKor() {
    return "음주";
  }
}

class OdorData extends MeasureData {
  final OdorType subType;

  OdorData({
    required this.subType,
    required super.value,
    required super.unit,
    required super.level,
    required super.message,
    required super.color,
    required super.dateTime,
  }) : super(
          type: MeasureType.odor,
        );

  factory OdorData.fromJson(Map<String, dynamic> json) {
    return OdorData(
        subType: _stringToOdorType(json['subType']),
        value: double.parse(json['value']),
        unit: "ppm",
        level: int.parse(json['level']),
        message: _levelToMessage(int.parse(json['level'])),
        color: _levelToColor(int.parse(json['level'])),
        dateTime: DateTime.parse(json['dateTime']));
  }

  static _stringToOdorType(String odorType) {
    switch (odorType) {
      case "foot":
        return OdorType.foot;
      case "mouth":
        return OdorType.mouth;
      case "armpit":
        return OdorType.armpit;
      default:
        return OdorType.foot;
    }
  }

  static _levelToMessage(var level) {
    switch (level) {
      case 4:
        return "매우 심함";
      case 3:
        return "심함";
      case 2:
        return "보통";
      case 1:
        return "약함";
      default:
        return "정상";
    }
  }

  static _levelToColor(level) {
    switch (level) {
      case 4:
        return Colors.red;
      case 3:
        return Colors.orange;
      case 2:
        return Colors.yellow;
      case 1:
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  @override
  String typeToKor() {
    String subTypeKor = "";
    switch (subType) {
      case OdorType.foot:
        subTypeKor = "발";
        break;
      case OdorType.mouth:
        subTypeKor = "입";
        break;
      case OdorType.armpit:
        subTypeKor = "겨";
        break;
    }
    return "체취 - $subTypeKor";
  }
}

class CompareGraphData {
  final String title;
  final double lastMonth;
  final double thisMonth;
  final double variationRate;

  CompareGraphData({
    required this.title,
    required this.lastMonth,
    required this.thisMonth,
    required this.variationRate,
  });

  factory CompareGraphData.fromJson(Map<String, dynamic> json) {
    return CompareGraphData(
      title: json['title'],
      lastMonth: double.parse(json['last_month']),
      thisMonth: double.parse(json['this_month']),
      variationRate: double.parse(json['variation_rate']),
    );
  }
}
