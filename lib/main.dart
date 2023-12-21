import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shop/screens/home.dart';
import 'package:flutter_shop/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (_) => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shop',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: const HomeScreen(),
    );
  }
}
