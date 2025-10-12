import 'dart:developer';

import 'package:closet_craft_project/features/closet/provider/closet_provider.dart';
import 'package:closet_craft_project/features/closet/pages/donation_page.dart';
import 'package:closet_craft_project/features/closet/pages/instruction_page.dart';
import 'package:closet_craft_project/features/profile/provider/profile_provider.dart';
import 'package:closet_craft_project/utils/utils.dart';
import 'package:closet_craft_project/utils/responsive_utils.dart';
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
    final isIPhoneProMax = context.isIPhoneProMax;
    final isTabletOrLarger = context.isTabletOrLarger;

    return Scaffold(
      backgroundColor: lightestTeal,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: context.responsiveAppBarHeight,
        title: Text(
          'Your Closet',
          style: context.responsiveTextStyle(
            fontWeight: FontWeight.w600,
            fontSize: isIPhoneProMax ? 26 : (isTabletOrLarger ? 24 : 22),
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
              size: context.responsiveIconSize(28),
            ),
            tooltip: 'How to Use Re-Vastra',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.responsivePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Categories Section
              Text(
                'Categories',
                style: context.responsiveTextStyle(
                  fontSize: isIPhoneProMax ? 22 : (isTabletOrLarger ? 20 : 18),
                  fontWeight: FontWeight.w600,
                  color: darkTeal,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: context.responsiveSpacing(20)),

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
                            crossAxisCount:
                                context.responsiveGridCrossAxisCount,
                            childAspectRatio:
                                context.responsiveChildAspectRatio,
                            mainAxisSpacing: context.responsiveSpacing(16),
                            crossAxisSpacing: context.responsiveSpacing(16),
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
                            crossAxisCount:
                                context.responsiveGridCrossAxisCount,
                            childAspectRatio:
                                context.responsiveChildAspectRatio,
                            mainAxisSpacing: context.responsiveSpacing(16),
                            crossAxisSpacing: context.responsiveSpacing(16),
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

              SizedBox(height: context.responsiveSpacing(20)),

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
                    borderRadius:
                        BorderRadius.circular(context.responsiveSpacing(18)),
                  ),
                  child: Padding(
                    padding: context.responsiveCardPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.volunteer_activism,
                              color: Colors.deepPurple,
                              size: context.responsiveIconSize(36),
                            ),
                            SizedBox(width: context.responsiveSpacing(12)),
                            Expanded(
                              child: Text(
                                'Pass It On: Let Your Clothes Live Again',
                                style: context.responsiveTextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isIPhoneProMax
                                      ? 20
                                      : (isTabletOrLarger ? 18 : 16),
                                  color: Colors.deepPurple.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: context.responsiveSpacing(10)),
                        Text(
                          'ReVastra gives your wardrobe a second life—and keeps it out of landfills. Donate your gently used clothes to those in need or for responsible recycling.',
                          style: context.responsiveTextStyle(
                            fontSize: isIPhoneProMax
                                ? 17
                                : (isTabletOrLarger ? 16 : 15),
                            color: Colors.deepPurple.shade900,
                          ),
                        ),
                        SizedBox(height: context.responsiveSpacing(10)),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    context.responsiveSpacing(10)),
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
                            child: Text(
                              'Start Your Donation',
                              style: context.responsiveTextStyle(
                                fontSize: isIPhoneProMax ? 16 : 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
    final isIPhoneProMax = context.isIPhoneProMax;
    final isTabletOrLarger = context.isTabletOrLarger;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.responsiveSpacing(16)),
          boxShadow: [
            BoxShadow(
              color: darkTeal.withOpacity(0.08),
              blurRadius: context.responsiveSpacing(8),
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
                child: Image.asset(
                  icon,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Title Container
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: context.responsiveSpacing(12),
              ),
              decoration: BoxDecoration(
                color: mediumTeal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(context.responsiveSpacing(16)),
                  bottomRight: Radius.circular(context.responsiveSpacing(16)),
                ),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: context.responsiveTextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: isIPhoneProMax ? 17 : (isTabletOrLarger ? 16 : 15),
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
