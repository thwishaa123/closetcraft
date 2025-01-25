import 'package:flutter/material.dart';


class TShirtPage extends StatelessWidget {
  const TShirtPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your TShirts'),

      ),
      body: Column(
        children: [

        ],


      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){},
        label: Text('Add your Tshirts',style: TextStyle(fontSize: 15),),
      ),
    );
  }
}
