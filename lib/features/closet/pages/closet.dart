import 'package:closet_craft_project/theme/theme.dart';
import 'package:flutter/material.dart';
import 'wardrobe.dart';
import 'add_closet.dart';

class ClosetPage extends StatelessWidget {
  const ClosetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Your Closet',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Categories',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo)),
              const SizedBox(height: 12),

              // Grid with smaller items (2x2)
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  _buildCategoryCard(
                    context,
                    'Shirts',
                    'Shirts',
                    'images/shirt.png',
                    const WardrobePage(
                      clothType: 'Shirt',
                    ),
                  ),
                  _buildCategoryCard(
                    context,
                    'T-Shirts',
                    'T-Shirts',
                    'images/tshirt.png',
                    const WardrobePage(
                      clothType: 'Tshirt',
                    ),
                  ),
                  _buildCategoryCard(
                    context,
                    'Bottom Wear',
                    'Pants',
                    'images/pants.png',
                    const WardrobePage(
                      clothType: 'Pant',
                    ),
                  ),
                  _buildCategoryCard(
                    context,
                    'Foot Wear',
                    'Shoes',
                    'images/shoes.jpg',
                    const WardrobePage(
                      clothType: 'Shoe',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const Text('Outfit Suggestions',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo)),
              const SizedBox(height: 12),

              // More compact outfit cards
              SizedBox(
                height: 140,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildOutfitCard(
                        'Casual Friday', '68°F', ['Blue', 'Black']),
                    const SizedBox(width: 12),
                    _buildOutfitCard(
                        'Weekend Style', '72°F', ['Grey', 'Green']),
                    const SizedBox(width: 12),
                    _buildOutfitCard(
                        'Business Meeting', '70°F', ['Black', 'White']),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, String type,
      String icon, Widget page) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => page)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 3))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset(icon, fit: BoxFit.contain),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                color: closetCategoryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
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
      // width: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 6,
            decoration: const BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        temp,
                        style:
                            const TextStyle(color: Colors.indigo, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Colors:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Row(
                  children: colors
                      .map((color) => Container(
                            margin: const EdgeInsets.only(right: 6),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(color,
                                style: const TextStyle(fontSize: 10)),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
