import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:heart_rate/repository/abstract_heart_rate_repository.dart';
import 'package:heart_rate/repository/models/heart_rate_model.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  MainPageBloc(
    this.heartRateRepository,
  ) : super(MainPageInitial()) {
    on<LoadMainPage>(_load);
  }

  final AbstractHeartRateRepository heartRateRepository;

  Future<void> _load(
    LoadMainPage event,
    Emitter<MainPageState> emit,
  ) async {
    try {
      if (state is! MainPageLoaded) {
        emit(MainPageLoading());
      }
      final heartRateList = await heartRateRepository.getFirstThreeHeartRete();
      emit(MainPageLoaded(heartRateList: heartRateList));
    } catch (e) {
      emit(MainPageLoadingFailure(e));
    }
  }
}
