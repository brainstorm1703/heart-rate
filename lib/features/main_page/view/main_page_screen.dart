import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:heart_rate/features/main_page/bloc/main_page_bloc.dart';
import 'package:heart_rate/features/main_page/widget/main_page_error_widget.dart';
import 'package:heart_rate/features/main_page/widget/main_page_widget.dart';
import 'package:heart_rate/repository/abstract_heart_rate_repository.dart';
import 'package:heart_rate/repository/models/heart_rate_model.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({super.key});

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  final _mainPageBloc = MainPageBloc(GetIt.I<AbstractHeartRateRepository>());

  @override
  void initState() {
    _mainPageBloc.add(LoadMainPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Pressure BPM Tracker'),
        centerTitle: true,
      ),
      body: BlocBuilder<MainPageBloc, MainPageState>(
        bloc: _mainPageBloc,
        builder: (context, state) {
          if (state is MainPageLoaded) {
            if (state.heartRateList.isNotEmpty) {
              return MainPageWidget(
                heartRateList: state.heartRateList,
                mainPageBloc: _mainPageBloc,
              );
            }
          }
          if (state is MainPageLoadingFailure) {
            return MainPageErrorWidget(exception: state.exception);
          }
          return const Center(child: Text('No Data'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed(
            '/heart_rate',
            arguments: const HeartRateModel(
                systolic: 0, diastolic: 0, pulse: 0, date: '', time: ''),
          );
          _mainPageBloc.add(LoadMainPage());
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
