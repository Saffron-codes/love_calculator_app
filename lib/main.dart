import 'package:flutter/material.dart';
import 'package:love_calculator/presentation/pages/love_info_page.dart';
import 'injection_container.dart' as di;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(useMaterial3: true),
      title: 'Flutter Demo',
      theme: ThemeData.light(useMaterial3: true),
      home: const LoveInfoPage(),
    );
  }
}
