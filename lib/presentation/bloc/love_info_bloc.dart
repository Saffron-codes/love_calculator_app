import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:love_calculator/domain/entities/love_info.dart';
import 'package:love_calculator/domain/usecases/get_love_info.dart';

import '../../core/error/failures.dart';

part 'love_info_event.dart';
part 'love_info_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class LoveInfoBloc extends Bloc<LoveInfoEvent, LoveInfoState> {
  final GetLoveInfo getLoveInfo;

  LoveInfoBloc({required this.getLoveInfo}) : super(Empty()) {
    on<GetLoveInfoEvent>((event, emit) async {
      emit(Loading());
      final params = Params(fName: event.firstName, sName: event.secondName);
      final failureOrloveInfo = await getLoveInfo(params);
      final result = failureOrloveInfo.fold(
        (failure) => Error(
          message: _mapFailureToMessage(failure),
        ),
        (loveInfo) => Loaded(loveInfo: loveInfo),
      );
      emit(result);
    });
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}
