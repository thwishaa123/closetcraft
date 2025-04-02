import 'package:flutter/material.dart';
import 'add_closet.dart';

class ShoePage extends StatelessWidget {
  const ShoePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Shoes'),
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
          'Add your Shoes',
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
