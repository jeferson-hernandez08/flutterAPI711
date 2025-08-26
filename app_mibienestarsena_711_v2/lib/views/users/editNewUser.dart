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
final TextEditingController passwordResetTokenController = TextEditingController();
final TextEditingController passwordResetExpiresController = TextEditingController();

modalEditNewUser(context, option, dynamic listItem) {
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
        passwordResetTokenController.clear();   // Limpiar campos
        passwordResetExpiresController.clear();   // Limpiar campos
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
        passwordResetTokenController.text = listItem['passwordResetToken'] ?? 'Sin passwordResetToken';
        passwordResetExpiresController.text = listItem['passwordResetExpires'] ?? 'Sin passwordResetExpires';
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
            if(option == "new") {
              // Lógica para crear un nuevo rol
              bool resp = await newUserApi(
                userNameController.text, 
                emailController.text,
                passwordController.text ,
                phoneController.text ,
                birthdateController.text ,
                documentController.text, 
                genderController.text, 
                stateController.text, 
                rolIdController.text, 
                passwordResetTokenController.text, 
                passwordResetExpiresController.text 
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
                passwordResetTokenController.text, 
                passwordResetExpiresController.text 
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
            child: ListView(
              children: [
                TextFormField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre del Usuario',
                    hintText: 'Ingrese nombre del Usuario',
                  ),
                ),

                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email del Usuario',
                    hintText: 'Ingrese email del Usuario',
                  ),
                ),

                TextFormField(
                  controller: passwordController, 
                  decoration: InputDecoration(
                    labelText: 'Password del Usuario',
                    hintText: 'Ingrese password del Usuario',
                  ),
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
                    labelText: 'Birthdate del Usuario',
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
                    labelText: 'Genero del Usuario',
                    hintText: 'Ingrese genero del Usuario',
                  ),
                ),

                TextFormField(
                controller: stateController,
                decoration: InputDecoration(
                  labelText: 'Estado del Usuario',
                  hintText: 'Activo / Inactivo',
                  ),
                ),

                TextFormField(
                controller: rolIdController,
                decoration: InputDecoration(
                  labelText: 'Rol ID',
                  hintText: 'Ingrese rol asignado',
                  ),
                  keyboardType: TextInputType.number,
                ),

              TextFormField(
                controller: passwordResetTokenController,
                decoration: InputDecoration(
                  labelText: 'Token de Reset',
                  hintText: 'Ingrese token de recuperación',
                  ),
                ),

              TextFormField(
                controller: passwordResetExpiresController,
                decoration: InputDecoration(
                  labelText: 'Expiración Reset',
                  hintText: 'Ingrese fecha de expiración',
                  ),
                ),
    
              ],
            ),
          ),
      );

    }
  );


}