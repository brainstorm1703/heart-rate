import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:heart_rate/repository/abstract_heart_rate_repository.dart';
import 'package:heart_rate/repository/models/heart_rate_model.dart';

part 'history_page_event.dart';
part 'history_page_state.dart';

class HistoryPageBloc extends Bloc<HistoryPageEvent, HistoryPageState> {
  HistoryPageBloc(
    this.heartRateRepository,
  ) : super(HistoryPageInitial()) {
    on<LoadHistoryPage>(_load);
  }

  final AbstractHeartRateRepository heartRateRepository;

  Future<void> _load(
    LoadHistoryPage event,
    Emitter<HistoryPageState> emit,
  ) async {
    try {
      if (state is! HistoryPageLoaded) {
        emit(HistoryPageLoading());
      }
      final heartRateList = await heartRateRepository.getAllHeartRete();
      emit(HistoryPageLoaded(heartRateList: heartRateList));
    } catch (e) {
      emit(HistoryPageLoadingFailure(e));
    }
  }
}
