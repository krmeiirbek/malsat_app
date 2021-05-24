import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'loading_event.dart';

part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(LoadingInitial());


  @override
  Stream<LoadingState> mapEventToState(LoadingEvent event) async* {

    if (event is RunLoginLoading) {
      yield Loading();
    }
    if (event is StopLoginLoading) {
      yield LoadingInitial();
    }
  }
}
