import 'dart:convert';
import 'package:app_mibienestarsena_711_v1/main.dart';
import 'package:http/http.dart' as http;

const baseUrl = {
  "picsum": 'https://picsum.photos/v2/list',       // URL de Picsum
  "placeholder": 'https://jsonplaceholder.typicode.com/users',   // URL de PlaceHolder
  "cronode_api": 'https://sena-cronode-test-backend.rboojy.easypanel.host'   // URL para API de Ambientes CPIC
};

Future fetchPicsum() async {   
  final response = await http.get(Uri.parse('${baseUrl["picsum"]}'));

  if (response.statusCode == 200) {
    //final data = jsonDecode(response.body);
    myReactController.setListPicsum(jsonDecode(response.body));
  } else {
    throw Exception('Error al traer los datos de picsum');
  }
}

Future fetchPlaceholder() async {
  final response = await http.get(Uri.parse('${baseUrl["placeholder"]}'));

  if (response.statusCode == 200) {
    myReactController.setListPlaceHolder(jsonDecode(response.body));
  } else {
    throw Exception('Error al traer los datos de placeholder');
  }
}

//****CRUD API AMBIENTES ****/
Future fetchAPIAmbients() async {
  final url = '${baseUrl["cronode_api"]}/api/v1/ambients';
  print(url);
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    //print(jsonDecode(response.body)['data']);
    myReactController.setListAmbients(jsonDecode(response.body)['data']);
  } else {
    throw Exception('Error al traer los datos de API ambientes');
  }
}

Future fetchDeleteAmbient(int id) async {
  final url = '${baseUrl["cronode_api"]}/api/v1/ambients/$id';   // Recibir el utl con id ambiente a aliminar
  final response = await http.delete(Uri.parse(url));

  if (response.statusCode == 200) {
    // Actualizamos la lista de ambientes después de eliminar un ambiente
    await fetchAPIAmbients();
  } else {
    throw Exception('Error al eliminar el ambiente con ID: $id');
  }
}

Future fetchCreateAmbient(Map<String, dynamic> ambientData) async {
  final url = '${baseUrl["cronode_api"]}/api/v1/ambients';
  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(ambientData),
  );

  if (response.statusCode == 201) {
    // Actualizamos la lista de ambientes después de crear un nuevo ambiente
    await fetchAPIAmbients();
  } else {
    throw Exception('Error al crear el ambiente');
  }
}

//**** Realizada por el Profe  ****/
Future newAmbientApi(newNAme, newState, newusability) async {
  const headers = {
    'Content-Type': 'application/json',
  };

  dynamic data = {
    'name': newNAme,
    'state': newState,
    'usability': newusability,
  };

dynamic url = Uri.parse('${baseUrl["cronode_api"]}/api/v1/ambients');

final response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    // Si la respuesta es exitosa, actualizamos la lista de ambientes
    await fetchAPIAmbients();
    return true;  // Retornamos true si se creó correctamente
  } else {
    //throw Exception('Error al crear el nuevo ambiente');
    return false;  // Retornamos false si hubo un error
  }

}

Future editAmbientApi(id, newNAme, newState, newUsability) async {
  const headers = {
    'Content-Type': 'application/json',
  };

  dynamic data = {
    'name': newNAme,
    'state': newState,
    'usability': newUsability,
  };

  dynamic url = Uri.parse('${baseUrl["cronode_api"]}/api/v1/ambients/$id');

  final response = await http.put(
    url,
    headers: headers,
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    // Si la respuesta es exitosa, actualizamos la lista de ambientes
    await fetchAPIAmbients();
    return true;  // Retornamos true si se creó correctamente
  } else {
    //throw Exception('Error al crear el nuevo ambiente');
    return false;  // Retornamos false si hubo un error
  }

}

//****CRUD API AREAS ****/