part of 'heart_rate_page_bloc.dart';

class HeartRatePageState extends Equatable {
  const HeartRatePageState();
  @override
  List<Object?> get props => [];
}

class HeartRatePageInitial extends HeartRatePageState {}

class HeartRatePageAdded extends HeartRatePageState {}

class HeartRatePageEdited extends HeartRatePageState {}

class HeartRatePageDeleted extends HeartRatePageState {}

class HeartRatePageFailure extends HeartRatePageState {
  final Object exception;

  const HeartRatePageFailure({required this.exception});
  @override
  List<Object?> get props => super.props..add(exception);
}
