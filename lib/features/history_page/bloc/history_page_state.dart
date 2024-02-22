part of 'history_page_bloc.dart';

class HistoryPageState extends Equatable {
  const HistoryPageState();
  @override
  List<Object?> get props => [];
}

class HistoryPageInitial extends HistoryPageState {}

class HistoryPageLoading extends HistoryPageState {}

class HistoryPageLoaded extends HistoryPageState {
  final List<HeartRateModel> heartRateList;

  const HistoryPageLoaded({required this.heartRateList});

  @override
  List<Object?> get props => [heartRateList];
}

class HistoryPageLoadingFailure extends HistoryPageState {
  const HistoryPageLoadingFailure(this.exception);

  final Object exception;

  @override
  List<Object?> get props => super.props..add(exception);
}
