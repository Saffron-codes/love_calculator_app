import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:love_calculator/core/error/exceptions.dart';
import 'package:love_calculator/data/models/love_info_model.dart';

abstract class LoveInfoRemoteDataSource {
  /// calls the api endpoint
  ///
  /// Throws a [ServerException] for all error codes.
  Future<LoveInfoModel> getLoveInfo(String fName, String sName);
}

class LoveInfoRemoteDataSourceImpl implements LoveInfoRemoteDataSource {
  final http.Client client;

  LoveInfoRemoteDataSourceImpl({required this.client});
  @override
  Future<LoveInfoModel> getLoveInfo(String fName, String sName) async {
    final url = Uri.parse(
        "https://love-calculator.p.rapidapi.com/getPercentage?fname=$fName&sname=$sName");
    final res = await client.get(
      url,
      headers: {
        'X-RapidAPI-Key': '55858e16famsh5eef0e60744a04fp1e97dbjsn1df95f275e15',
        'X-RapidAPI-Host': 'love-calculator.p.rapidapi.com'
      },
    );

    if (res.statusCode == 200) {
      return LoveInfoModel.fromJson(json.decode(res.body));
    } else {
      throw ServerException();
    }
  }
}
