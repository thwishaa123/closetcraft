import 'dart:developer';

import 'package:closet_craft_project/features/calendar/pages/outfit_event_detail.dart';
import 'package:closet_craft_project/features/calendar/pages/outfit_event_form.dart';
import 'package:closet_craft_project/features/calendar/provider/outfit_event_provider.dart';
import 'package:closet_craft_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    final res = context.read<OutfitEventProvider>().filterEvents(day);
    log(context.read<OutfitEventProvider>().filteredEvents.length.toString());
    setState(() {
      _focusedDay = day;
    });
  }

  @override
  void initState() {
    // Future.microtask(() {
    //   context.read<OutfitEventProvider>().getOutfitEvent();
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Your Calendar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Calendar',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: TableCalendar(
                calendarFormat: CalendarFormat.week,
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(day, _focusedDay),
                onDaySelected: _onDaySelected,
                // onDisabledDayTapped: (day) {
                //   print(day.toString());
                // },
                focusedDay: _focusedDay,
                firstDay: DateTime.utc(2025, 1, 18),
                lastDay: DateTime.utc(2030, 12, 31),
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                calendarStyle: CalendarStyle(
                  selectedDecoration: const BoxDecoration(
                    color: Colors.indigo,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.indigo.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  weekendTextStyle: const TextStyle(color: Colors.red),
                  outsideDaysVisible: false,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Upcoming Events',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 16),
            Consumer<OutfitEventProvider>(builder: (context, provider, _) {
              // log(provider.allEvents.length.toString());
              return Expanded(
                child: provider.filteredEvents.isEmpty
                    ? const Center(child: Text('No Events Added'))
                    : ListView.separated(
                        itemCount: provider.filteredEvents.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              moveTo(
                                  context,
                                  EventDetailPage(
                                      event: provider.filteredEvents[index]));
                            },
                            child: _buildEventCard(
                              provider.filteredEvents[index]['name'],
                              DateFormat("MMM dd, yyyy").format(
                                provider.filteredEvents[index]['date'].toDate(),
                              ),
                              provider.filteredEvents[index]['description'],
                              Colors.indigo,
                            ),
                          );
                        },
                        // children: [
                        //   _buildEventCard(
                        //     'Casual Friday',
                        //     'March 31, 2025',
                        //     'Wear your best casual outfit',
                        //     Colors.indigo,
                        //   ),
                        //   const SizedBox(height: 12),
                        //   _buildEventCard(
                        //     'Weekend Shopping',
                        //     'April 2, 2025',
                        //     'Buy new clothes for spring',
                        //     Colors.green,
                        //   ),
                        //   const SizedBox(height: 12),
                        //   _buildEventCard(
                        //     'Business Meeting',
                        //     'April 5, 2025',
                        //     'Dress formal for client meeting',
                        //     Colors.orange,
                        //   ),
                        // ],
                      ),
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'Outfit Create',
        onPressed: () {
          moveTo(context, const OutfitEventForm());
        },
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEventCard(
      String title, String date, String description, Color accentColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 90,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
