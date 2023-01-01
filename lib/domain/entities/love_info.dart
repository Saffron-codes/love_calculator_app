import 'package:equatable/equatable.dart';

class LoveInfo extends Equatable {
  final String firstName;
  final String secondName;
  final String percentage;
  final String result;
  const LoveInfo({
    required this.firstName,
    required this.secondName,
    required this.percentage,
    required this.result,
  });

  @override
  List<Object> get props => [firstName, secondName, percentage, result];

  factory LoveInfo.fromJson(dynamic json) {
    return LoveInfo(
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
