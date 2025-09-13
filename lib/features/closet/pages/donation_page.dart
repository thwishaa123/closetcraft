import 'package:closet_craft_project/data/repo/cloudinary_repo.dart';
import 'package:closet_craft_project/features/closet/pages/donation_success_page.dart';
import 'package:closet_craft_project/utils/platform_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  String? clothingType;
  int? numberOfItems;
  String? donationMethod;
  String? pickupAddress;
  String? pickupContact;
  String? pickupIdProof;
  List<String> pickupImages = [];
  String? dropMedium;
  String? dropIdProof;
  List<String> dropImages = [];
  bool confirm = false;
  List<XFile> pickedImages = [];
  final ImagePicker _picker = ImagePicker();
  bool isSubmitting = false;

  final _formKey = GlobalKey<FormState>();
  final CloudinaryRepo _cloudinaryRepo = CloudinaryRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donate Clothes'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pass It On: Let Your Clothes Live Again',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'ReVastra gives your wardrobe a second life—and keeps it out of landfills.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Card(
                color: Colors.deepPurple.shade50,
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Did You Know?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple)),
                      SizedBox(height: 4),
                      Text(
                          'Every year, the world throws away ~92 million tonnes of textile waste—about one garbage truck every second. Re-Vastra is your easy, one-stop platform to change that: list your clothes, choose pickup or drop-off, and ensure they’re reused or responsibly recycled.'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                  'NGO Partner: The Creative Thinkers Forum (TCTF India)',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Text(
                  'Basti Vikas Kendra, Opp. C160, Okhla, Phase 1, New Delhi-110020'),
              const Text('Contact: 09136173177'),
              const SizedBox(height: 16),
              const Text('Donation Guidelines',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.deepPurple)),
              const SizedBox(height: 4),
              const Text(
                  '• Clothes must be clean, stain-free, tear-free, and wearable.'),
              const Text('• Wash, fold, and pack items in a sealed bag/box.'),
              const Text('• Include a list of items inside the package.'),
              const Text('• No used undergarments unless brand new with tags.'),
              const Text('• No wedding attire of the groom or bride.'),
              const Text(
                  '• Avoid items with strong odors, pet hair, or mildew.'),
              const Text('• Shoes: pair and secure them together.'),
              const Text('• Upload clear photos of items for pre-screening.'),
              const Text('• Keep a valid government ID ready.'),
              const Text(
                  '• If sending by courier, share the tracking number once dispatched.'),
              const Divider(height: 32),
              const Text('Donation Details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 12),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Clothing Item Type'),
                onChanged: (v) => clothingType = v,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Number of Items to be donated'),
                keyboardType: TextInputType.number,
                onChanged: (v) => numberOfItems = int.tryParse(v),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              const Text('Donation Method',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Radio<String>(
                    value: 'Pick at Doorstep',
                    groupValue: donationMethod,
                    onChanged: (v) => setState(() => donationMethod = v),
                  ),
                  const Text('Pick at Doorstep'),
                  Radio<String>(
                    value: 'Drop Yourself',
                    groupValue: donationMethod,
                    onChanged: (v) => setState(() => donationMethod = v),
                  ),
                  const Text('Drop Yourself'),
                ],
              ),
              if (donationMethod == 'Pick at Doorstep') ...[
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Pickup Address'),
                  onChanged: (v) => pickupAddress = v,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Contact Number'),
                  keyboardType: TextInputType.phone,
                  onChanged: (v) => pickupContact = v,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText:
                          'Valid ID Proof (Aadhar/Passport/Driver’s License)'),
                  onChanged: (v) => pickupIdProof = v,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 8),
                const Text('Upload Pictures of the Clothes (required)',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  icon: const Icon(Icons.photo_camera),
                  label: const Text('Upload Images'),
                  onPressed: _pickImages,
                ),
                if (pickedImages.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    children: pickedImages
                        .map((img) => PlatformImage(
                              path: img.path,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ))
                        .toList(),
                  ),
              ],
              if (donationMethod == 'Drop Yourself') ...[
                const SizedBox(height: 8),
                const Text(
                    'NGO Address: Basti Vikas Kendra, Opp. C160, Okhla, Phase 1, New Delhi-110020'),
                const Text('NGO Contact: 09136173177'),
                const SizedBox(height: 8),
                const Text('Medium of Donation',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Courier',
                      groupValue: dropMedium,
                      onChanged: (v) => setState(() => dropMedium = v),
                    ),
                    const Text('Courier'),
                    Radio<String>(
                      value: 'Self-drop',
                      groupValue: dropMedium,
                      onChanged: (v) => setState(() => dropMedium = v),
                    ),
                    const Text('Self-drop'),
                  ],
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText:
                          'Valid ID Proof (Aadhar/Passport/Driver’s License)'),
                  onChanged: (v) => dropIdProof = v,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 8),
                const Text('Upload Pictures of the Clothes (required)',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  icon: const Icon(Icons.photo_camera),
                  label: const Text('Upload Images'),
                  onPressed: _pickImages,
                ),
                const SizedBox(height: 8),
                if (pickedImages.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    children: pickedImages
                        .map((img) => PlatformImage(
                              path: img.path,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ))
                        .toList(),
                  ),
              ],
              const SizedBox(height: 16),
              CheckboxListTile(
                value: confirm,
                onChanged: (v) => setState(() => confirm = v ?? false),
                title: const Text('I confirm the information is correct'),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isSubmitting ? null : _submitDonation,
                  child: isSubmitting
                      ? const CircularProgressIndicator()
                      : const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImages() async {
    final images = await _picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      setState(() {
        pickedImages = images;
      });
    }
  }

  Future<List<String>> _uploadImagesToCloudinary() async {
    List<String> urls = [];
    for (final img in pickedImages) {
      final url = await _cloudinaryRepo.uploadToCloudinary(img);
      if (url != null) urls.add(url);
    }
    return urls;
  }

  Future<void> _submitDonation() async {
    if (!_formKey.currentState!.validate() || !confirm) return;
    setState(() => isSubmitting = true);
    final imageUrls = await _uploadImagesToCloudinary();
    final refId = 'DON-${DateTime.now().millisecondsSinceEpoch}';
    final data = {
      'clothingType': clothingType,
      'numberOfItems': numberOfItems,
      'donationMethod': donationMethod,
      'pickupAddress': pickupAddress,
      'pickupContact': pickupContact,
      'pickupIdProof': pickupIdProof,
      'dropMedium': dropMedium,
      'dropIdProof': dropIdProof,
      'imageUrls': imageUrls,
      'referenceId': refId,
      'uid': FirebaseAuth.instance.currentUser?.uid,
      'createdAt': FieldValue.serverTimestamp(),
    };
    await FirebaseFirestore.instance.collection('donations').add(data);
    setState(() => isSubmitting = false);
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DonationSuccessPage(
            referenceId: refId,
            method: donationMethod,
          ),
        ),
      );
    }
  }
}
