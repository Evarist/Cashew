import 'package:budget/widgets/textWidgets.dart';
import 'package:flutter/material.dart';
import '../colors.dart';

class DropdownSelect extends StatefulWidget {
  final String initial;
  final List<String> items;
  final Function(String) onChanged;

  const DropdownSelect({
    Key? key,
    required this.initial,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<DropdownSelect> createState() => _DropdownSelectState();
}

class _DropdownSelectState extends State<DropdownSelect> {
  String? currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 6, top: 12, bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.lightDarkAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        underline: Container(),
        style:
            TextStyle(color: Theme.of(context).colorScheme.black, fontSize: 15),
        dropdownColor: Theme.of(context).colorScheme.lightDarkAccent,
        isDense: true,
        value: currentValue ?? widget.initial,
        elevation: 15,
        iconSize: 32,
        borderRadius: BorderRadius.circular(10),
        icon: Icon(Icons.arrow_drop_down_rounded),
        onChanged: (String? value) {
          widget.onChanged(value ?? widget.items[0]);
          setState(() {
            currentValue = value;
          });
        },
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem(
            child: TextFont(
              text: value,
            ),
            value: value,
          );
        }).toList(),
      ),
    );
  }
}