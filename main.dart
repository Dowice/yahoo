import 'package:flutter/material.dart';
import 'package:kahoot/homescreen.dart'; // Import the homescreen page
import 'package:kahoot/quiz_creator.dart'; // Import the quiz creator page

void main() {
  runApp(
    MaterialApp(
      home: const Homescreen(), // Set the home screen as the initial page
      // theme: ThemeData(
      //   brightness: Brightness.dark, // Dark theme for the app
      //   primaryColor: Colors.deepPurple, // Primary color
      //   accentColor: Colors.deepPurpleAccent, // Accent color
      //   buttonTheme: ButtonThemeData(
      //     buttonColor: Colors.deepPurple, // Default button color
      //     textTheme: ButtonTextTheme.primary, // Text color of buttons
      //   ),
      //   appBarTheme: AppBarTheme(
      //     backgroundColor: Colors.deepPurple, // App bar color
      //   ),
      // ),
      debugShowCheckedModeBanner: false, // Hide debug banner
      routes: {
        '/create': (context) => QuizCreatorPage(), // Route for QuizCreatorPage
        // Add other routes as needed
      },
    ),
  );
}
