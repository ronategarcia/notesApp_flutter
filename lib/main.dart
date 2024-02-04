import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_do_app/pages/login.dart';
import 'package:to_do_app/pages/note.dart';
import 'package:to_do_app/pages/signup.dart';
import 'package:to_do_app/pages/notes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Notes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: Colors.grey.shade800,
        ),
      ),
      initialRoute: 'login_screen',
      routes: {
        'login_screen': (context) => const LoginPage(),
        'signup_screen': (context) => const SignupPage(),
        'notes_screen': (context) => const NotesPage(),
        'note_screen': (context) => const NotePage()
      },
    );
  }
}
