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

  addClothInCloset(
      XFile image, String color, String weather, String fabric) async {
    _loading = true;
    notifyListeners();

    final imageUrl = await CloudinaryRepo().uploadToCloudinary(image);
    try {
      await FirebaseFirestore.instance.collection('closet').add({
        'image': imageUrl,
        'color': color,
        'weather': weather,
        'fabric': fabric,
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'dateAdded': DateTime.now(),
      });

      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text("Item added to your closet!"),
      //     backgroundColor: Colors.green,
      //   ),
      // );
      // Navigator.pop(context);
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text("Error: ${e.toString()}"),
      //     backgroundColor: Colors.red,
      //   ),
      // );
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
