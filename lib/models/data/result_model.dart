
class BodyResultData {
  final double value;
  final String comment;

  BodyResultData({
    required this.value,
    required this.comment,
  });

  factory BodyResultData.fromJson(Map<String, dynamic> json) {
    return BodyResultData(
      value: json['value'],
      comment: json['comment'],
    );
  }
}
