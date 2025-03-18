import 'package:flutter/material.dart';
import 'package:proyecto_uml/view/sidebar/sidebar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  Widget _selectedContent = Center(child: Text('Consejo superior', style: TextStyle(fontSize: 24)));

  void _updateContent(Widget content) {
    setState(() {
      _selectedContent = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Row(
          children: [
            Sidebar(onItemSelected: _updateContent),
            Expanded(child: _selectedContent),
          ],
        ),
      ),
    );
  }
}
