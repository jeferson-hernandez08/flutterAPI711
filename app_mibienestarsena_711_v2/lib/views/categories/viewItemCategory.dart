import 'package:app_mibienestarsena_711_v2/main.dart';
import 'package:flutter/material.dart';
import 'package:app_mibienestarsena_711_v2/api/apiBienestar.dart'; // Importa tu API

viewItemCategory(context, itemList) async {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Detalle de la Categoría'),
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
              leading: Icon(Icons.category),
              title: Text('Nombre de la Categoría'),
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
              leading: Icon(Icons.image),
              title: Text('Imagen'),
              subtitle: Text(itemList['image'] ?? 'No disponible'),
            ),
            Divider(),

            // Mostrar la imagen si existe
            if (itemList['image'] != null && itemList['image']!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.network(
                  itemList['image']!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Column(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red, size: 50),
                        SizedBox(height: 8),
                        Text(
                          'Error al cargar la imagen',
                          style: TextStyle(color: Colors.red),
                        ),
                        Text(
                          'URL: ${itemList['image']}',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
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
              ),
          ],
        ),
      );
    },
  );
}