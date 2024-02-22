part of 'history_page_bloc.dart';

abstract class HistoryPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadHistoryPage extends HistoryPageEvent {}
