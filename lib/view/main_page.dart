import 'package:flutter/material.dart';
import 'propietario_page.dart';
import 'automovil_page.dart';
import 'poliza_page.dart';
import 'seguro_page.dart';
import '../model/automovil.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const PropietarioListPage(),
    const CrearPolizaPage(),
    const CrearAutoPage(),
    DetalleSeguroPage(automovil: Automovil(modelo: '', valor: 0, accidentes: 0)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Propietarios'),
          BottomNavigationBarItem(icon: Icon(Icons.note_add), label: 'Nueva Póliza'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'Autos'),
          BottomNavigationBarItem(icon: Icon(Icons.security), label: 'Seguros'),
        ],
      ),
    );
  }
}