import 'package:flutter/material.dart';
import 'package:note_app/models/note_database..dart';
import 'package:note_app/pages/note_page.dart';
import 'package:note_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  //Initialize the database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();
  runApp(
    MultiProvider(
      providers: [
        //Note database provider
        ChangeNotifierProvider(create: (context) => NoteDatabase()),
        //Theme provider
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //remove debug banner
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const NotePage(),
    );
  }
}
