import 'package:app_mibienestarsena_711_v2/api/apiBienestar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController descriptionController = TextEditingController();
final TextEditingController imageController = TextEditingController();

modalEditNewCategory(context, option, dynamic listItem) {
  // Creamos una clave global para el formulario | Para campo clave
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  showModalBottomSheet(
    isScrollControlled: true,
    context: context, 
    builder: (context) {
      if(option == "new") { 
        nameController.clear();   // Limpiar campos
        descriptionController.clear();   // Limpiar campos
        imageController.clear();   // Limpiar campos
      } else {
        nameController.text = listItem['name'] ?? 'Sin nombre';
        descriptionController.text = listItem['description'] ?? 'Sin descripción';
        imageController.text = listItem['image'] ?? 'Sin imagen';
      }

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Scaffold(
            appBar: AppBar(
              title: (option == "new") ? Text('Crear Nueva Categoría') : Text('Editar Categoría'),
              backgroundColor: (option == "new") ? Colors.green : Colors.blue,
              foregroundColor: Colors.white,
              centerTitle: true,     // Propiedad para centrar el titulo
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: (option == "new") ? Colors.green : Colors.blue,
              foregroundColor: Colors.white,
              child: Icon(option == "new" ? Icons.add : Icons.edit),
              onPressed: () async {
                // Validar formulario antes de proceder
                if (!_formKey.currentState!.validate()) {
                  Get.snackbar(
                    'Campos incompletos', 
                    'Por favor, complete todos los campos obligatorios',
                    colorText: Colors.white,
                    backgroundColor: Colors.orange
                  );
                  return;
                }
                
                if(option == "new") {
                  // Lógica para crear una nueva categoría
                  bool resp = await newCategoryApi(
                    nameController.text, 
                    descriptionController.text,
                    imageController.text,
                  );
                  Get.back();  // Cerrar el modal
                  if(resp) {
                    Get.snackbar(
                      'Mensaje', "Se ha añadido correctamente una nueva categoría", 
                      colorText: Colors.white,
                      backgroundColor: Colors.green
                    );
                  } else {
                      Get.snackbar(
                        'Mensaje', "Error al agregar la nueva categoría", 
                        colorText: Colors.white,
                        backgroundColor: Colors.red
                      );
                  }
                  
                } else {   
                  // En caso de editar la categoría
                  bool resp = await editCategoryApi(
                    listItem['id'],
                    nameController.text, 
                    descriptionController.text,
                    imageController.text,
                  );
                  Get.back();  // Cerrar el modal
                  if(resp) {
                    Get.snackbar(
                    'Mensaje', "Se ha editado correctamente la categoría", 
                    colorText: Colors.white,
                    backgroundColor: Colors.green
                    );
                  } else {
                      Get.snackbar(
                        'Mensaje', "Error al editar la categoría", 
                        colorText: Colors.white,
                        backgroundColor: Colors.red
                      );
                  }
                }
              },
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey, // Asignar la clave al formulario
                child: ListView(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Nombre de la Categoría *',
                        hintText: 'Ingrese nombre de la categoría',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                        if (value.length < 3) {
                          return 'El nombre debe tener al menos 3 caracteres';
                        }
                        if (value.length > 30) {
                          return 'El nombre no puede exceder 30 caracteres';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Descripción',
                        hintText: 'Ingrese descripción de la categoría',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        return null; // Campo opcional
                      },
                    ),
                    SizedBox(height: 16),

                    TextFormField(
                      controller: imageController,
                      decoration: InputDecoration(
                        labelText: 'URL de la Imagen',
                        hintText: 'Ingrese URL de la imagen',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        return null; // Campo opcional
                      },
                    ),
                    SizedBox(height: 16),

                    // Vista previa de la imagen si existe
                    if (imageController.text.isNotEmpty)
                      Column(
                        children: [
                          Text(
                            'Vista previa:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Image.network(
                            imageController.text,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Column(
                                children: [
                                  Icon(Icons.error_outline, color: Colors.red, size: 40),
                                  SizedBox(height: 4),
                                  Text(
                                    'Error al cargar la imagen',
                                    style: TextStyle(color: Colors.red, fontSize: 12),
                                  ),
                                ],
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        }
      );
    }
  );
}