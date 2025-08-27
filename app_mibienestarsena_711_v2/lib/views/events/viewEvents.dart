import 'package:app_mibienestarsena_711_v2/api/apiBienestar.dart';
import 'package:app_mibienestarsena_711_v2/main.dart';
import 'package:app_mibienestarsena_711_v2/views/events/editNewEvent.dart';
import 'package:app_mibienestarsena_711_v2/views/events/viewDeleteEvent.dart';
import 'package:app_mibienestarsena_711_v2/views/events/viewItemEvent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewEventsCPIC extends StatefulWidget {
  const ViewEventsCPIC({super.key});

  @override
  State<ViewEventsCPIC> createState() => _ViewEventsCPICState();
}

class _ViewEventsCPICState extends State<ViewEventsCPIC> {
  @override
  void initState() {
    super.initState();
    // Aquí puedes inicializar cualquier cosa que necesites antes de que se construya el widget
    fetchAPIEvents();         // Método que trae los eventos
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Boton flotante para crear
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Llamamos la función para crear el evento
          modalEditNewEvent(context, "new", null);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue, // Personaliza el color
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: myReactController.getListEvents.length,
          itemBuilder: (BuildContext context, int index) {
            final itemList = myReactController.getListEvents[index];
            return Card(
              child: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event), 
                    Text(itemList['id'].toString()),
                  ],
                ),
                title: Text(itemList['name'] ?? 'Sin nombre'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(itemList['description'] ?? 'Sin descripción', 
                         maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text('Capacidad: ${itemList['maxCapacity'] ?? 'N/A'}'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        viewItemEvent(context, itemList);
                      }, 
                      icon: Icon(Icons.visibility)
                    ),
                    IconButton(
                      onPressed: () async {
                        await modalEditNewEvent(context, "edit", itemList);
                      }, 
                      icon: Icon(Icons.edit)
                    ),
                    IconButton(
                      onPressed: () {
                        viewDeleteEvent(context, itemList);
                      }, 
                      icon: Icon(Icons.delete)
                    ),
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