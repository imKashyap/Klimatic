import 'package:flutter/material.dart';
import 'package:klimatic/screens/loading_screen.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Klimatic',
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}
