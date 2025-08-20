import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_mibienestarsena_711_v1/api/apiBienestar.dart';

void viewCreateAmbient(BuildContext context) {
  // Estados para manejar el formulario
  final nameController = TextEditingController();
  final usabilityController = TextEditingController();
  String selectedState = 'Activo'; // Valor predeterminado

  // Opciones para tipos de estado
  final stateOptions = [
    'Activo',
    'Inactivo',
    'En reparación',
    'En construcción',
    'Cerrado'
  ];

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,    // Maximizar toda la pantalla
    builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Crear Nuevo Ambiente'),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Campo para el nombre
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del Ambiente',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.room_preferences),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Campo para la usabilidad
              TextFormField(
                controller: usabilityController,
                decoration: const InputDecoration(
                  labelText: 'Usabilidad',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la usabilidad';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Campo Selector de estado
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Estado',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.flag),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedState,
                    isExpanded: true,
                    items: stateOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        selectedState = newValue;
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Botón para crear
              ElevatedButton(
                onPressed: () async {
                  // Validamos campos
                  if (nameController.text.isEmpty || usabilityController.text.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Todos los campos son obligatorios',
                      backgroundColor: Colors.red,
                      colorText: Colors.white
                    );
                    return;
                  }

                  try {
                    // Creamos el objeto con los datos
                    final newAmbient = {
                      'name': nameController.text,
                      'state': selectedState,
                      'usability': usabilityController.text,
                    };

                    // Llamamos a la funcion API para crear el ambiente | apiBienestar.dart
                    await fetchCreateAmbient(newAmbient);

                    // Cerrar el modal
                    Navigator.pop(context);

                    // Mostramos mensaje de éxito
                    Get.snackbar(
                      'Éxito',
                      'Ambiente creado correctamente',
                      backgroundColor: Colors.green,
                      colorText: Colors.white
                    );

                    // Actualizar la lista de ambientes
                    fetchAPIAmbients();

                  } catch (e) {
                    Get.snackbar(
                      'Error',
                      'Error al crear ambiente: ${e.toString()}',
                      backgroundColor: Colors.red,
                      colorText: Colors.white
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Crear Ambiente',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      );
    }
  );
}