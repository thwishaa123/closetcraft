import 'package:flutter/material.dart';


class PantsPage extends StatelessWidget {
  const PantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Pants'),

      ),
      body: Column(
        children: [

        ],


      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){},
        label: Text('Add your Pants',style: TextStyle(fontSize: 15),),
      ),
    );
  }
}
