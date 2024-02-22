part of 'main_page_bloc.dart';

class MainPageState extends Equatable {
  const MainPageState();

  @override
  List<Object?> get props => [];
}

class MainPageInitial extends MainPageState {
  @override
  List<Object?> get props => [];
}

class MainPageLoading extends MainPageState {}

class MainPageLoaded extends MainPageState {
  final List<HeartRateModel> heartRateList;

  const MainPageLoaded({required this.heartRateList});

  @override
  List<Object?> get props => [heartRateList];
}

class MainPageLoadingFailure extends MainPageState {
  const MainPageLoadingFailure(this.exception);

  final Object exception;

  @override
  List<Object?> get props => super.props..add(exception);
}
