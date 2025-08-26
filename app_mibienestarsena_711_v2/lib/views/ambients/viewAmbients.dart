import 'package:app_mibienestarsena_711_v2/api/apiBienestar.dart';
import 'package:app_mibienestarsena_711_v2/main.dart';
import 'package:app_mibienestarsena_711_v2/views/ambients/editNewAmbient.dart';
import 'package:app_mibienestarsena_711_v2/views/ambients/viewCreateAmbient.dart';
import 'package:app_mibienestarsena_711_v2/views/ambients/viewDeleteAmbient.dart';
import 'package:app_mibienestarsena_711_v2/views/ambients/viewItemAmbient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewAmbientsCPIC extends StatefulWidget {
  const ViewAmbientsCPIC({super.key});

  @override
  State<ViewAmbientsCPIC> createState() => _ViewAmbientsCPICState();
}

class _ViewAmbientsCPICState extends State<ViewAmbientsCPIC> {
  @override
  void initState() {
    super.initState();
    // Aquí puedes inicializar cualquier cosa que necesites antes de que se construya el widget
    //fetchAPIRols();         // Metodo del ambiente que trae los ambientes 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Boton flotante para crear
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Llamamos la  función para crear el ambiente
          viewCreateAmbient(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue, // Personaliza el color
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: myReactController.getListAmbients.length,
          itemBuilder: (BuildContext context, int index) {
            final itemList = myReactController.getListAmbients[index];
            return Card(
              child: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.store), 
                    Text(itemList['id'].toString()),
                  ],
                ),
                title: Text(itemList['name']),
                subtitle: Text(itemList['usability']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: (){
                      viewItemAmbient(context, itemList);
                    }, icon: Icon( Icons.visibility)),
                    IconButton(onPressed: () async {
                      await modalEditNewAmbient(context, "edit", itemList);
                    }, icon: Icon(Icons.edit)),
                    IconButton(onPressed: (){
                      viewDeleteAmbient(context, itemList);
                    }, icon: Icon(Icons.delete)),

                  ],
                ),
              ),
            );
          },
        ),
      ),
    );  
  }
}




