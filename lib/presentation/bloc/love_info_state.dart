part of 'love_info_bloc.dart';

abstract class LoveInfoState extends Equatable {
  const LoveInfoState();

  @override
  List<Object> get props => [];
}

class Empty extends LoveInfoState {}

class Loading extends LoveInfoState {}

class Loaded extends LoveInfoState {
  final LoveInfo loveInfo;

  const Loaded({required this.loveInfo});
  @override
  List<Object> get props => [loveInfo];
}

class Error extends LoveInfoState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
