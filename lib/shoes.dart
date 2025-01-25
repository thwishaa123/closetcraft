import 'package:flutter/material.dart';


class ShoePage extends StatelessWidget {
  const ShoePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Shoes'),

      ),
      body: Column(
        children: [

        ],


      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){},
        label: Text('Add your shoes',style: TextStyle(fontSize: 15),),
      ),
    );
  }
}
