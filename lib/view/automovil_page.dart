import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/automovil_controller.dart';
import '../model/automovil.dart';

class CrearAutoPage extends StatefulWidget {
  const CrearAutoPage({super.key});

  @override
  State<CrearAutoPage> createState() => _CrearAutoPageState();
}

class _CrearAutoPageState extends State<CrearAutoPage> {
  // Controladores para los campos de texto
  final TextEditingController _propietarioCtrl = TextEditingController();
  final TextEditingController _valorCtrl = TextEditingController();
  final TextEditingController _accidentesCtrl = TextEditingController();

  // Variables para los Radio Buttons (según la imagen)
  String _modeloSeleccionado = 'Modelo A';
  String _edadSeleccionada = 'Mayor igual a 18 y menor a 23';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear Póliza"), // Título basado en la imagen
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo Propietario
            TextField(
              controller: _propietarioCtrl,
              decoration: const InputDecoration(labelText: "Propietario"),
            ),
            const SizedBox(height: 20),

            // Campo Valor del Seguro
            TextField(
              controller: _valorCtrl,
              decoration: const InputDecoration(labelText: "Valor del seguro"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Sección Modelo de auto (Radio Buttons)
            const Text("Modelo de auto:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            _buildRadioOption("Modelo A", _modeloSeleccionado, (val) => setState(() => _modeloSeleccionado = val!)),
            _buildRadioOption("Modelo B", _modeloSeleccionado, (val) => setState(() => _modeloSeleccionado = val!)),
            _buildRadioOption("Modelo C", _modeloSeleccionado, (val) => setState(() => _modeloSeleccionado = val!)),

            const SizedBox(height: 20),

            // Sección Edad del propietario (Radio Buttons)
            const Text("Edad propietario:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            _buildRadioOption("Mayor igual a 18 y menor a 23", _edadSeleccionada, (val) => setState(() => _edadSeleccionada = val!)),
            _buildRadioOption("Mayor igual a 23 y menor a 55", _edadSeleccionada, (val) => setState(() => _edadSeleccionada = val!)),
            _buildRadioOption("Mayor igual 55", _edadSeleccionada, (val) => setState(() => _edadSeleccionada = val!)),

            const SizedBox(height: 20),

            // Campo Número de accidentes
            TextField(
              controller: _accidentesCtrl,
              decoration: const InputDecoration(labelText: "Número de accidentes"),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 30),

            // Botón de Guardar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _guardarPoliza,
                child: const Text("GENERAR PÓLIZA"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para crear las opciones radiales
  Widget _buildRadioOption(String title, String groupValue, ValueChanged<String?> onChanged) {
    return RadioListTile<String>(
      title: Text(title, style: const TextStyle(fontSize: 14)),
      value: title,
      groupValue: groupValue,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }

  void _guardarPoliza() async {
    final controller = context.read<AutomovilController>();

    // Creamos el objeto basado en tu modelo Automovil
    final nuevoAuto = Automovil(
      modelo: _modeloSeleccionado,
      valor: double.tryParse(_valorCtrl.text) ?? 0.0,
      accidentes: int.tryParse(_accidentesCtrl.text) ?? 0,
      // Nota: En un sistema real, aquí enviarías el ID del propietario seleccionado
      propietarioId: 1,
    );

    bool success = await controller.crearAutomovil(nuevoAuto);

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Póliza generada con éxito"), backgroundColor: Colors.green),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error al generar póliza"), backgroundColor: Colors.red),
        );
      }
    }
  }
}