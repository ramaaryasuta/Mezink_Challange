import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// screens
import 'package:mezink_challange/pages/home.dart';
import 'services/data_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataServices()),
        // add more provider here if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mezink Challange',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreens(),
        },
      ),
    );
  }
}
