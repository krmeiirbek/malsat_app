part of 'loading_bloc.dart';

abstract class LoadingEvent extends Equatable {
  const LoadingEvent();
}

class RunLoginLoading extends LoadingEvent {
  @override
  List<Object> get props => [];
}

class StopLoginLoading extends LoadingEvent {
  @override
  List<Object> get props => [];
}
