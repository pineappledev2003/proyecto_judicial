import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:proyecto_uml/view/home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(OKToast(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.rubikTextTheme(),
      ),
      home: Home(), 
    );

  }
}
