import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/poliza_controller.dart';
import '../model/poliza.dart';

class CrearPolizaPage extends StatefulWidget {
  const CrearPolizaPage({super.key});

  @override
  State<CrearPolizaPage> createState() => _CrearPolizaPageState();
}

class _CrearPolizaPageState extends State<CrearPolizaPage> {
  final _nombreCtrl = TextEditingController();
  final _valorCtrl = TextEditingController();
  final _accidentesCtrl = TextEditingController();

  String _modelo = 'Modelo A';
  int _edadBase = 18;

  @override
  Widget build(BuildContext context) {
    final polizaCtrl = context.watch<PolizaController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Crear Póliza")),
      body: polizaCtrl.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(controller: _nombreCtrl, decoration: const InputDecoration(labelText: "Propietario")),
            TextField(controller: _valorCtrl, decoration: const InputDecoration(labelText: "Valor del seguro"), keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            const Text("Modelo de auto:"),
            ...['Modelo A', 'Modelo B', 'Modelo C'].map((m) => RadioListTile(
              title: Text(m), value: m, groupValue: _modelo,
              onChanged: (v) => setState(() => _modelo = v!),
            )),
            const Text("Edad propietario:"),
            _buildEdadRadio("18-23", 18),
            _buildEdadRadio("23-55", 23),
            _buildEdadRadio("55+", 55),
            TextField(controller: _accidentesCtrl, decoration: const InputDecoration(labelText: "Número de accidentes"), keyboardType: TextInputType.number),
            const SizedBox(height: 30),
            SizedBox(width: double.infinity, child: ElevatedButton(
              onPressed: _enviar,
              child: const Text("GENERAR PÓLIZA"),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildEdadRadio(String label, int val) => RadioListTile<int>(
    title: Text(label), value: val, groupValue: _edadBase,
    onChanged: (v) => setState(() => _edadBase = v!),
  );

  void _enviar() async {
    final req = PolizaRequest(
      propietario: _nombreCtrl.text,
      edadPropietario: _edadBase,
      modeloAuto: _modelo,
      valorSeguroAuto: double.tryParse(_valorCtrl.text) ?? 0,
      accidentes: int.tryParse(_accidentesCtrl.text) ?? 0,
    );

    final success = await context.read<PolizaController>().generarPolizaCompleta(req);
    if (success && mounted) {
      _mostrarResultado(context);
    }
  }

  void _mostrarResultado(BuildContext context) {
    final res = context.read<PolizaController>().ultimaPoliza!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Póliza Generada"),
        content: Text("Cliente: ${res.nombreCompleto}\nCosto Total: \$${res.costoTotal}"),
        actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("OK"))],
      ),
    );
  }
}