import 'package:flutter/material.dart';
import 'package:flutter_tran/TranslateScreen.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        theme: ThemeData.dark().copyWith(
            primaryColor: Color(0xff000e20)
        ),
      home: TranslateScreen()
    );
  }
}


