import 'package:closet_craft_project/features/closet/provider/closet_provider.dart';
import 'package:closet_craft_project/theme/theme.dart';
import 'package:closet_craft_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'wardrobe.dart';
import 'add_closet.dart';

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
              Consumer<ClosetProvider>(builder: (context, closetPro, _) {
                if (closetPro.closetData.isNotEmpty) {
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
                        const WardrobePage(clothType: 'Shirt'),
                      ),
                      _buildCategoryCard(
                        context,
                        'T-Shirts',
                        'assets/images/tshirt.png',
                        const WardrobePage(clothType: 'Tshirt'),
                      ),
                      _buildCategoryCard(
                        context,
                        'Bottom Wear',
                        'assets/images/pants.png',
                        const WardrobePage(clothType: 'Pant'),
                      ),
                      _buildCategoryCard(
                        context,
                        'Foot Wear',
                        'assets/images/shoes.jpg',
                        const WardrobePage(clothType: 'Shoe'),
                      ),
                    ],
                  );
                }
                return showLoading();
              }),

              const SizedBox(height: 32),

              // // Outfit Suggestions Section
              // Text(
              //   'Outfit Suggestions',
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.w600,
              //     color: darkTeal,
              //     letterSpacing: 0.5,
              //   ),
              // ),
              // const SizedBox(height: 20),

              // // Outfit Cards
              // SizedBox(
              //   height: 160,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: [
              //       _buildOutfitCard(
              //           'Casual Friday', '68°F', ['Blue', 'Black']),
              //       const SizedBox(width: 16),
              //       _buildOutfitCard(
              //           'Weekend Style', '72°F', ['Grey', 'Green']),
              //       const SizedBox(width: 16),
              //       _buildOutfitCard(
              //           'Business Meeting', '70°F', ['Black', 'White']),
              //       const SizedBox(width: 20), // Extra space at end
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 20),
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
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  icon,
                  fit: BoxFit.contain,
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

  Widget _buildOutfitCard(String title, String temp, List<String> colors) {
    return Container(
      width: 200,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top accent bar
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: lightTeal,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: darkTeal,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: paleTeal,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          temp,
                          style: TextStyle(
                            color: darkTeal,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Colors Section
                  Text(
                    'Colors',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: mediumTeal,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Color Tags
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: colors
                        .map((color) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: lightestTeal,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: paleTeal,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                color,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: mediumTeal,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
