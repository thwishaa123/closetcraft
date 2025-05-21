import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class OutfitEventProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  List<Map<String, dynamic>> _allEvents = [];
  List<Map<String, dynamic>> get allEvents => _allEvents;

  List<Map<String, dynamic>> _filteredEvents = [];
  List<Map<String, dynamic>> get filteredEvents => _filteredEvents;

  getOutfitEvent() async {
    final res = await FirebaseFirestore.instance
        .collection('event')
        // .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    _allEvents = res.docs.map((event) => event.data()).toList();
    filterEvents(DateTime.now());
    notifyListeners();
    return _allEvents;
  }

  filterEvents(DateTime selectedDate) {
    _filteredEvents = _allEvents.where((e) {
      final eventDate = (e['date'] as Timestamp).toDate();
      return eventDate.year == selectedDate.year &&
          eventDate.month == selectedDate.month &&
          eventDate.day == selectedDate.day;
    }).toList();
    notifyListeners();
  }
}
