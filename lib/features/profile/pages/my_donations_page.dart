import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyDonationsPage extends StatelessWidget {
  const MyDonationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String? userEmail = FirebaseAuth.instance.currentUser?.email;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Donations'),
        backgroundColor: Colors.deepPurple,
      ),
      body: userEmail == null
          ? const Center(child: Text('Not logged in'))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('donations')
                  .where('uid',
                      isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(child: const Text('Smething went wrong!!'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No donations found.'));
                }
                final docs = snapshot.data!.docs;
                return ListView.separated(
                  itemCount: docs.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, i) {
                    final data = docs[i].data() as Map<String, dynamic>;
                    return ListTile(
                      leading: data['imageUrls'] != null &&
                              data['imageUrls'].isNotEmpty
                          ? Image.network(data['imageUrls'][0],
                              width: 50, height: 50, fit: BoxFit.cover)
                          : const Icon(Icons.volunteer_activism,
                              size: 40, color: Colors.deepPurple),
                      title: Text(data['clothingType'] ?? 'Clothes'),
                      subtitle: Text(
                          'Items: ${data['numberOfItems'] ?? '-'}\nMethod: ${data['donationMethod'] ?? '-'}'),
                      trailing: Text(data['referenceId'] ?? ''),
                    );
                  },
                );
              },
            ),
    );
  }
}
