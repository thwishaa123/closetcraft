import 'dart:developer';

import 'package:closet_craft_project/data/repo/cloudinary_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ClosetProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  Future<bool> addClothInCloset(XFile image, String color, String weather,
      String fabric, String cloth) async {
    _loading = true;
    notifyListeners();

    final imageUrl = await CloudinaryRepo().uploadToCloudinary(image);
    try {
      await FirebaseFirestore.instance.collection('closet').add({
        'cloth': cloth,
        'image': imageUrl,
        'color': color,
        'weather': weather,
        'fabric': fabric,
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'dateAdded': Timestamp.now(),
      });
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> _closetData = [];
  List<Map<String, dynamic>> get closetData => _closetData;
  Future<List<Map<String, dynamic>>> getAllClothFromCloset() async {
    _loading = true;
    notifyListeners();

    try {
      final res = await FirebaseFirestore.instance
          .collection('closet')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      final closet = res.docs.map((e) {
        var map = e.data();
        map['id'] = e.id;
        return map;
      }).toList();

      _closetData = closet;
      log(closet.length.toString());
      return _closetData;
    } catch (e) {
      _error = e.toString();
      return _closetData;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
