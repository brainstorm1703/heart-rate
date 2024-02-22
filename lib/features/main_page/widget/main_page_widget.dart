import 'package:flutter/material.dart';

import 'package:heart_rate/features/main_page/bloc/main_page_bloc.dart';
import 'package:heart_rate/repository/models/heart_rate_model.dart';

class MainPageWidget extends StatelessWidget {
  const MainPageWidget({
    super.key,
    required this.heartRateList,
    required this.mainPageBloc,
  });
  final List<HeartRateModel> heartRateList;
  final MainPageBloc mainPageBloc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
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
                mainPageBloc.add(LoadMainPage());
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
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[850], // Закругление 10px
            ),
            child: TextButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed('/history');
                mainPageBloc.add(LoadMainPage());
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.history),
                  Padding(padding: EdgeInsets.all(16)),
                  Text(
                    'All History',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
