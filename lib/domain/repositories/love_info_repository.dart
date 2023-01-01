import 'package:dartz/dartz.dart';
import 'package:love_calculator/domain/entities/love_info.dart';

import '../../core/error/failures.dart';

abstract class LoveInfoRepository {
  Future<Either<Failure,LoveInfo>> getLoveInfo(String firstName,String secondName);
}