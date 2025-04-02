import 'package:flutter/material.dart';

class FabricPage extends StatefulWidget {
  const FabricPage({super.key});

  @override
  State<FabricPage> createState() => _FabricPageState();
}

class _FabricPageState extends State<FabricPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Outfit Based on Fabric"),
      ),
    );
  }
}
