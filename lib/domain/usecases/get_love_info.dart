import 'package:equatable/equatable.dart';
import 'package:love_calculator/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:love_calculator/core/usecases/usecase.dart';
import 'package:love_calculator/domain/entities/love_info.dart';
import 'package:love_calculator/domain/repositories/love_info_repository.dart';

class GetLoveInfo implements UseCase<LoveInfo,Params> {
  final LoveInfoRepository loveInfoRepository;

  GetLoveInfo(this.loveInfoRepository);
  @override
  Future<Either<Failure, LoveInfo>> call(Params params) async {
    return await loveInfoRepository.getLoveInfo(params.fName, params.sName);
  }
  
}



class Params extends Equatable {
  final String fName;
  final String sName;

  const Params({required this.fName,required this.sName});
  @override
  List<Object> get props => [fName,sName];
}