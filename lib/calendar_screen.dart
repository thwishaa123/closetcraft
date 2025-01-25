import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime today = DateTime.now();
  void _OnDaySelected(DateTime day, DateTime focusedDay){
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('123'),
          Container(

              child: Center(
                child: TableCalendar(
                  rowHeight: 43,
                    availableGestures: AvailableGestures.all,
                    selectedDayPredicate: (day) => isSameDay(day, today) ,
                    onDaySelected: _OnDaySelected,

                    focusedDay: today,
                    firstDay: DateTime.utc(2025, 1,18),
                    lastDay: DateTime.utc(2030, 12,31)),
              ),
            ),

        ],
      ),

    );
  }
}


