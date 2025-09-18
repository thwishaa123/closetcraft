import 'dart:developer';

import 'package:closet_craft_project/data/repo/cloudinary_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier {
  final bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, dynamic>? _user;
  Map<String, dynamic>? get user => _user;

  getProfileDetails() async {
    final res = await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();

    _user = res.data();
    _user!['id'] = res.id;
    log('getting profile data');
    notifyListeners();

    return res.data();
  }

  Future updateDetail(String key, dynamic value) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .update({key: value});

    getProfileDetails();
  }

  Future updateImage(XFile image) async {
    var res = await CloudinaryRepo().uploadToCloudinary(image);
    await updateDetail('image', res.toString());
  }
}
