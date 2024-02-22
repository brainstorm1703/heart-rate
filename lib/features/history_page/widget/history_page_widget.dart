// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:heart_rate/features/history_page/bloc/history_page_bloc.dart';
import 'package:heart_rate/repository/models/heart_rate_model.dart';

class HistoryPageWidget extends StatelessWidget {
  const HistoryPageWidget({
    super.key,
    required this.heartRateList,
    required this.historyPageBloc,
  });
  final List<HeartRateModel> heartRateList;
  final HistoryPageBloc historyPageBloc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.separated(
      itemCount: heartRateList.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final heartRate = heartRateList[index];
        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).pushNamed(
              '/heart_rate',
              arguments: heartRate,
            );
            historyPageBloc.add(LoadHistoryPage());
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[850], // Закругление 10px
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        heartRate.systolic.toString(),
                        style: theme.textTheme.bodyMedium,
                      ),
                      Text(
                        heartRate.diastolic.toString(),
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.green,
                    thickness: 10,
                  ),
                  Column(
                    children: [
                      Text(
                        '${heartRate.time}, ${heartRate.date}',
                        style: theme.textTheme.bodyMedium,
                      ),
                      Text(
                        'Pulse: ${heartRate.pulse} BMP',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
