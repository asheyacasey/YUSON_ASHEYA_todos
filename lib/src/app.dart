import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo_app/src/screens/login/auth_screen.dart';
import 'package:my_todo_app/src/screens/todos/todo_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp ({
    Key? key,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.soraTextTheme(
          Theme.of(context).textTheme,
        )
      ),
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
    );
  }
}