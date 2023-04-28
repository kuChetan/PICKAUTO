import 'package:flutter/material.dart';
import 'package:pickauto/screens/location_map_screen.dart';
import 'package:pickauto/screens/welcome_screen.dart';

void main() {
  runApp(const Pickauto());
}

class Pickauto extends StatelessWidget {
  const Pickauto({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark(),
      // home: const LoadingScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id:(context) => WelcomeScreen(),
        LocationMapScreen.id:(context) => LocationMapScreen(),
        
      },
      
    );
  }
}

