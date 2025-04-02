import 'package:closet_craft_project/add_closet.dart';
import 'package:flutter/material.dart';

class ShirtPage extends StatelessWidget {
  const ShirtPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Shirts'),
      ),
      body: Column(
        children: [],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddCloset()));
        },
        label: Text(
          'Add your shirts',
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
