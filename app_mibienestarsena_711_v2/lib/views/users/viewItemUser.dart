import 'package:app_mibienestarsena_711_v2/main.dart';
import 'package:flutter/material.dart';
import 'package:app_mibienestarsena_711_v2/api/apiBienestar.dart'; // Importa tu API

viewItemUser(context, itemList) async {
  // Cargar roles si no están disponibles
  if (myReactController.getListRols.isEmpty) {
    await fetchAPIRols();
  }

  // Función para obtener el nombre del rol basado en el rolId
  String getRolName(int? rolId) {
    if (rolId == null) return 'No disponible';
    
    // Buscar el rol en la lista de roles del controlador
    final rol = myReactController.getListRols.firstWhere(
      (rol) => rol['id'] == rolId,
      orElse: () => {'name': 'Rol no encontrado'},
    );
    
    return rol['name'] ?? 'Rol no encontrado';
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Detalle del Usuario'),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        body: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.key),
              title: Text('ID'),
              subtitle: Text(itemList['id'].toString()),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.person),
              title: Text('Nombre de Usuario'),
              subtitle: Text(itemList['userName'] ?? 'No disponible'),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text(itemList['email'] ?? 'No disponible'),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Teléfono'),
              subtitle: Text(itemList['phone'] ?? 'No disponible'),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.cake),
              title: Text('Fecha de Nacimiento'),
              subtitle: Text(itemList['birthdate'] ?? 'No disponible'),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.badge),
              title: Text('Documento'),
              subtitle: Text(itemList['document'] ?? 'No disponible'),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.transgender),
              title: Text('Género'),
              subtitle: Text(itemList['gender'] == 'M' ? 'Masculino' : 
                            itemList['gender'] == 'F' ? 'Femenino' : 
                            'No disponible'),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.toggle_on),
              title: Text('Estado'),
              subtitle: Text(itemList['state']?.toString() == 'true' ? 'Activo' : 
                            itemList['state']?.toString() == 'false' ? 'Inactivo' : 
                            'No disponible'),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.security),
              title: Text('Rol'),
              subtitle: Text(getRolName(itemList['rolId'])),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.lock_reset),
              title: Text('Password Reset Token'),
              subtitle: Text(itemList['passwordResetToken'] ?? 'No disponible'),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.timer_off),
              title: Text('Password Reset Expiration'),
              subtitle: Text(itemList['passwordResetExpires'] ?? 'No disponible'),
            ),
            Divider(),
          ],
        ),
      );
    },
  );
}
