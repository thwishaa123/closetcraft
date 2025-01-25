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
        children: [

        ],
        

      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){},
        label: Text('Add your shirts',style: TextStyle(fontSize: 15),),
      ),
    );
  }
}
