import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<bool> login(String email, String pass) async {
    _loading = true;
    notifyListeners();

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      if (userCredential.user != null) {
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
      _error = e.message;
      notifyListeners();
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> signup(
      String email, String pass, String name, String gender) async {
    _loading = true;
    notifyListeners();

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      if (userCredential.user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': name,
          'email': email,
          'gender': gender,
          'style': {},
          'createdAt': Timestamp.now(),
        });

        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
      _error = e.message;
      notifyListeners();
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteAccount() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final user = _auth.currentUser;
      if (user == null) {
        _error = "No user is currently signed in";
        return false;
      }

      final uid = user.uid;
      final batch = FirebaseFirestore.instance.batch();

      // Delete user's closet items
      final closetQuery = await FirebaseFirestore.instance
          .collection('closet')
          .where('uid', isEqualTo: uid)
          .get();

      for (var doc in closetQuery.docs) {
        batch.delete(doc.reference);
      }

      // Delete user's events
      final eventQuery = await FirebaseFirestore.instance
          .collection('event')
          .where('uid', isEqualTo: uid)
          .get();

      for (var doc in eventQuery.docs) {
        batch.delete(doc.reference);
      }

      // Delete user's donations
      final donationsQuery = await FirebaseFirestore.instance
          .collection('donations')
          .where('uid', isEqualTo: uid)
          .get();

      for (var doc in donationsQuery.docs) {
        batch.delete(doc.reference);
      }

      // Delete user's profile data
      batch.delete(
        FirebaseFirestore.instance.collection('users').doc(uid),
      );

      // Execute all deletions in a batch
      await batch.commit();

      // Delete the Firebase Auth account
      await user.delete();

      return true;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuth Error: ${e.message}");
      if (e.code == 'requires-recent-login') {
        _error =
            "Please sign in again before deleting your account for security reasons.";
      } else {
        _error = e.message ?? "Failed to delete account";
      }
      notifyListeners();
      return false;
    } catch (e) {
      print("Error deleting account: $e");
      _error = "An unexpected error occurred while deleting your account";
      notifyListeners();
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
