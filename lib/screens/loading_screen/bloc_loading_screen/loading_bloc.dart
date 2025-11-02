
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiley_toothy/screens/loading_screen/bloc_loading_screen/loading_event.dart';
import 'package:smiley_toothy/screens/loading_screen/bloc_loading_screen/loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent,LoadingState>{
  LoadingBloc(): super(LoadingState(progress: 0.0)){
    on<StartingLoading>(_onStartLoading);
  }
  Future<void> _onStartLoading(
      StartingLoading event, Emitter<LoadingState> emit) async {
    double progress = 0.0;
    while (progress < 1.0) {
      await Future.delayed(const Duration(milliseconds: 100));
      progress += 0.02;
      if (progress > 1.0) progress = 1.0;
      emit(LoadingState(progress: progress, isComplete: progress == 1.0));
    }
  }
}