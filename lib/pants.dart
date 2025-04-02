import 'package:flutter/material.dart';
import 'add_closet.dart';

class PantsPage extends StatelessWidget {
  const PantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Pants'),
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
          'Add your Pants',
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
