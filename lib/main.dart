import 'package:asbeza_app/app/configs.dart';
import 'package:asbeza_app/providers/CartProvider.dart';
import 'package:asbeza_app/providers/counter_provider.dart';
import 'package:asbeza_app/screens/Dashboard.dart';
import 'package:asbeza_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CountersProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Config.appName,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      home: const Dashboard(),
      routes: {'/finalOrderPage': (context) => const FinalOrderPage()},
    );
  }
}

/*
actions: [
        // This text button is used to intentionally throw an error when pressed
        // in order to test the error reporting for crashlytics.
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
          onPressed: () => throw Exception(),
          child: const Text("Throw Error"),
        ),
      ],
 */

class FinalOrderPage extends StatelessWidget {
  const FinalOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: Center(child: Text('Successfully order')),
    ));
  }
}
