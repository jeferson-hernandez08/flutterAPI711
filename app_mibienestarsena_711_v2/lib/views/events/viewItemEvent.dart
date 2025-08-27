import 'package:app_mibienestarsena_711_v2/main.dart';
import 'package:flutter/material.dart';
import 'package:app_mibienestarsena_711_v2/api/apiBienestar.dart'; // Importa tu API
import 'package:intl/intl.dart'; // Para formatear fechas

viewItemEvent(context, itemList) async {
  // Cargar o traernos categorías y usuarios si no están disponibles
  if (myReactController.getListCategories.isEmpty) {
    await fetchAPICategories();
  }
  if (myReactController.getListUsers.isEmpty) {
    await fetchAPIUsers();
  }

  // Función para obtener el nombre de la categoría basado en el categoryId
  String getCategoryName(int? categoryId) {
    if (categoryId == null) return 'No disponible';
    
    // Buscar la categoría en la lista de categorías del controlador
    final category = myReactController.getListCategories.firstWhere(
      (category) => category['id'] == categoryId,
      orElse: () => {'name': 'Categoría no encontrada'},
    );
    
    return category['name'] ?? 'Categoría no encontrada';
  }

  // Función para obtener el nombre del usuario basado en el userId
  String getUserName(int? userId) {
    if (userId == null) return 'No disponible';
    
    // Buscar el usuario en la lista de usuarios del controlador
    final user = myReactController.getListUsers.firstWhere(
      (user) => user['id'] == userId,
      orElse: () => {'userName': 'Usuario no encontrado'},
    );
    
    return user['userName'] ?? 'Usuario no encontrado';
  }

  // Función para formatear fechas con hora
  String formatDateTime(String? dateTimeString) {
    if (dateTimeString == null) return 'No disponible';
    
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    } catch (e) {
      return dateTimeString;
    }
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Detalle del Evento'),
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
              leading: Icon(Icons.event),
              title: Text('Nombre del Evento'),
              subtitle: Text(itemList['name'] ?? 'No disponible'),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.description),
              title: Text('Descripción'),
              subtitle: Text(itemList['description'] ?? 'No disponible'),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Fecha y Hora de Inicio'),
              subtitle: Text(formatDateTime(itemList['starDate'])),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Fecha y Hora de Fin'),
              subtitle: Text(formatDateTime(itemList['endDate'])),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.category),
              title: Text('Categoría'),
              subtitle: Text(getCategoryName(itemList['categoryId'])),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.toggle_on),
              title: Text('Estado'),
              subtitle: Text(itemList['state'] ?? 'No disponible'),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.people),
              title: Text('Capacidad Máxima'),
              subtitle: Text('${itemList['maxCapacity'] ?? '0'} personas'),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.person),
              title: Text('Usuario Responsable'),
              subtitle: Text(getUserName(itemList['userId'])),
            ),
            Divider(),

            // Información adicional sobre duración del evento
            if (itemList['starDate'] != null && itemList['endDate'] != null)
              ListTile(
                leading: Icon(Icons.timer),
                title: Text('Duración del Evento'),
                subtitle: Text(_calculateDuration(itemList['starDate'], itemList['endDate'])),
              ),
            if (itemList['starDate'] != null && itemList['endDate'] != null) Divider(),
          ],
        ),
      );
    },
  );
}

// Función para calcular la duración del evento
String _calculateDuration(String? startDate, String? endDate) {
  if (startDate == null || endDate == null) return 'No disponible';
  
  try {
    final start = DateTime.parse(startDate);
    final end = DateTime.parse(endDate);
    final duration = end.difference(start);
    
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    
    if (hours > 0) {
      return '$hours hora(s) ${minutes > 0 ? 'y $minutes minuto(s)' : ''}';
    } else {
      return '$minutes minuto(s)';
    }
  } catch (e) {
    return 'No disponible';
  }
}