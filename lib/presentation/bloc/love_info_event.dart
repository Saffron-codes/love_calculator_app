part of 'love_info_bloc.dart';

abstract class LoveInfoEvent extends Equatable {
  const LoveInfoEvent();

  @override
  List<Object> get props => [];
}

class GetLoveInfoEvent extends LoveInfoEvent {
  final String firstName;
  final String secondName;

  const GetLoveInfoEvent({required this.firstName, required this.secondName});

  @override
  List<Object> get props => [firstName,secondName];
}

class Reset extends LoveInfoEvent {}