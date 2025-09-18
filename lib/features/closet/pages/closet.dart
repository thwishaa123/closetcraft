import 'dart:developer';

import 'package:closet_craft_project/features/closet/provider/closet_provider.dart';
import 'package:closet_craft_project/features/closet/pages/donation_page.dart';
import 'package:closet_craft_project/features/closet/pages/instruction_page.dart';
import 'package:closet_craft_project/features/profile/provider/profile_provider.dart';
import 'package:closet_craft_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'wardrobe.dart';

class ClosetPage extends StatelessWidget {
  const ClosetPage({super.key});

  // Teal color palette constants
  static Color darkTeal = Colors.lightBlue.shade800;
  static Color mediumTeal = Colors.lightBlue.shade700;
  static Color lightTeal = Colors.lightBlue.shade500;
  static Color paleTeal = Colors.lightBlue.shade200;
  static Color lightestTeal = Colors.lightBlue.shade100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightestTeal,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Your Closet',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: darkTeal,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InstructionPage(),
                ),
              );
            },
            icon: Icon(
              Icons.help_outline,
              color: darkTeal,
              size: 28,
            ),
            tooltip: 'How to Use Re-Vastra',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Categories Section
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: darkTeal,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 20),

              // Categories Grid

              Consumer<ProfileProvider>(
                builder: (context, profilePro, _) {
                  if (profilePro.user != null) {
                    log(profilePro.user!['gender'].toString());
                    if (profilePro.user!['gender'] == 'Male') {
                      return Consumer<ClosetProvider>(
                        builder: (context, closetPro, _) {
                          var shirts = closetPro.closetData
                              .where((map) => map["cloth"] == "Shirt")
                              .toList();
                          var tshirts = closetPro.closetData
                              .where((map) => map["cloth"] == "Tshirt")
                              .toList();
                          var pants = closetPro.closetData
                              .where((map) => map["cloth"] == "Pant")
                              .toList();
                          var shoes = closetPro.closetData
                              .where((map) => map["cloth"] == "Shoe")
                              .toList();
                          return GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            childAspectRatio: 0.85,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            children: [
                              _buildCategoryCard(
                                context,
                                'Shirts',
                                'assets/images/shirt.png',
                                WardrobePage(
                                    clothType: 'Shirt', clothingItems: shirts),
                              ),
                              _buildCategoryCard(
                                context,
                                'T-Shirts',
                                'assets/images/tshirt.png',
                                WardrobePage(
                                    clothType: 'Tshirt',
                                    clothingItems: tshirts),
                              ),
                              _buildCategoryCard(
                                context,
                                'Bottom Wear',
                                'assets/images/pants.png',
                                WardrobePage(
                                    clothType: 'Pant', clothingItems: pants),
                              ),
                              _buildCategoryCard(
                                context,
                                'Foot Wear',
                                'assets/images/shoes.jpg',
                                WardrobePage(
                                    clothType: 'Shoe', clothingItems: shoes),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      return Consumer<ClosetProvider>(
                        builder: (context, closetPro, _) {
                          var tops = closetPro.closetData
                              .where((map) => map["cloth"] == "Top")
                              .toList();
                          var pants = closetPro.closetData
                              .where((map) => map["cloth"] == "Pant")
                              .toList();
                          var shorts = closetPro.closetData
                              .where((map) => map["cloth"] == "Short")
                              .toList();
                          var skirts = closetPro.closetData
                              .where((map) => map["cloth"] == "Skirt")
                              .toList();
                          var dresses = closetPro.closetData
                              .where((map) => map["cloth"] == "Dress")
                              .toList();
                          var activewear = closetPro.closetData
                              .where((map) => map["cloth"] == "Activewear")
                              .toList();
                          var accessories = closetPro.closetData
                              .where((map) => map["cloth"] == "Accessory")
                              .toList();
                          var footwear = closetPro.closetData
                              .where((map) => map["cloth"] == "Footwear")
                              .toList();

                          return GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            childAspectRatio: 0.85,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            children: [
                              _buildCategoryCard(
                                context,
                                'Tops',
                                'assets/images/female/tops.jpeg',
                                WardrobePage(
                                    clothType: 'Top', clothingItems: tops),
                              ),
                              _buildCategoryCard(
                                context,
                                'Pants',
                                'assets/images/female/pants.jpeg',
                                WardrobePage(
                                    clothType: 'Pant', clothingItems: pants),
                              ),
                              _buildCategoryCard(
                                context,
                                'Shorts',
                                'assets/images/female/shorts.jpeg',
                                WardrobePage(
                                    clothType: 'Short', clothingItems: shorts),
                              ),
                              _buildCategoryCard(
                                context,
                                'Skirts',
                                'assets/images/female/skirts.jpeg',
                                WardrobePage(
                                    clothType: 'Skirt', clothingItems: skirts),
                              ),
                              _buildCategoryCard(
                                context,
                                'Dresses',
                                'assets/images/female/dresses.jpeg',
                                WardrobePage(
                                    clothType: 'Dress', clothingItems: dresses),
                              ),
                              _buildCategoryCard(
                                context,
                                'Activewear',
                                'assets/images/female/activewear.jpeg',
                                WardrobePage(
                                    clothType: 'Activewear',
                                    clothingItems: activewear),
                              ),
                              _buildCategoryCard(
                                context,
                                'Accessories',
                                'assets/images/female/accessories.jpeg',
                                WardrobePage(
                                    clothType: 'Accessory',
                                    clothingItems: accessories),
                              ),
                              _buildCategoryCard(
                                context,
                                'Footwear',
                                'assets/images/female/footwear.jpeg',
                                WardrobePage(
                                    clothType: 'Footwear',
                                    clothingItems: footwear),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                  return showLoading();
                },
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DonationPage(),
                    ),
                  );
                },
                child: Card(
                  color: Colors.deepPurple.shade50,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.volunteer_activism,
                                color: Colors.deepPurple, size: 36),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Pass It On: Let Your Clothes Live Again',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.deepPurple.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'ReVastra gives your wardrobe a second life—and keeps it out of landfills. Donate your gently used clothes to those in need or for responsible recycling.',
                          style: TextStyle(
                              fontSize: 15, color: Colors.deepPurple.shade900),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DonationPage(),
                                ),
                              );
                            },
                            child: const Text('Start Your Donation'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, String title, String icon, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: darkTeal.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Image Container
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                // padding: const EdgeInsets.all(20),
                child: Image.asset(
                  icon,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Title Container
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: mediumTeal,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
