import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heart_rate/repository/abstract_heart_rate_repository.dart';
import 'package:heart_rate/repository/models/heart_rate_model.dart';

part 'heart_rate_page_event.dart';
part 'heart_rate_page_state.dart';

class HeartRatePageBloc extends Bloc<HeartRatePageEvent, HeartRatePageState> {
  HeartRatePageBloc(this.heartRateRepository) : super(HeartRatePageInitial()) {
    on<AddHeartRate>(_add);
    on<EditHeartRate>(_edit);
    on<DeleteHeartRate>(_delete);
  }

  final AbstractHeartRateRepository heartRateRepository;

  Future<void> _add(
    AddHeartRate event,
    Emitter<HeartRatePageState> emit,
  ) async {
    try {
      heartRateRepository.addHeartRate(event.heartRate);
      emit(HeartRatePageAdded());
    } catch (e) {
      emit(HeartRatePageFailure(exception: e));
    }
  }

  Future<void> _edit(
    EditHeartRate event,
    Emitter<HeartRatePageState> emit,
  ) async {
    try {
      await heartRateRepository.editHeartRate(
          event.oldHeartRate, event.newHeartRate);
      emit(HeartRatePageEdited());
    } catch (e) {
      emit(HeartRatePageFailure(exception: e));
    }
  }

  Future<void> _delete(
    DeleteHeartRate event,
    Emitter<HeartRatePageState> emit,
  ) async {
    try {
      await heartRateRepository.deleteHeartRate(event.heartRate);
      emit(HeartRatePageDeleted());
    } catch (e) {
      emit(HeartRatePageFailure(exception: e));
    }
  }
}
