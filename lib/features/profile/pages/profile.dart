import 'dart:developer';

import 'package:closet_craft_project/features/auth/pages/login.dart';
import 'package:closet_craft_project/features/closet/provider/closet_provider.dart';
import 'package:closet_craft_project/features/profile/provider/profile_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current user from Firebase Auth
    final User? user = FirebaseAuth.instance.currentUser;

    final String email = user?.email ?? 'No email';
    String favoriteStyle = 'Edit this'; // This would come from user preferences

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, provider, _) {
          if (provider.user != null) {
            List styleList = provider.user!['style']['Style Preferences'] ?? [];
            if (styleList.isNotEmpty) {
              favoriteStyle = styleList.first.toString();
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Avatar and Name

                    Center(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.indigo,
                                  foregroundImage: NetworkImage(
                                      provider.user!["image"].toString()),
                                  radius: 45.0,
                                  child: const Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () async {
                                      final ImagePicker picker = ImagePicker();
                                      final XFile? image =
                                          await picker.pickImage(
                                        source: ImageSource.gallery,
                                      );

                                      if (image == null) return;

                                      await provider.updateImage(image);
                                    },
                                    child: const CircleAvatar(
                                      radius: 15,
                                      child: Icon(
                                        Icons.edit,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            provider.user!["name"],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            email,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Account Info Section
                    const Text(
                      'Account Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Info Cards - More compact layout

                    _buildCompactInfoCard(
                      icon: Icons.calendar_today,
                      title: 'Member Since',
                      value: DateFormat("MMM dd, yyyy")
                          .format(provider.user!["createdAt"].toDate()),
                    ),
                    const SizedBox(height: 10),

                    Consumer<ClosetProvider>(builder: (context, closetPro, _) {
                      return _buildCompactInfoCard(
                        icon: Icons.checkroom,
                        title: 'Items',
                        value: closetPro.closetData.length.toString(),
                      );
                    }),
                    const SizedBox(height: 10),
                    _buildCompactInfoCard(
                        icon: Icons.style,
                        title: 'Favorite Style',
                        value: favoriteStyle,
                        onedit: () {
                          FavoriteStyleBottomSheet.show(
                            context,
                            initialSelectedStyles: provider.user!["style"],
                            onSaveStyles: (newStyles) async {
                              await provider.updateDetail('style', newStyles);
                              // Show confirmation
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Style preferences saved!'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                            },
                          );
                        }),

                    const SizedBox(height: 20),

                    // Quick Actions Section
                    // const Text(
                    //   'Quick Actions',
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.indigo,
                    //   ),
                    // ),
                    // const SizedBox(height: 10),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: _buildActionButton(
                    //         icon: Icons.add,
                    //         label: 'Add Item',
                    //         onPressed: () {
                    //           // Add item functionality
                    //         },
                    //       ),
                    //     ),
                    //     const SizedBox(width: 10),
                    //     Expanded(
                    //       child: _buildActionButton(
                    //         icon: Icons.favorite,
                    //         label: 'Favorites',
                    //         onPressed: () {
                    //           // View favorites functionality
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    // const SizedBox(height: 20),

                    // Sign Out Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                (route) => false);
                          }
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text('Sign Out'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildCompactInfoCard({
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onedit,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.indigo.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.indigo,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          if (onedit != null)
            IconButton(onPressed: onedit, icon: const Icon(Icons.edit))
        ],
      ),
    );
  }

  // Widget _buildActionButton({
  //   required IconData icon,
  //   required String label,
  //   required VoidCallback onPressed,
  // }) {
  //   return ElevatedButton.icon(
  //     onPressed: onPressed,
  //     icon: Icon(icon, size: 18),
  //     label: Text(label),
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: Colors.indigo,
  //       foregroundColor: Colors.white,
  //       padding: const EdgeInsets.symmetric(vertical: 10),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //     ),
  //   );
  // }
}

class FavoriteStyleBottomSheet extends StatefulWidget {
  final Map<String, dynamic> initialSelectedStyles;
  final Function(Map<String, dynamic>) onSaveStyles;

  const FavoriteStyleBottomSheet({
    super.key,
    required this.initialSelectedStyles,
    required this.onSaveStyles,
  });

  @override
  State<FavoriteStyleBottomSheet> createState() =>
      _FavoriteStyleBottomSheetState();

  static void show(
    BuildContext context, {
    required Map<String, dynamic> initialSelectedStyles,
    required Function(Map<String, dynamic>) onSaveStyles,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FavoriteStyleBottomSheet(
        initialSelectedStyles: initialSelectedStyles,
        onSaveStyles: onSaveStyles,
      ),
    );
  }
}

class _FavoriteStyleBottomSheetState extends State<FavoriteStyleBottomSheet> {
  late Map<String, dynamic> selectedStyles;

  final Map<String, dynamic> styleCategories = {
    'Tops': [
      'T-Shirts',
      'Shirts',
      'Blouses',
      'Tank Tops',
      'Hoodies',
      'Sweaters',
      'Cardigans',
      'Blazers',
    ],
    'Bottoms': [
      'Jeans',
      'Chinos',
      'Shorts',
      'Skirts',
      'Dress Pants',
      'Leggings',
      'Joggers',
      'Cargo Pants',
    ],
    'Dresses': [
      'Casual',
      'Formal',
      'Maxi',
      'Mini',
      'Midi',
      'A-Line',
      'Bodycon',
      'Wrap',
    ],
    'Outerwear': [
      'Jackets',
      'Coats',
      'Blazers',
      'Vests',
      'Windbreakers',
      'Leather Jackets',
      'Denim Jackets',
      'Parkas',
    ],
    'Footwear': [
      'Sneakers',
      'Boots',
      'Sandals',
      'Heels',
      'Flats',
      'Loafers',
      'Athletic',
      'Formal',
    ],
    'Style Preferences': [
      'Casual',
      'Formal',
      'Business',
      'Sporty',
      'Bohemian',
      'Minimalist',
      'Vintage',
      'Streetwear',
    ],
  };

  @override
  void initState() {
    super.initState();
    selectedStyles = Map.from(widget.initialSelectedStyles);

    // Initialize empty lists for categories not in initial data
    for (var category in styleCategories.keys) {
      selectedStyles.putIfAbsent(category, () => []);
    }
  }

  void toggleStyle(var category, var style) {
    setState(() {
      if (selectedStyles[category]!.contains(style)) {
        selectedStyles[category]!.remove(style);
      } else {
        selectedStyles[category]!.add(style);
      }
    });
  }

  void saveAndClose() {
    widget.onSaveStyles(selectedStyles);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Edit Favorite Styles',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select your favorite clothing styles and preferences:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),

                  ...styleCategories.entries.map((entry) {
                    return _buildCategorySection(entry.key, entry.value);
                  }),

                  const SizedBox(height: 100), // Space for save button
                ],
              ),
            ),
          ),

          // Save button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: saveAndClose,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save Preferences',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(String category, List<String> styles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            category,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: styles.map((style) {
            final isSelected =
                selectedStyles[category]?.contains(style) ?? false;
            return GestureDetector(
              onTap: () => toggleStyle(category, style),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey[300]!,
                  ),
                ),
                child: Text(
                  style,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight:
                        isSelected ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
