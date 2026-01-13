import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/seguro_controller.dart';
import '../model/automovil.dart';

class DetalleSeguroPage extends StatefulWidget {
  final Automovil automovil;

  const DetalleSeguroPage({super.key, required this.automovil});

  @override
  State<DetalleSeguroPage> createState() => _DetalleSeguroPageState();
}

class _DetalleSeguroPageState extends State<DetalleSeguroPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final autoId = widget.automovil.id;
      if (autoId != null) {
        context.read<SeguroController>().fetchSeguroPorAutomovil(autoId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final seguroVM = context.watch<SeguroController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Resumen de Póliza")),
      body: seguroVM.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard("Automóvil", widget.automovil.modelo),
            _buildInfoCard("Accidentes", widget.automovil.accidentes.toString()),
            const Divider(height: 40),

            const Text("COSTO TOTAL DEL SEGURO",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),

            const SizedBox(height: 10),

            Text(
              seguroVM.seguroActual != null
                  ? "\$${seguroVM.seguroActual!.costoTotal.toStringAsFixed(2)}"
                  : "No calculado",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () => seguroVM.recalcularSeguro(widget.automovil.id!),
                child: const Text("RECALCULAR COSTO"),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("VOLVER"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.black54)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}