import 'package:love_calculator/core/error/exceptions.dart';
import 'package:love_calculator/data/datasources/love_info_remote_datasource.dart';
import 'package:love_calculator/domain/entities/love_info.dart';
import 'package:love_calculator/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:love_calculator/domain/repositories/love_info_repository.dart';

class LoveInfoRepositoryImpl implements LoveInfoRepository {
  final LoveInfoRemoteDataSource remoteDataSource;

  LoveInfoRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, LoveInfo>> getLoveInfo(
      String firstName, String secondName) async {
    try {
      final loveInfo =
          await remoteDataSource.getLoveInfo(firstName, secondName);
      return Right(loveInfo);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
