import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_database/Provider/test_provider.dart';
import 'package:note_database/page/login_page.dart';
import 'package:note_database/src/DismissKeyboard.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => TestProvider()))
      ],
      child:  const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static const String title = 'Notes SQLite';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => DismissKeyboard(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          themeMode: ThemeMode.dark,
          theme: ThemeData(
            primaryColor: Colors.white54,
            scaffoldBackgroundColor: const Color(0xFF4C5C3C),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF587B2E),
              elevation: 0,
            ),
          ),
          home: const LoginPage(),
        ),
      );
}
