import 'package:flutter/material.dart';
import 'shirt.dart';
import 'tshirt.dart';
import 'shoes.dart';
import 'pants.dart';

class ClosetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Closet'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Shirt image
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ShirtPage()),
                          );

      },
                        child: Image.asset(
                          'images/shirt.png',
                          width: 100.0,
                          height: 100.0,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('Shirt'),

                    ],
                  ),
                  SizedBox(height: 8,),



                  SizedBox(height: 8,),
                  // T-shirt image
                  Flexible(
                    child: Column(
                      children: [
                        Image.asset(
                          'images/tshirt.png',
                          width: 100.0,
                          height: 100.0,
                        ),
                        SizedBox(height: 8),
                        Text('T-Shirt'),
                        FloatingActionButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TShirtPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),


            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Pants image
                  Flexible(
                    child: Column(
                      children: [
                        Image.asset(
                          'images/pants.png',
                          width: 100.0,
                          height: 100.0,
                        ),
                        SizedBox(height: 8),
                        Text('Pants'),
                        FloatingActionButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PantsPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),


                  SizedBox(width: 20),
                  // Shoes image
                  Flexible(
                    child: Column(
                      children: [
                        Image.asset(
                          'images/shoes.jpg',
                          width: 100.0,
                          height: 100.0,
                        ),
                        SizedBox(height: 8),
                        Text('Shoes'),
                        FloatingActionButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShoePage()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ClosetPage(),
  ));
}
