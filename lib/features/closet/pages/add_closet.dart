import 'dart:developer';
import 'dart:io';
import 'package:closet_craft_project/data/repo/cloudinary_repo.dart';
import 'package:closet_craft_project/features/closet/provider/closet_provider.dart';
import 'package:closet_craft_project/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCloset extends StatefulWidget {
  const AddCloset({super.key});

  @override
  State<AddCloset> createState() => _AddClosetState();
}

class _AddClosetState extends State<AddCloset> {
  XFile? selectedImage;
  String? cloth;
  String? color;
  String? weather;
  String? fabric;
  bool isLoading = false;

  late final ClosetProvider closetProvider;
  @override
  void initState() {
    closetProvider = ClosetProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Add to Closet",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Selection Area
              Container(
                height: 200,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: selectedImage != null
                    ? kIsWeb
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              selectedImage!.path,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.file(
                              File(selectedImage!.path),
                              fit: BoxFit.cover,
                            ),
                          )
                    : InkWell(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          setState(() {
                            selectedImage = image;
                          });
                        },
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                size: 48,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Add Your Clothing Item',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),

              // Categories Section
              const Text(
                "Item Details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 16),

              // cloth type
              StylishDropdown(
                title: "Cloth",
                icon: Icons.checkroom,
                values: const ["Shirt", "Tshirt", "Pant", "Shoe"],
                onchange: (value) {
                  setState(() {
                    cloth = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Color Selection
              StylishDropdown(
                title: "Color",
                icon: Icons.color_lens,
                values: const [
                  "Blue",
                  "Red",
                  "Black",
                  "White",
                  "Grey",
                  "Green",
                  "Yellow",
                  "Pink",
                  "Beige",
                  "Purple",
                  "Brown"
                ],
                onchange: (value) {
                  setState(() {
                    color = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Weather Selection
              StylishDropdown(
                title: "Season",
                icon: Icons.wb_sunny,
                values: const ["Summer", "Winter", "Fall", "Spring"],
                onchange: (value) {
                  setState(() {
                    weather = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Fabric Selection
              StylishDropdown(
                title: "Fabric",
                icon: Icons.layers,
                values: const ["Cotton", "Wool", "Linen", "Lycra", "Rayon"],
                onchange: (value) {
                  setState(() {
                    fabric = value;
                  });
                },
              ),
              const SizedBox(height: 30),

              // Add Button
              ListenableBuilder(
                  listenable: closetProvider,
                  builder: (context, _) {
                    return SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: closetProvider.loading
                            ? null
                            : () async {
                                if (selectedImage == null ||
                                    color == null ||
                                    weather == null ||
                                    fabric == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Please complete all fields to continue"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }

                                final res =
                                    await closetProvider.addClothInCloset(
                                        selectedImage!,
                                        color!,
                                        weather!,
                                        fabric!);
                                if (context.mounted) {
                                  if (res) {
                                    showSnackBar(
                                        context, "Item added to your closet!");
                                  } else {
                                    showSnackBar(
                                        context, 'Smoething went Wrong!!');
                                  }
                                  Navigator.pop(context);
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: closetProvider.loading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text(
                                'ADD TO CLOSET',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

// Stylish Dropdown Component
class StylishDropdown extends StatefulWidget {
  const StylishDropdown({
    super.key,
    required this.values,
    required this.title,
    required this.onchange,
    required this.icon,
  });

  final List<String> values;
  final String title;
  final ValueChanged<String> onchange;
  final IconData icon;

  @override
  State<StylishDropdown> createState() => _StylishDropdownState();
}

class _StylishDropdownState extends State<StylishDropdown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
      child: Row(
        children: [
          Icon(
            widget.icon,
            color: Colors.indigo,
            size: 24,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              DropdownButton<String>(
                value: selectedValue,
                hint: Text(
                  "Select ${widget.title}",
                  style: const TextStyle(fontSize: 16),
                ),
                underline: const SizedBox(),
                icon: const Icon(Icons.arrow_drop_down),
                borderRadius: BorderRadius.circular(10),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                  if (newValue != null) {
                    widget.onchange(newValue);
                  }
                },
                items:
                    widget.values.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
