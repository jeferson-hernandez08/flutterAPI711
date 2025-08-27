import 'package:app_mibienestarsena_711_v2/api/apiBienestar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  // Crear una clave global para el formulario | Para campos obligatorios
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      } else {
        userNameController.text = listItem['userName'] ?? 'Sin nombre';
        emailController.text = listItem['email'] ?? 'Sin email';
        passwordController.text = listItem['password'] ?? 'Sin password';
        phoneController.text = listItem['phone'] ?? 'Sin phone';
        birthdateController.text = listItem['birthdate'] ?? 'Sin birthdate';
        documentController.text = listItem['document'] ?? 'Sin document';
        genderController.text = listItem['gender'] ?? 'Sin gender';
        stateController.text = listItem['state'] ?? 'Sin state';
        rolIdController.text = listItem['rolId'].toString() ?? 'Sin rolId'; // ✅ Convertir a String
        // passwordResetTokenController.text = listItem['passwordResetToken'] ?? 'Sin passwordResetToken';
        // passwordResetExpiresController.text = listItem['passwordResetExpires'] ?? 'Sin passwordResetExpires';
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
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Este campo es obligatorio';
                    //   }
                    //   return null;
                    // },

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

                  TextFormField(
                    controller: birthdateController, 
                    decoration: InputDecoration(
                      labelText: 'Fecha de Nacimiento',
                      hintText: 'Ingrese fecha de nacimiento - YYYY-MM-DD',
                    ),
                  ),

                  TextFormField(
                    controller: documentController, 
                    decoration: InputDecoration(
                      labelText: 'Documento del Usuario',
                      hintText: 'Ingrese número de documento del Usuario',
                    ),
                  ),

                  TextFormField(
                    controller: genderController, 
                    decoration: InputDecoration(
                      labelText: 'Género del Usuario',
                      hintText: 'Ingrese género del Usuario',
                    ),
                  ),

                  TextFormField(
                    controller: stateController,
                    decoration: InputDecoration(
                      labelText: 'Estado del Usuario *',
                      hintText: 'Activo / Inactivo',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo es obligatorio';
                      }
                      return null;
                    },
                  ),

                  TextFormField(
                  controller: rolIdController,
                  decoration: InputDecoration(
                    labelText: 'Rol ID *',
                    hintText: 'Ingrese rol asignado',
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