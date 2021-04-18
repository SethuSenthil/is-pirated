import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:is_pirated/is_pirated.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  IsPirated isPirated;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    IsPirated isPirated;
    try {
      isPirated = await getIsPirated(debugOverride: false);
    } on PlatformException {}

    if (!mounted) return;

    setState(() => this.isPirated = isPirated);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Is Pirated'),
        ),
        body: Center(
          child: Text(
            'This app is $isPirated',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
