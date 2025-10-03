import 'dart:developer';

import 'package:closet_craft_project/features/calendar/pages/outfit_event_form.dart';
import 'package:closet_craft_project/features/closet/pages/add_closet.dart';
import 'package:closet_craft_project/features/closet/provider/closet_provider.dart';
import 'package:closet_craft_project/utils/utils.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WardrobePage extends StatefulWidget {
  const WardrobePage(
      {super.key, required this.clothType, required this.clothingItems});

  final String clothType;
  final List<Map<String, dynamic>> clothingItems;

  @override
  State<WardrobePage> createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage> {
  // Method to get the properly formatted title
  String _getFormattedTitle() {
    return 'Your ${widget.clothType.substring(0, 1).toUpperCase()}${widget.clothType.substring(1)}';
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<ClosetProvider>().getAllClothFromCloset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getFormattedTitle(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: Consumer<ClosetProvider>(builder: (context, closetPro, _) {
        var clothingItems = closetPro.closetData
            .where((map) => map["cloth"] == widget.clothType)
            .toList();
        log(clothingItems.length.toString());

        if (!closetPro.loading) {
          return clothingItems.isEmpty
              ? _buildEmptyState(context)
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: clothingItems.length,
                    itemBuilder: (context, index) {
                      final doc = clothingItems[index];

                      return _buildClothingItem(context, doc);
                    },
                  ),
                );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'Wardrobe',
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCloset()),
          );
        },
        label: Text(
          'Add ${widget.clothType.substring(0, 1).toUpperCase()}${widget.clothType.substring(1)}',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
    );
  }

  // // Filter chip widget
  Widget _buildClothingItem(BuildContext context, Map<String, dynamic> data) {
    // Extract data from document
    // Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    String imageUrl = data['image'] ?? '';
    String fabric = data['fabric'] ?? 'Unknown Fabric';
    String color = data['color'] ?? 'N/A';
    String season = data['season'] ?? 'All Season';

    return GestureDetector(
      onTap: () {
        // Show item details
        _showItemDetails(context, data);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image container
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  color: Colors.grey[200],
                ),
                child: imageUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12)),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 48,
                                color: Colors.grey,
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      )
                    : const Center(
                        child: Icon(
                          Icons.image,
                          size: 48,
                          color: Colors.grey,
                        ),
                      ),
              ),
            ),

            // Item details
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Text(
                  //type,
                  //style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  //  fontSize: 16,
                  // ),
                  //maxLines: 1,
                  // overflow: TextOverflow.ellipsis,
                  // ),
                  const SizedBox(height: 4),
                  Text(
                    fabric,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: _getColorFromString(color),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        color,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      IconButton.filled(
                        onPressed: () {
                          // data['id'] = doc.id;
                          moveTo(context, OutfitEventForm(outfit: data));
                        },
                        icon: const Icon(Icons.add),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Empty state widget
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getIconForClothType(),
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 24),
          Text(
            'No ${widget.clothType.toLowerCase()} found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Add your first ${widget.clothType.toLowerCase()} to get started',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to get icon based on cloth type
  IconData _getIconForClothType() {
    switch (widget.clothType.toLowerCase()) {
      case 'shirts':
        return Icons.checkroom;
      case 'pants':
        return Icons.airline_seat_legroom_normal_outlined;
      case 'shoes':
        return Icons.workspace_premium;
      case 'accessories':
        return Icons.watch;
      default:
        return Icons.checkroom;
    }
  }

  // Helper method to convert color string to Color object
  Color _getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      case 'pink':
        return Colors.pink;
      case 'brown':
        return Colors.brown;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'grey':
      case 'gray':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  // Show filter options
  void _showItemDetails(BuildContext context, Map<String, dynamic> data) {
    // Extract data from document
    // Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    //String type = data['type'] ?? 'Unknown Type';
    String imageUrl = data['image'] ?? '';
    String fabric = data['fabric'] ?? 'Unknown Fabric';
    String color = data['color'] ?? 'N/A';
    String weather = data['weather'] ?? 'All Weather';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 8),
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),

                  // Image
                  Container(
                    height: 250,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: imageUrl.isNotEmpty
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Icon(
                              Icons.image,
                              size: 64,
                              color: Colors.grey,
                            ),
                          ),
                  ),

                  // Details
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          fabric,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Properties
                        Row(
                          children: [
                            _buildPropertyBadge('Season', weather),
                            const SizedBox(width: 12),
                            _buildPropertyBadge('Color', color,
                                colorIndicator: _getColorFromString(color)),
                          ],
                        ),

                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () {
                                // Edit item
                                Navigator.pop(context);
                                // TODO: Navigate to edit page
                              },
                              icon: const Icon(Icons.edit),
                              label: const Text('Edit'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.indigo,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                // Create outfit with this item
                                Navigator.pop(context);
                                // TODO: Navigate to create outfit page
                              },
                              icon: const Icon(Icons.checkroom),
                              label: const Text('Create Outfit'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Property badge widget
  Widget _buildPropertyBadge(String label, String value,
      {Color? colorIndicator}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (colorIndicator != null) ...[
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: colorIndicator,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Text(
            '$label: $value',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// // Search delegate for clothing items
// class ClothingSearchDelegate extends SearchDelegate {
//   final String clothType;

//   ClothingSearchDelegate({required this.clothType});

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return FutureBuilder<QuerySnapshot>(
//       future: FirebaseFirestore.instance
//           .collection('closet')
//           .where('cloth', isEqualTo: clothType)
//           .where('type', isGreaterThanOrEqualTo: query)
//           .where('type', isLessThanOrEqualTo: query + '\uf8ff')
//           .get(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
//                 const SizedBox(height: 16),
//                 Text(
//                   'No results found for "$query"',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }

//         return ListView.builder(
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: (context, index) {
//             final doc = snapshot.data!.docs[index];
//             final data = doc.data() as Map<String, dynamic>;

//             return ListTile(
//               leading: Container(
//                 width: 48,
//                 height: 48,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: data['imageUrl'] != null && data['imageUrl'].isNotEmpty
//                     ? ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.network(
//                           data['imageUrl'],
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return const Icon(Icons.image, color: Colors.grey);
//                           },
//                         ),
//                       )
//                     : const Icon(Icons.image, color: Colors.grey),
//               ),
//               title: Text(data['type'] ?? 'Unknown Type'),
//               subtitle: Text(data['fabric'] ?? 'Unknown Fabric'),
//               trailing: Container(
//                 width: 24,
//                 height: 24,
//                 decoration: BoxDecoration(
//                   color: _getColorFromString(data['color'] ?? 'grey'),
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.grey.shade300),
//                 ),
//               ),
//               onTap: () {
//                 close(context, null);
//                 // Navigate to item details or do something with the selected item
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return FutureBuilder<QuerySnapshot>(
//       future: FirebaseFirestore.instance
//           .collection('closet')
//           .where('cloth', isEqualTo: clothType)
//           .limit(5)
//           .get(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.search, size: 64, color: Colors.grey[400]),
//                 const SizedBox(height: 16),
//                 Text(
//                   'Search your ${clothType.toLowerCase()}',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }

//         return ListView.builder(
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: (context, index) {
//             final doc = snapshot.data!.docs[index];
//             final data = doc.data() as Map<String, dynamic>;

//             return ListTile(
//               leading: Container(
//                 width: 48,
//                 height: 48,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: data['imageUrl'] != null && data['imageUrl'].isNotEmpty
//                     ? ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.network(
//                           data['imageUrl'],
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return const Icon(Icons.image, color: Colors.grey);
//                           },
//                         ),
//                       )
//                     : const Icon(Icons.image, color: Colors.grey),
//               ),
//               title: Text(data['type'] ?? 'Unknown Type'),
//               subtitle: Text(data['fabric'] ?? 'Unknown Fabric'),
//               trailing: Container(
//                 width: 24,
//                 height: 24,
//                 decoration: BoxDecoration(
//                   color: _getColorFromString(data['color'] ?? 'grey'),
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.grey.shade300),
//                 ),
//               ),
//               onTap: () {
//                 query = data['type'] ?? '';
//                 showResults(context);
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   Color _getColorFromString(String colorName) {
//     switch (colorName.toLowerCase()) {
//       case 'red':
//         return Colors.red;
//       case 'blue':
//         return Colors.blue;
//       case 'green':
//         return Colors.green;
//       case 'yellow':
//         return Colors.yellow;
//       case 'orange':
//         return Colors.orange;
//       case 'purple':
//         return Colors.purple;
//       case 'pink':
//         return Colors.pink;
//       case 'brown':
//         return Colors.brown;
//       case 'black':
//         return Colors.black;
//       case 'white':
//         return Colors.white;
//       case 'grey':
//       case 'gray':
//         return Colors.grey;
//       default:
//         return Colors.grey;
//     }
//   }
// }
