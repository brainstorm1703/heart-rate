// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputHeartRateWidget extends StatefulWidget {
  final String whichHeartRateIndex;
  final int selectedNumber;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onSelectedNumberChanged;

  const InputHeartRateWidget({
    super.key,
    required this.whichHeartRateIndex,
    required this.selectedNumber,
    required this.minValue,
    required this.maxValue,
    required this.onSelectedNumberChanged,
  });

  @override
  State<InputHeartRateWidget> createState() => _InputHeartRateWidgetState();
}

class _InputHeartRateWidgetState extends State<InputHeartRateWidget> {
  late final FixedExtentScrollController _scrollController;
  late int _selectedNumber;
  @override
  void initState() {
    _selectedNumber = widget.selectedNumber - widget.minValue;
    _scrollController =
        FixedExtentScrollController(initialItem: _selectedNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[850], // Закругление 10px
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.whichHeartRateIndex),
          SizedBox(
            height: 200,
            width: 100,
            child: CupertinoPicker(
              scrollController: _scrollController,
              itemExtent: 75, // Высота каждого элемента
              onSelectedItemChanged: (int value) {
                setState(() {
                  _selectedNumber = value + widget.minValue;
                  widget.onSelectedNumberChanged(_selectedNumber);
                });
              },
              children: List.generate(
                widget.maxValue - widget.minValue,
                (i) => Align(
                  alignment: Alignment.center,
                  child: Text(
                    '${i + widget.minValue}',
                    style: const TextStyle(color: Colors.white, fontSize: 35),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
