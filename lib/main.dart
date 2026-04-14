import 'package:flutter/material.dart';
import 'inicio.dart';
import 'capturaempleados.dart';
import 'verempleados.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Empleados',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        primarySwatch: Colors.blue,
        useMaterial3: false,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/inicio',
      routes: {
        '/inicio': (context) => const Inicio(),
        '/captura': (context) => const CapturaEmpleados(),
        '/ver': (context) => const VerEmpleados(),
      },
    );
  }
}
