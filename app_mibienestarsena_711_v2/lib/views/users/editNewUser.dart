import 'package:app_mibienestarsena_711_v2/api/apiBienestar.dart';
import 'package:app_mibienestarsena_711_v2/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Para formatear fechas

final TextEditingController userNameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController birthdateController = TextEditingController();
final TextEditingController documentController = TextEditingController();
final TextEditingController genderController = TextEditingController();
final TextEditingController stateController = TextEditingController();
final TextEditingController rolIdController = TextEditingController();
// final TextEditingController passwordResetTokenController = TextEditingController();
// final TextEditingController passwordResetExpiresController = TextEditingController();

modalEditNewUser(context, option, dynamic listItem) {
  // Creamos una clave global para el formulario | Para campo clave y campos obligatorios
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   // Variables para los valores seleccionados en los dropdowns
  String? selectedGender;
  String? selectedState;
  DateTime? selectedDate;

  showModalBottomSheet(
    isScrollControlled: true,
    context: context, 
    builder: (context) {
      if(option == "new") { 
        userNameController.clear();   // Limpiar campos
        emailController.clear();   // Limpiar campos
        passwordController.clear();   // Limpiar campos
        phoneController.clear();   // Limpiar campos
        birthdateController.clear();   // Limpiar campos
        documentController.clear();   // Limpiar campos
        genderController.clear();   // Limpiar campos
        stateController.clear();   // Limpiar campos
        rolIdController.clear();   // Limpiar campos
        // passwordResetTokenController.clear();   // Limpiar campos
        // passwordResetExpiresController.clear();   // Limpiar campos
        selectedGender = null;
        selectedState = null;
        selectedDate = null;
      } else {
        userNameController.text = listItem['userName'] ?? 'Sin nombre';
        emailController.text = listItem['email'] ?? 'Sin email';
        passwordController.text = listItem['password'] ?? 'Sin password';
        phoneController.text = listItem['phone'] ?? 'Sin phone';
        documentController.text = listItem['document'] ?? 'Sin document';
        rolIdController.text = listItem['rolId'].toString() ?? 'Sin rolId'; // ✅ Convertir a String
        // passwordResetTokenController.text = listItem['passwordResetToken'] ?? 'Sin passwordResetToken';
        // passwordResetExpiresController.text = listItem['passwordResetExpires'] ?? 'Sin passwordResetExpires';

        // Establecer valores para los dropdowns y fecha
        selectedGender = listItem['gender'] ?? null;
        genderController.text = selectedGender ?? '';
        
        selectedState = listItem['state'] ?? null;
        stateController.text = selectedState ?? '';
        
        // Procesar fecha de nacimiento si existe
        if (listItem['birthdate'] != null) {
          try {
            selectedDate = DateTime.parse(listItem['birthdate']);
            birthdateController.text = DateFormat('yyyy-MM-dd').format(selectedDate!);
          } catch (e) {
            birthdateController.text = listItem['birthdate'] ?? '';
          }
        }
      }

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          // 👇🏼 Capturar los roles solo si no están en memoria
          if (myReactController.getListRols.isEmpty) {
            fetchAPIRols().then((_) {
              setState(() {}); // Refresca cuando termine la API
            });
          }
          // Función para mostrar el selector de fecha o visualización de fecha
          Future<void> _selectDate(BuildContext context) async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(
                      primary: Colors.blue, // Color principal
                      onPrimary: Colors.white, // Texto sobre el color principal
                    ),
                    dialogBackgroundColor: Colors.white, // Fondo del diálogo
                  ),
                  child: child!,
                );
              },
            );
            
            if (picked != null && picked != selectedDate) {
              setState(() {
                selectedDate = picked;
                birthdateController.text = DateFormat('yyyy-MM-dd').format(picked);
              });
            }
          }

          return Scaffold(
            appBar: AppBar(
              title: (option == "new") ? Text('Crear Nuevo Usuario') : Text('Editar Usuario'),
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
                  // Lógica para crear un nuevo rol
                  bool resp = await newUserApi(
                    userNameController.text, 
                    emailController.text,
                    passwordController.text,
                    phoneController.text,
                    birthdateController.text,
                    documentController.text, 
                    genderController.text, 
                    stateController.text, 
                    rolIdController.text, 
                    // passwordResetTokenController.text, 
                    // passwordResetExpiresController.text 
                  );
                  Get.back();  // Cerrar el modal
                  if(resp) {
                    Get.snackbar(
                      'Mensaje', "Se ha añadido correctamente un nuevo usuario", 
                      colorText: Colors.white,
                      backgroundColor: Colors.green
                    );
                  } else {
                      Get.snackbar(
                        'Mensaje', "Error al agregar el nuevo usuario", 
                        colorText: Colors.white,
                        backgroundColor: Colors.red
                      );
                  }
                  
                } else {   
                  // En caso de editar el ambiente
                  bool resp = await editUserApi(
                    listItem['id'],
                    userNameController.text, 
                    emailController.text,
                    passwordController.text ,
                    phoneController.text ,
                    birthdateController.text ,
                    documentController.text, 
                    genderController.text, 
                    stateController.text, 
                    rolIdController.text, 
                    // passwordResetTokenController.text, 
                    // passwordResetExpiresController.text 
                  );
                  Get.back();  // Cerrar el modal
                  if(resp) {
                    Get.snackbar(
                    'Mensaje', "Se ha editado correctamente un nuevo usuario", 
                    colorText: Colors.green,
                    backgroundColor: Colors.greenAccent
                    );
                  } else {
                      Get.snackbar('Mensaje', "Error al editar el nuevo usuario", colorText: Colors.red);
                  }
                }
              
              }),

              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey, // Asignar la clave al formulario
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: userNameController,
                        decoration: InputDecoration(
                          labelText: 'Nombre del Usuario *',
                          hintText: 'Ingrese nombre del Usuario',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo es obligatorio';
                          }
                          return null;
                        },
                      ),

                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email del Usuario *',
                          hintText: 'Ingrese email del Usuario',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo es obligatorio';
                          }
                          if (!value.contains('@')) {
                            return 'Ingrese un email válido';
                          }
                          return null;
                        },
                      ),

                      TextFormField(
                        controller: passwordController, 
                        decoration: InputDecoration(
                          labelText: 'Password del Usuario *',
                          hintText: 'Ingrese password del Usuario',
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo es obligatorio';
                          }
                          if (value.length < 6) {
                            return 'La contraseña debe tener al menos 6 caracteres';
                          }
                          return null;
                        },
                      ),

                      TextFormField(
                        controller: phoneController, 
                        decoration: InputDecoration(
                          labelText: 'Telefono del Usuario',
                          hintText: 'Ingrese telefono del usuario',
                        ),
                      ),

                      // Campo de fecha de nacimiento con selector de fehhca
                      TextFormField(
                        controller: birthdateController,
                        decoration: InputDecoration(
                          labelText: 'Fecha de Nacimiento *',
                          hintText: 'Seleccione la fecha de nacimiento',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () => _selectDate(context),
                          ),
                        ),
                        readOnly: true, // Hace que el campo sea de solo lectura
                        onTap: () => _selectDate(context), // Abre el selector al tocar
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo es obligatorio';
                          }
                          return null;
                        },
                      ),

                      TextFormField(
                        controller: documentController, 
                        decoration: InputDecoration(
                          labelText: 'Documento del Usuario *',
                          hintText: 'Ingrese número de documento del Usuario',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo es obligatorio';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 16),

                      // Dropdown para Género 
                      DropdownButtonFormField<String>(   // widgets que permiten al usuario seleccionar una única opción de una lista de elementos
                        value: selectedGender,    // 'M' o 'F' , Así esta en la BD Api
                        decoration: InputDecoration(
                          labelText: 'Género del Usuario *',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        ),
                        hint: Text('Seleccione el género'),
                        items: [
                          DropdownMenuItem(
                            value: 'M',            // Aqui es por que lo seeders de BD API ya estan creados como true y false.
                            child: Text('Masculino'),
                          ),
                          DropdownMenuItem(
                            value: 'F',
                            child: Text('Femenino'),
                          ),
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedGender = newValue;
                            genderController.text = newValue ?? '';
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
                    
                      // Dropdown para Estado
                      DropdownButtonFormField<String>(
                        value: selectedState,
                        decoration: InputDecoration(
                          labelText: 'Estado del Usuario *',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        ),
                        hint: Text('Seleccione el estado'),
                        items: [
                          DropdownMenuItem(
                            value: 'true',       // Aqui es por que lo seeders de BD API ya estan creados como true y false.
                            child: Text('Activo'),
                          ),
                          DropdownMenuItem(
                            value: 'false',
                            child: Text('Inactivo'),
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

                      DropdownButtonFormField<String>(
                        value: rolIdController.text.isNotEmpty ? rolIdController.text : null,
                        decoration: InputDecoration(
                          labelText: 'Rol *',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        ),
                        hint: Text('Seleccione un rol'),
                        items: myReactController.getListRols.map<DropdownMenuItem<String>>((rol) {
                          return DropdownMenuItem<String>(
                            value: rol['id'].toString(),
                            child: Text(rol['name']),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            rolIdController.text = newValue ?? '';
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo es obligatorio';
                          }
                          return null;
                        },
                      ),

                      // TextFormField(
                      //   controller: passwordResetTokenController,
                      //   decoration: InputDecoration(
                      //     labelText: 'Token de Reset',
                      //     hintText: 'Ingrese token de recuperación',
                      //     ),
                      //   ),

                      // TextFormField(
                      //   controller: passwordResetExpiresController,
                      //   decoration: InputDecoration(
                      //     labelText: 'Expiración Reset',
                      //     hintText: 'Ingrese fecha de expiración',
                      //     ),
                      //   ),
          
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