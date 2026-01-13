import 'package:flutter/material.dart';
import 'package:pry_poliza/view/seguro_page.dart';
import 'propietario_page.dart';
import 'automovil_page.dart';
import '../model/automovil.dart';


class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  // Lista de las 3 pestañas principales
  final List<Widget> _screens = [
    const PropietarioListPage(), 
    const CrearAutoPage(),
    DetalleSeguroPage(automovil: Automovil(modelo: '', valor: 0, accidentes: 0)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).primaryColor, // Color primario de tu esquema
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Propietarios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Nueva Póliza',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Mis Seguros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Mis Seguros',
          ),
        ],
      ),
    );
  }
}