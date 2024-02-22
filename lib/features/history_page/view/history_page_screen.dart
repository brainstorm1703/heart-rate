import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:heart_rate/features/history_page/bloc/history_page_bloc.dart';
import 'package:heart_rate/features/history_page/widget/history_page_error_widget.dart';
import 'package:heart_rate/features/history_page/widget/history_page_widget.dart';
import 'package:heart_rate/repository/abstract_heart_rate_repository.dart';

class HistoryPageScreen extends StatefulWidget {
  const HistoryPageScreen({super.key});

  @override
  State<HistoryPageScreen> createState() => _HistoryPageScreenState();
}

class _HistoryPageScreenState extends State<HistoryPageScreen> {
  final _historyPageBloc =
      HistoryPageBloc(GetIt.I<AbstractHeartRateRepository>());
  @override
  void initState() {
    _historyPageBloc.add(LoadHistoryPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        centerTitle: true,
      ),
      body: BlocBuilder<HistoryPageBloc, HistoryPageState>(
        bloc: _historyPageBloc,
        builder: (context, state) {
          if (state is HistoryPageLoaded) {
            if (state.heartRateList.isNotEmpty) {
              return HistoryPageWidget(
                heartRateList: state.heartRateList,
                historyPageBloc: _historyPageBloc,
              );
            }
          }
          if (state is HistoryPageLoadingFailure) {
            return HistoryPageErrorWidget(exception: state.exception);
          }
          return const Center(child: Text('No Data'));
        },
      ),
    );
  }
}
