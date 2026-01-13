import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pry_poliza/controller/poliza_controller.dart';
// Importación de controladores
import 'controller/propietario_controller.dart';
import 'controller/automovil_controller.dart';
import 'controller/seguro_controller.dart';
// Importación de temas y vistas
// import 'utils/themes/general_theme.dart';
import 'view/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PropietarioController()..fetchPropietarios(),
        ),
        ChangeNotifierProvider(
          create: (_) => AutomovilController()..fetchAutomoviles(),
        ),
        ChangeNotifierProvider(
          create: (_) => SeguroController(),
        ),
        ChangeNotifierProvider(create: (_) => PolizaController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Sistema de Seguros MVC",
        // theme: GeneralTheme.lightTheme,
        home: const MainNavigationScreen(),
      ),
    );
  }
}