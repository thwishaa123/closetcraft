import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OutfitEventForm extends StatefulWidget {
  final Map<String, dynamic>? outfit;

  const OutfitEventForm({super.key, this.outfit});
  @override
  _OutfitEventFormState createState() => _OutfitEventFormState();
}

class _OutfitEventFormState extends State<OutfitEventForm> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  DateTime? _selectedDate;
  String? _description;
  String? _selectedCloth;
  List<String> _clothOptions = [
    'T-shirt',
    'Shirt',
    'Jeans',
    'Dress',
    'Suit',
    'Sweater'
  ];

  final eventnameController = TextEditingController();
  final eventDescController = TextEditingController();

  // Date picker function
  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 1)),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _submitForm(String clothId) async {
    if (_formKey.currentState!.validate() && _selectedDate != null
        // &&_selectedCloth != null
        ) {
      _formKey.currentState!.save();
      // Handle submission logic here
      await FirebaseFirestore.instance.collection('event').add({
        // 'uid': FirebaseAuth.instance.currentUser!.uid,
        'clothId': clothId,
        'name': eventnameController.text.trim(),
        'description': eventDescController.text.trim(),
        'date': Timestamp.fromDate(_selectedDate!),
        'createdAt': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event Saved Successfully!')));
      print(
          "Event: $_name, Date: $_selectedDate, Description: $_description, Cloth: $_selectedCloth");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please complete all fields')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Outfit Event')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name field
              if (widget.outfit != null)
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                  ),
                  child: widget.outfit!['image'].isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            widget.outfit!['image'],
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

              TextFormField(
                controller: eventnameController,
                decoration: const InputDecoration(labelText: 'Event Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter event name' : null,
                onSaved: (value) => _name = value,
              ),
              const SizedBox(height: 10),

              // Date field
              ListTile(
                title: Text(_selectedDate == null
                    ? 'Select Date'
                    : 'Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _pickDate(context),
              ),
              SizedBox(height: 10),

              // Description field
              TextFormField(
                controller: eventDescController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                onSaved: (value) => _description = value,
              ),
              SizedBox(height: 10),

              // Dropdown for cloth
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Select Cloth'),
                value: _selectedCloth,
                items: _clothOptions.map((cloth) {
                  return DropdownMenuItem(value: cloth, child: Text(cloth));
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedCloth = value);
                },
                validator: (value) =>
                    value == null ? 'Please select a cloth' : null,
              ),
              SizedBox(height: 20),

              // Submit button
              ElevatedButton(
                onPressed: () {
                  if (widget.outfit != null) _submitForm(widget.outfit!['id']);
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
