import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:heart_rate/features/heart_rate_page/bloc/heart_rate_page_bloc.dart';
import 'package:heart_rate/features/heart_rate_page/widget/input_heart_rate_widget.dart';
import 'package:heart_rate/repository/abstract_heart_rate_repository.dart';
import 'package:heart_rate/repository/models/heart_rate_model.dart';

class HeartRatePageScreen extends StatefulWidget {
  const HeartRatePageScreen({super.key});

  @override
  State<HeartRatePageScreen> createState() => _HeartRatePageScreenState();
}

class _HeartRatePageScreenState extends State<HeartRatePageScreen> {
  HeartRateModel? heartRate;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _systolic = 135;
  int _diastolic = 85;
  int _pulse = 85;
  final _heartRatePageBloc =
      HeartRatePageBloc(GetIt.I<AbstractHeartRateRepository>());

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(
        args != null && args is HeartRateModel, 'You must provide String args');
    heartRate = args as HeartRateModel;
    if (heartRate!.systolic != 0) {
      _systolic = heartRate!.systolic;
      _diastolic = heartRate!.diastolic;
      _pulse = heartRate!.pulse;
      _selectedTime = TimeOfDay(
          hour: int.parse(heartRate!.time.split(':')[0]),
          minute: int.parse(heartRate!.time.split(':')[1]));
      _selectedDate = DateTime(
        int.parse(heartRate!.date.split('/')[2]),
        int.parse(heartRate!.date.split('/')[1]),
        int.parse(heartRate!.date.split('/')[0]),
      );
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Record'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatefulBuilder(
                  builder: (context, setState) => InputHeartRateWidget(
                    whichHeartRateIndex: 'Systolic\n(mmHg)',
                    selectedNumber: _systolic,
                    minValue: 50,
                    maxValue: 221,
                    onSelectedNumberChanged: (value) => setState(() {
                      _systolic = value;
                    }),
                  ),
                ),
                StatefulBuilder(
                  builder: (context, setState) => InputHeartRateWidget(
                    whichHeartRateIndex: 'Diastolic\n(mmHg)',
                    selectedNumber: _diastolic,
                    minValue: 20,
                    maxValue: 151,
                    onSelectedNumberChanged: (value) => setState(() {
                      _diastolic = value;
                    }),
                  ),
                ),
                StatefulBuilder(
                  builder: (context, setState) => InputHeartRateWidget(
                    whichHeartRateIndex: 'Pulse\n(BMP)',
                    selectedNumber: _pulse,
                    minValue: 20,
                    maxValue: 151,
                    onSelectedNumberChanged: (value) => setState(() {
                      _pulse = value;
                    }),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Date & Time',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[850], // Закругление 10px
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => _showDatePicker(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.date_range,
                            color: Colors.white,
                          ),
                          const Padding(padding: EdgeInsets.all(5)),
                          Text(
                              '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showTimePicker(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.timelapse,
                            color: Colors.white,
                          ),
                          const Padding(padding: EdgeInsets.all(5)),
                          Text('${_selectedTime.hour}:${_selectedTime.minute}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.utc(2022, 12, 31),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }

  void _showTimePicker(BuildContext context) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (selectedTime != null) {
      setState(() {
        _selectedTime = selectedTime;
      });
    }
  }

  Widget _buildButtons() {
    if (heartRate!.diastolic != 0) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Row(
            children: [
              SizedBox(
                height: 50,
                width: 100,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      return Colors.grey[850];
                    }),
                  ),
                  onPressed: () {
                    _heartRatePageBloc
                        .add(DeleteHeartRate(heartRate: heartRate!));
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: 100,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      return Colors.grey[850];
                    }),
                  ),
                  onPressed: () {
                    _heartRatePageBloc.add(
                      EditHeartRate(
                        oldHeartRate: heartRate!,
                        newHeartRate: HeartRateModel(
                          systolic: _systolic,
                          diastolic: _diastolic,
                          pulse: _pulse,
                          date:
                              '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                          time: '${_selectedTime.hour}:${_selectedTime.minute}',
                        ),
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Edit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            height: 50,
            width: 100,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  return Colors.grey[850];
                }),
              ),
              onPressed: () {
                _heartRatePageBloc.add(
                  AddHeartRate(
                      heartRate: HeartRateModel(
                    systolic: _systolic,
                    diastolic: _diastolic,
                    pulse: _pulse,
                    date:
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    time: '${_selectedTime.hour}:${_selectedTime.minute}',
                  )),
                );
                Navigator.of(context).pop();
              },
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
