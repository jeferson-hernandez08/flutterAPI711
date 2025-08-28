import 'package:app_mibienestarsena_711_v2/api/apiBienestar.dart';
import 'package:app_mibienestarsena_711_v2/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Para formatear fechas

final TextEditingController nameController = TextEditingController();
final TextEditingController descriptionController = TextEditingController();
final TextEditingController starDateController = TextEditingController();
final TextEditingController endDateController = TextEditingController();
final TextEditingController categoryIdController = TextEditingController();
final TextEditingController stateController = TextEditingController();
final TextEditingController maxCapacityController = TextEditingController();
final TextEditingController userIdController = TextEditingController();

modalEditNewEvent(context, option, dynamic listItem) {
  // Creamos una clave global para el formulario | Para campo clave y campos obligatorios
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Variables para los valores seleccionados en los dropdowns y fechas
  String? selectedState;
  DateTime? selectedStarDate;
  DateTime? selectedEndDate;

  showModalBottomSheet(
    isScrollControlled: true,
    context: context, 
    builder: (context) {
      if(option == "new") { 
        nameController.clear();
        descriptionController.clear();
        starDateController.clear();
        endDateController.clear();
        categoryIdController.clear();
        stateController.clear();
        maxCapacityController.clear();
        userIdController.clear();
        selectedState = null;
        selectedStarDate = null;
        selectedEndDate = null;
      } else {
        nameController.text = listItem['name'] ?? 'Sin nombre';
        descriptionController.text = listItem['description'] ?? 'Sin descripción';
        categoryIdController.text = listItem['categoryId'].toString() ?? 'Sin categoría';
        stateController.text = listItem['state'] ?? 'Sin estado';
        maxCapacityController.text = listItem['maxCapacity'].toString() ?? '0';
        userIdController.text = listItem['userId'].toString() ?? 'Sin usuario';

        // Establecer valores para los dropdowns y fechas
        selectedState = listItem['state'] ?? null;
        
        // Procesar fechas si existen
        if (listItem['starDate'] != null) {
          try {
            selectedStarDate = DateTime.parse(listItem['starDate']);
            starDateController.text = DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedStarDate!);
          } catch (e) {
            starDateController.text = listItem['starDate'] ?? '';
          }
        }
        
        if (listItem['endDate'] != null) {
          try {
            selectedEndDate = DateTime.parse(listItem['endDate']);
            endDateController.text = DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedEndDate!);
          } catch (e) {
            endDateController.text = listItem['endDate'] ?? '';
          }
        }
      }

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          // 👇🏼 Capturar las categorías y usuarios solo si no están en memoria
          if (myReactController.getListCategories.isEmpty) {
            fetchAPICategories().then((_) {
              setState(() {});
            });
          }
          if (myReactController.getListUsers.isEmpty) {
            fetchAPIUsers().then((_) {
              setState(() {});
            });
          }

          // Función para mostrar el selector de fecha y hora
          Future<void> _selectDateTime(BuildContext context, bool isStartDate) async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: isStartDate ? selectedStarDate ?? DateTime.now() : selectedEndDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );

            if (pickedDate != null) {
              final TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );

              if (pickedTime != null) {
                final DateTime finalDateTime = DateTime(
                  pickedDate.year,
                  pickedDate.month,
                  pickedDate.day,
                  pickedTime.hour,
                  pickedTime.minute,
                );

                setState(() {
                  if (isStartDate) {
                    selectedStarDate = finalDateTime;
                    starDateController.text = DateFormat('yyyy-MM-dd HH:mm:ss').format(finalDateTime);
                  } else {
                    selectedEndDate = finalDateTime;
                    endDateController.text = DateFormat('yyyy-MM-dd HH:mm:ss').format(finalDateTime);
                  }
                });
              }
            }
          }

          return Scaffold(
            appBar: AppBar(
              title: (option == "new") ? Text('Crear Nuevo Evento') : Text('Editar Evento'),
              backgroundColor: (option == "new") ? Colors.green : Colors.blue,
              foregroundColor: Colors.white,
              centerTitle: true,
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
                  // Lógica para crear un nuevo evento
                  bool resp = await newEventApi(
                    nameController.text, 
                    descriptionController.text,
                    starDateController.text,
                    endDateController.text,
                    categoryIdController.text,
                    stateController.text,
                    maxCapacityController.text,
                    userIdController.text,
                  );
                  Get.back();
                  if(resp) {
                    Get.snackbar(
                      'Mensaje', "Se ha añadido correctamente un nuevo evento", 
                      colorText: Colors.white,
                      backgroundColor: Colors.green
                    );
                  } else {
                    Get.snackbar(
                      'Mensaje', "Error al agregar el nuevo evento", 
                      colorText: Colors.white,
                      backgroundColor: Colors.red
                    );
                  }
                  
                } else {   
                  // En caso de editar el evento
                  bool resp = await editEventApi(
                    listItem['id'],
                    nameController.text, 
                    descriptionController.text,
                    starDateController.text,
                    endDateController.text,
                    categoryIdController.text,
                    stateController.text,
                    maxCapacityController.text,
                    userIdController.text,
                  );
                  Get.back();
                  if(resp) {
                    Get.snackbar(
                      'Mensaje', "Se ha editado correctamente el evento", 
                      colorText: Colors.white,
                      backgroundColor: Colors.green
                    );
                  } else {
                    Get.snackbar(
                      'Mensaje', "Error al editar el evento", 
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
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Nombre del Evento *',
                        hintText: 'Ingrese nombre del evento',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                        return null;
                      },
                    ),

                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Descripción *',
                        hintText: 'Ingrese descripción del evento',
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                        return null;
                      },
                    ),

                    // Campo de fecha y hora de inicio
                    TextFormField(
                      controller: starDateController,
                      decoration: InputDecoration(
                        labelText: 'Fecha y Hora de Inicio *',
                        hintText: 'Seleccione fecha y hora de inicio',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => _selectDateTime(context, true),
                        ),
                      ),
                      readOnly: true,
                      onTap: () => _selectDateTime(context, true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                        return null;
                      },
                    ),

                    // Campo de fecha y hora de fin
                    TextFormField(
                      controller: endDateController,
                      decoration: InputDecoration(
                        labelText: 'Fecha y Hora de Fin *',
                        hintText: 'Seleccione fecha y hora de fin',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => _selectDateTime(context, false),
                        ),
                      ),
                      readOnly: true,
                      onTap: () => _selectDateTime(context, false),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 16),

                    // Dropdown para Estado
                    DropdownButtonFormField<String>(
                      value: selectedState,
                      decoration: InputDecoration(
                        labelText: 'Estado del Evento *',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      ),
                      hint: Text('Seleccione el estado'),
                      items: [
                        DropdownMenuItem(
                          value: 'activo',
                          child: Text('Activo'),
                        ),
                        DropdownMenuItem(
                          value: 'inactivo',
                          child: Text('Inactivo'),
                        ),
                        DropdownMenuItem(
                          value: 'cancelado',
                          child: Text('Cancelado'),
                        ),
                        DropdownMenuItem(
                          value: 'completado',
                          child: Text('Completado'),
                        ),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedState = newValue;
                          stateController.text = newValue ?? '';
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 16),

                    TextFormField(
                      controller: maxCapacityController,
                      decoration: InputDecoration(
                        labelText: 'Capacidad Máxima *',
                        hintText: 'Ingrese capacidad máxima',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Ingrese un número válido';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 16),

                    // Dropdown para Categoría
                    DropdownButtonFormField<String>(
                      value: categoryIdController.text.isNotEmpty ? categoryIdController.text : null,
                      decoration: InputDecoration(
                        labelText: 'Categoría *',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      ),
                      hint: Text('Seleccione una categoría'),
                      items: myReactController.getListCategories.map<DropdownMenuItem<String>>((category) {
                        return DropdownMenuItem<String>(
                          value: category['id'].toString(),
                          child: Text(category['name']),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          categoryIdController.text = newValue ?? '';
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 16),

                    // Dropdown para Usuario
                    DropdownButtonFormField<String>(
                      value: userIdController.text.isNotEmpty ? userIdController.text : null,
                      decoration: InputDecoration(
                        labelText: 'Usuario *',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      ),
                      hint: Text('Seleccione un usuario'),
                      items: myReactController.getListUsers.map<DropdownMenuItem<String>>((user) {
                        return DropdownMenuItem<String>(
                          value: user['id'].toString(),
                          child: Text(user['userName']),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          userIdController.text = newValue ?? '';
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                        return null;
                      },
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