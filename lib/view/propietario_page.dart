import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/propietario_controller.dart';
import '../model/propietario.dart';

class PropietarioListPage extends StatelessWidget {
  const PropietarioListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuchamos el controlador de propietarios
    final controller = context.watch<PropietarioController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestión de Propietarios"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showPropietarioForm(context, null),
        child: const Icon(Icons.person_add),
      ),
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : controller.propietarios.isEmpty
          ? const Center(child: Text("No hay propietarios registrados"))
          : ListView.builder(
        itemCount: controller.propietarios.length,
        itemBuilder: (context, index) {
          final propietario = controller.propietarios[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  propietario.nombre[0].toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text("${propietario.nombre} ${propietario.apellido}"),
              subtitle: Text("Edad: ${propietario.edad} años"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _showPropietarioForm(context, propietario),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => controller.eliminarPropietario(propietario.id!),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Formulario similar al de "Crear Póliza" para mantener la consistencia visual
  void _showPropietarioForm(BuildContext context, Propietario? propietario) {
    final isEditing = propietario != null;
    final nombreCtrl = TextEditingController(text: isEditing ? propietario.nombre : '');
    final apellidoCtrl = TextEditingController(text: isEditing ? propietario.apellido : '');
    final edadCtrl = TextEditingController(text: isEditing ? propietario.edad.toString() : '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            top: 20, left: 20, right: 20
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isEditing ? "Editar Propietario" : "Nuevo Propietario",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nombreCtrl,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: apellidoCtrl,
              decoration: const InputDecoration(labelText: "Apellido"),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: edadCtrl,
              decoration: const InputDecoration(labelText: "Edad"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final nuevoPropietario = Propietario(
                    id: propietario?.id,
                    nombre: nombreCtrl.text,
                    apellido: apellidoCtrl.text,
                    edad: int.tryParse(edadCtrl.text) ?? 0,
                  );

                  bool success;
                  if (isEditing) {
                    success = await context.read<PropietarioController>()
                        .actualizarPropietario(propietario.id!, nuevoPropietario);
                  } else {
                    success = await context.read<PropietarioController>()
                        .crearPropietario(nuevoPropietario);
                  }

                  if (success) Navigator.pop(ctx);
                },
                child: Text(isEditing ? "ACTUALIZAR" : "REGISTRAR PROPIETARIO"),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}