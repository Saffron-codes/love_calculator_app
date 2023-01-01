import 'package:love_calculator/domain/entities/love_info.dart';

class LoveInfoModel extends LoveInfo {
  final String firstName;
  final String secondName;
  final String percentage;
  final String result;

  const LoveInfoModel({
    required this.firstName,
    required this.secondName,
    required this.percentage,
    required this.result,
  }) : super(
          firstName: firstName,
          secondName: secondName,
          percentage: percentage,
          result: result,
        );

  factory LoveInfoModel.fromJson(dynamic json) {
    return LoveInfoModel(
      firstName: json['fname'],
      secondName: json['sname'],
      percentage: json['percentage'],
      result: json['result'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'fname': firstName,
      'sname': secondName,
      'percentage': percentage,
      'result': result,
    };
  }
}
