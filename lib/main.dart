// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:provider/provider.dart';
//
// import 'models/todo_model.dart';
// import 'providers/todo_provider.dart';
// import 'providers/theme_provider.dart';
// import 'screens/todo_screen.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//
//   Hive.registerAdapter(TodoAdapter());
//   await Hive.openBox<Todo>('todos');
//
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => TodoProvider()),
//         ChangeNotifierProvider(create: (_) => ThemeProvider()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Todo App',
//       themeMode: themeProvider.themeMode,
//       theme: ThemeData(
//         brightness: Brightness.light,
//         primarySwatch: Colors.blue,
//       ),
//       darkTheme: ThemeData(
//         brightness: Brightness.dark,
//       ),
//       home: const TodoScreen(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'models/todo_model.dart';
import 'providers/todo_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/todo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive init
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>('todos');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        // AnimatedTheme for smooth transitions
        return AnimatedTheme(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          data: themeProvider.isDarkMode
              ? ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
            cardColor: const Color(0xFF1E1E1E),
            scaffoldBackgroundColor: const Color(0xFF121212),
          )
              : ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
            cardColor: Colors.white,
            scaffoldBackgroundColor: Colors.grey[100],
          ),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Todo App',
            themeMode: themeProvider.themeMode,
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.blue,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
            ),
            home: const TodoScreen(),
          ),
        );
      },
    );
  }
}

