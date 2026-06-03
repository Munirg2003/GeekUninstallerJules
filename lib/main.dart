import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/app_service.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppService(),
      child: const GeekUninstallerApp(),
    ),
  );
}

class GeekUninstallerApp extends StatelessWidget {
  const GeekUninstallerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geek Uninstaller 1.5.0.160',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'Segoe UI',
      ),
      home: const MainScreen(),
    );
  }
}
