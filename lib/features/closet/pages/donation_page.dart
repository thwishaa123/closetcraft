import 'package:closet_craft_project/data/repo/cloudinary_repo.dart';
import 'package:closet_craft_project/features/closet/pages/donation_success_page.dart';
import 'package:closet_craft_project/utils/platform_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Donate Clothes'),
        backgroundColor: const Color.fromARGB(255, 9, 184, 200),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 9, 184, 200),
                    Color.fromARGB(255, 40, 184, 198),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 32,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Pass It On: Let Your Clothes Live Again',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'ReVastra gives your wardrobe a second life—and keeps it out of landfills.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),

            // Main Content
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Did You Know Card
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color.fromARGB(255, 9, 184, 200)
                                  .withOpacity(0.1),
                              const Color.fromARGB(255, 40, 184, 198)
                                  .withOpacity(0.1),
                            ],
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.lightbulb_outline,
                                    color: Color.fromARGB(255, 9, 184, 200),
                                    size: 24,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Did You Know?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 9, 184, 200),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Every year, the world throws away ~92 million tonnes of textile waste—about one garbage truck every second. Re-Vastra is your easy, one-stop platform to change that: list your clothes, choose pickup or drop-off, and ensure they\'re reused or responsibly recycled.',
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // NGO Partner Info
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.handshake,
                                  color: const Color.fromARGB(255, 9, 184, 200),
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text(
                                        'NGO Partner: The Creative Thinkers Forum (TCTF India)',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Basti Vikas Kendra, Opp. C160, Okhla, Phase 1, New Delhi-110020',
                              style: TextStyle(fontSize: 14),
                            ),
                            const Text(
                              'Contact: 09136173177',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Guidelines Section
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.checklist,
                                  color: const Color.fromARGB(255, 9, 184, 200),
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Donation Guidelines',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 9, 184, 200),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildGuidelineItem(
                                'Clothes must be clean, stain-free, tear-free, and wearable.'),
                            _buildGuidelineItem(
                                'Wash, fold, and pack items in a sealed bag/box.'),
                            _buildGuidelineItem(
                                'Include a list of items inside the package.'),
                            _buildGuidelineItem(
                                'No used undergarments unless brand new with tags.'),
                            _buildGuidelineItem(
                                'No wedding attire of the groom or bride.'),
                            _buildGuidelineItem(
                                'Avoid items with strong odors, pet hair, or mildew.'),
                            _buildGuidelineItem(
                                'Shoes: pair and secure them together.'),
                            _buildGuidelineItem(
                                'Upload clear photos of items for pre-screening.'),
                            _buildGuidelineItem(
                                'Keep a valid government ID ready.'),
                            _buildGuidelineItem(
                                'If sending by courier, share the tracking number once dispatched.'),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Donation Details Section
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.edit_note,
                                color: const Color.fromARGB(255, 9, 184, 200),
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Donation Details',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Clothing Type Field
                          _buildModernTextField(
                            label: 'Clothing Item Type',
                            hint: 'e.g., T-shirts, Jeans, Dresses',
                            onChanged: (v) => clothingType = v,
                            validator: (v) =>
                                v == null || v.isEmpty ? 'Required' : null,
                            icon: Icons.checkroom,
                          ),

                          const SizedBox(height: 16),

                          // Number of Items Field
                          _buildModernTextField(
                            label: 'Number of Items',
                            hint: 'Enter quantity',
                            keyboardType: TextInputType.number,
                            onChanged: (v) => numberOfItems = int.tryParse(v),
                            validator: (v) =>
                                v == null || v.isEmpty ? 'Required' : null,
                            icon: Icons.numbers,
                          ),

                          const SizedBox(height: 20),

                          // Donation Method Section
                          const Text(
                            'Donation Method',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Radio Buttons with Cards
                          Row(
                            children: [
                              Expanded(
                                child: _buildMethodCard(
                                  'Pick at Doorstep',
                                  Icons.home,
                                  'We\'ll come to you',
                                  donationMethod == 'Pick at Doorstep',
                                  () => setState(() =>
                                      donationMethod = 'Pick at Doorstep'),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildMethodCard(
                                  'Drop Yourself',
                                  Icons.location_on,
                                  'Visit our center',
                                  donationMethod == 'Drop Yourself',
                                  () => setState(
                                      () => donationMethod = 'Drop Yourself'),
                                ),
                              ),
                            ],
                          ),
                          if (donationMethod == 'Pick at Doorstep') ...[
                            const SizedBox(height: 20),
                            _buildModernTextField(
                              label: 'Pickup Address',
                              hint: 'Enter your complete address',
                              onChanged: (v) => pickupAddress = v,
                              validator: (v) =>
                                  v == null || v.isEmpty ? 'Required' : null,
                              icon: Icons.location_on,
                            ),
                            const SizedBox(height: 16),
                            _buildModernTextField(
                              label: 'Contact Number',
                              hint: 'Your phone number',
                              keyboardType: TextInputType.phone,
                              onChanged: (v) => pickupContact = v,
                              validator: (v) =>
                                  v == null || v.isEmpty ? 'Required' : null,
                              icon: Icons.phone,
                            ),
                            const SizedBox(height: 16),
                            _buildModernTextField(
                              label: 'Valid ID Proof',
                              hint: 'Aadhar/Passport/Driver\'s License',
                              onChanged: (v) => pickupIdProof = v,
                              validator: (v) =>
                                  v == null || v.isEmpty ? 'Required' : null,
                              icon: Icons.badge,
                            ),
                            const SizedBox(height: 20),
                            _buildImageUploadSection(),
                          ],

                          if (donationMethod == 'Drop Yourself') ...[
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: const Color.fromARGB(
                                            255, 9, 184, 200),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Drop-off Location',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Basti Vikas Kendra, Opp. C160, Okhla, Phase 1, New Delhi-110020',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  const Text(
                                    'Contact: 09136173177',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Medium of Donation',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildMethodCard(
                                    'Courier',
                                    Icons.local_shipping,
                                    'Send by courier',
                                    dropMedium == 'Courier',
                                    () =>
                                        setState(() => dropMedium = 'Courier'),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildMethodCard(
                                    'Self-drop',
                                    Icons.person,
                                    'Visit personally',
                                    dropMedium == 'Self-drop',
                                    () => setState(
                                        () => dropMedium = 'Self-drop'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _buildModernTextField(
                              label: 'Valid ID Proof',
                              hint: 'Aadhar/Passport/Driver\'s License',
                              onChanged: (v) => dropIdProof = v,
                              validator: (v) =>
                                  v == null || v.isEmpty ? 'Required' : null,
                              icon: Icons.badge,
                            ),
                            const SizedBox(height: 20),
                            _buildImageUploadSection(),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Confirmation and Submit Section
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          CheckboxListTile(
                            value: confirm,
                            onChanged: (v) =>
                                setState(() => confirm = v ?? false),
                            title: const Text(
                              'I confirm the information is correct',
                              style: TextStyle(fontSize: 16),
                            ),
                            activeColor: const Color.fromARGB(255, 9, 184, 200),
                            contentPadding: EdgeInsets.zero,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: isSubmitting ? null : _submitDonation,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 9, 184, 200),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                              child: isSubmitting
                                  ? const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Text('Submitting...'),
                                      ],
                                    )
                                  : const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.send, size: 20),
                                        SizedBox(width: 8),
                                        Text(
                                          'Submit Donation',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidelineItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 9, 184, 200),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernTextField({
    required String label,
    required String hint,
    required Function(String) onChanged,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    required IconData icon,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color.fromARGB(255, 9, 184, 200)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 9, 184, 200),
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildMethodCard(
    String title,
    IconData icon,
    String subtitle,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 9, 184, 200).withOpacity(0.1)
              : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color.fromARGB(255, 9, 184, 200)
                : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? const Color.fromARGB(255, 9, 184, 200)
                  : Colors.grey.shade600,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? const Color.fromARGB(255, 9, 184, 200)
                    : Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: isSelected
                    ? const Color.fromARGB(255, 9, 184, 200)
                    : Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.photo_camera,
              color: const Color.fromARGB(255, 9, 184, 200),
              size: 20,
            ),
            const SizedBox(width: 8),
            const Text(
              'Upload Pictures of the Clothes',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Text(
              ' (required)',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
              style: BorderStyle.solid,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade50,
          ),
          child: InkWell(
            onTap: _pickImages,
            borderRadius: BorderRadius.circular(12),
            child: pickedImages.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        size: 40,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap to upload images',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${pickedImages.length} images selected',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: pickedImages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: PlatformImage(
                            path: pickedImages[index].path,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
        if (pickedImages.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            '${pickedImages.length} image(s) selected',
            style: TextStyle(
              color: const Color.fromARGB(255, 9, 184, 200),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _pickImages() async {
    final images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
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
