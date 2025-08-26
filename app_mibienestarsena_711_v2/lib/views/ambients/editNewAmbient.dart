import 'package:app_mibienestarsena_711_v2/api/apiBienestar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController stateController = TextEditingController();
final TextEditingController usabilityController = TextEditingController();

modalEditNewAmbient(context, option, dynamic listItem) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context, 
    builder: (context) {
      if(option == "new") { 
        nameController.clear();   // Limpiar campos
        stateController.clear();
        usabilityController.clear();
      } else {
        nameController.text = listItem['name'] ?? 'Sin nombre';
        stateController.text = listItem['state'] ?? 'Sin estado';
        usabilityController.text = listItem['usability'] ?? 'No aplica';

      }
      return Scaffold(
        appBar: AppBar(
          title: (option == "new") ? Text('Crear Nuevo Ambiente') : Text('Editar Ambiente'),
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
              // Lógica para crear un nuevo ambiente
              bool resp = await newAmbientApi(
                nameController.text, 
                stateController.text, 
                usabilityController.text
              );
              Get.back();  // Cerrar el modal
              if(resp) {
                Get.snackbar(
                  'Mensaje', "Se ha añadido correctamente un nuevo ambiente", 
                  colorText: Colors.white,
                  backgroundColor: Colors.green
                );
              } else {
                  Get.snackbar(
                    'Mensaje', "Error al agregar el nuevo ambiente", 
                    colorText: Colors.white,
                    backgroundColor: Colors.red
                  );
              }
              
            } else {   
              // En caso de editar el ambiente
              bool resp = await editAmbientApi(
                listItem['id'], 
                nameController.text, 
                stateController.text, 
                usabilityController.text
              );
              Get.back();  // Cerrar el modal
              if(resp) {
                Get.snackbar(
                'Mensaje', "Se ha editado correctamente un nuevo ambiente", 
                colorText: Colors.green,
                backgroundColor: Colors.greenAccent
                );
              } else {
                  Get.snackbar('Mensaje', "Error al editar el nuevo ambiente", colorText: Colors.red);
              }
            }
           
          }),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre del Ambiente',
                    hintText: 'Ingrese nombre del ambiente',
                  ),
                ),
                TextFormField(
                  controller: stateController,
                  decoration: InputDecoration(
                    labelText: 'Estado del Ambiente',
                    hintText: 'Ingrese el estado del ambiente',
                  ),
                ),
                TextFormField(
                  controller: usabilityController,
                  decoration: InputDecoration(
                    labelText: 'Usabilidad del Ambiente',
                    hintText: 'Ingrese la usabilidad del ambiente',
                  ),
                ),
              ],
            ),
          ),
      );

    }
  );


}