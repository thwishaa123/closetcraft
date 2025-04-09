import 'package:flutter/material.dart';
import 'features/closet/pages/add_closet.dart';

class TShirtPage extends StatelessWidget {
  const TShirtPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your TShirts'),
      ),
      body: Column(
        children: [],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () async {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => AddCloset()));
      //   },
      //   label: Text(
      //     'Add your T-shirts',
      //     style: TextStyle(fontSize: 15),
      //   ),
      // ),
    );
  }
}
