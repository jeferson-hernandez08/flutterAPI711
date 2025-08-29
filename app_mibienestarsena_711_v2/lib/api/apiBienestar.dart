import 'dart:convert';
import 'package:app_mibienestarsena_711_v2/main.dart';
import 'package:http/http.dart' as http;

const baseUrl = {
  "picsum": 'https://picsum.photos/v2/list',       // URL de Picsum
  "placeholder": 'https://jsonplaceholder.typicode.com/users',   // URL de PlaceHolder
  "cronode_api": 'https://sena-cronode-test-backend.rboojy.easypanel.host',   // URL para API de Ambientes CPIC
  "mibienestarsena_api": 'https://api-mibienestarsena-711-kw2f.onrender.com',  // URL de la api mi bienestar
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

//******************************/
//****API MI BIENESTAR SENA ****/
//******************************/
//******CRUD Tabla Rols****** 
Future fetchAPIRols() async {
  final url = '${baseUrl["mibienestarsena_api"]}/api/v1/rols';
  print(url);
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print("Respuesta API: ${response.body}"); // imprime lo que devuelve la API
    //print(jsonDecode(response.body)['data']);
    myReactController.setListRols(jsonDecode(response.body)['data']);
  } else {
    throw Exception('Error al traer los datos de API roles');
  }
}

Future newRolApi(newName) async {
  const headers = {
    'Content-Type': 'application/json',
  };

  dynamic data = {
    'name': newName
  };

dynamic url = Uri.parse('${baseUrl["mibienestarsena_api"]}/api/v1/rols');

final response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(data),
  );

  if (response.statusCode == 201) {
    // Si la respuesta es exitosa, actualizamos la lista de roles
    await fetchAPIRols();
    return true;  // Retornamos true si se creó correctamente
  } else {
    //throw Exception('Error al crear el nuevo ambiente');
    return false;  // Retornamos false si hubo un error
  }

}

Future editRolApi(id, newName) async {
  const headers = {
    'Content-Type': 'application/json',
  };

  dynamic data = {
    'name': newName
  };

  dynamic url = Uri.parse('${baseUrl["mibienestarsena_api"]}/api/v1/rols/$id');

  final response = await http.put(
    url,
    headers: headers,
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    // Si la respuesta es exitosa, actualizamos la lista de roles
    await fetchAPIRols();
    return true;  // Retornamos true si se creó correctamente
  } else {
    //throw Exception('Error al crear el nuevo rol');
    return false;  // Retornamos false si hubo un error
  }

}

Future fetchDeleteRol(int id) async {
  final url = '${baseUrl["mibienestarsena_api"]}/api/v1/rols/$id';   // Recibir el utl con id rol a aliminar
  final response = await http.delete(Uri.parse(url));

  if (response.statusCode == 200) {
    // Actualizamos la lista de ambientes después de eliminar un rol
    await fetchAPIRols();
  } else {
    throw Exception('Error al eliminar el ambiente con ID: $id');
  }
}

//******CRUD Tabla Users******
Future fetchAPIUsers() async {
  final url = '${baseUrl["mibienestarsena_api"]}/api/v1/users';
  print(url);
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print("Respuesta API: ${response.body}"); // imprime lo que devuelve la API
    //print(jsonDecode(response.body)['data']);
    myReactController.setListUsers(jsonDecode(response.body)['data']);
  } else {
    throw Exception('Error al traer los datos de API users');
  }
}

Future newUserApi(newUserName, newEmail, newPassword, newPhone, newBirthdate, newDocument, newGender, newState, newRolId) async {
  const headers = {
    'Content-Type': 'application/json',
  };

  dynamic data = {
    'userName': newUserName,
    'email': newEmail,
    'password': newPassword,
    'phone': newPhone,
    'birthdate': newBirthdate,
    'document': newDocument,
    'gender': newGender,
    'state': newState,
    'rolId': newRolId
    //'passwordResetToken': newPasswordResetToken,
    //'passwordResetExpires': newPasswordResetExpires
  };

dynamic url = Uri.parse('${baseUrl["mibienestarsena_api"]}/api/v1/users');
print('URL: $url');

final response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(data),
  );

  if (response.statusCode == 201) {
    // Si la respuesta es exitosa, actualizamos la lista de users
    await fetchAPIUsers();
    return true;  // Retornamos true si se creó correctamente
  } else {
    //throw Exception('Error al crear el nuevo ambiente');
    return false;  // Retornamos false si hubo un error
  }

}

Future editUserApi(id, newUserName, newEmail, newPassword, newPhone, newBirthdate, newDocument, newGender, newState, newRolId) async {
  const headers = {
    'Content-Type': 'application/json',
  };

  dynamic data = {
    'userName': newUserName,
    'email': newEmail,
    'password': newPassword,
    'phone': newPhone,
    'birthdate': newBirthdate,
    'document': newDocument,
    'gender': newGender,
    'state': newState,
    'rolId': newRolId
    // 'passwordResetToken': newPasswordResetToken,
    // 'passwordResetExpires': newPasswordResetExpires
  };

  dynamic url = Uri.parse('${baseUrl["mibienestarsena_api"]}/api/v1/users/$id');

  final response = await http.put(
    url,
    headers: headers,
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    // Si la respuesta es exitosa, actualizamos la lista de usuarios
    await fetchAPIUsers();
    return true;  // Retornamos true si se creó correctamente
  } else {
    //throw Exception('Error al crear el nuevo rol');
    return false;  // Retornamos false si hubo un error
  }

}

Future deleteUserApi(int id) async {
  final url = '${baseUrl["mibienestarsena_api"]}/api/v1/users/$id';   // Recibir el utl con id rol a aliminar
  final response = await http.delete(Uri.parse(url));

  if (response.statusCode == 200) {
    // Actualizamos la lista de ambientes después de eliminar un usuario
    await fetchAPIUsers();
  } else {
    throw Exception('Error al eliminar el usuario con ID: $id');
  }
}

//******CRUD Tabla Categories******
Future fetchAPICategories() async {
  final url = '${baseUrl["mibienestarsena_api"]}/api/v1/categories';
  print(url);
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print("Respuesta API: ${response.body}"); // imprime lo que devuelve la API
    //print(jsonDecode(response.body)['data']);
    myReactController.setListCategories(jsonDecode(response.body)['data']);
  } else {
    throw Exception('Error al traer los datos de API categories');
  }
}

Future newCategoryApi(newName, newDescription, newImage) async {
  const headers = {
    'Content-Type': 'application/json',
  };

  dynamic data = {
    'name': newName,
    'description': newDescription,
    'image': newImage
  };

dynamic url = Uri.parse('${baseUrl["mibienestarsena_api"]}/api/v1/categories');
print('URL: $url');

final response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(data),
  );

  if (response.statusCode == 201) {
    // Si la respuesta es exitosa, actualizamos la lista de categories
    await fetchAPICategories();
    return true;  // Retornamos true si se creó correctamente
  } else {
    //throw Exception('Error al crear el nuevo ambiente');
    return false;  // Retornamos false si hubo un error
  }

}

Future editCategoryApi(id, newName, newDescription, newImage) async {
  const headers = {
    'Content-Type': 'application/json',
  };

  dynamic data = {
    'name': newName,
    'description': newDescription,
    'image': newImage
  };

  dynamic url = Uri.parse('${baseUrl["mibienestarsena_api"]}/api/v1/categories/$id');

  final response = await http.put(
    url,
    headers: headers,
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    // Si la respuesta es exitosa, actualizamos la lista de categorias
    await fetchAPICategories();
    return true;  // Retornamos true si se creó correctamente
  } else {
    //throw Exception('Error al crear el nuevo rol');
    return false;  // Retornamos false si hubo un error
  }

}

Future deleteCategoryApi(int id) async {
  final url = '${baseUrl["mibienestarsena_api"]}/api/v1/categories/$id';   // Recibir el utl con id rol a aliminar
  final response = await http.delete(Uri.parse(url));

  if (response.statusCode == 200) {
    // Actualizamos la lista de ambientes después de eliminar un usuario
    await fetchAPICategories();
  } else {
    throw Exception('Error al eliminar la categoria con ID: $id');
  }
}

//******CRUD Tabla Events******
Future fetchAPIEvents() async {
  final url = '${baseUrl["mibienestarsena_api"]}/api/v1/events';
  print(url);
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print("Respuesta API: ${response.body}"); // imprime lo que devuelve la API
    //print(jsonDecode(response.body)['data']);
    myReactController.setListEvents(jsonDecode(response.body)['data']);
  } else {
    throw Exception('Error al traer los datos de API eventos');
  }
}

Future newEventApi(newName, newDescription, newStarDate, newEndDate, newCategoryId, newState, newMaxCapacity, newUserId ) async {
  const headers = {
    'Content-Type': 'application/json',
  };

  dynamic data = {
    'name': newName,
    'description': newDescription,
    'starDate': newStarDate,
    'endDate': newEndDate,
    'categoryId': newCategoryId,
    'state': newState,
    'maxCapacity': newMaxCapacity,
    'userId': newUserId
  };

dynamic url = Uri.parse('${baseUrl["mibienestarsena_api"]}/api/v1/events');
print('URL: $url');

final response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(data),
  );

  if (response.statusCode == 201) {
    // Si la respuesta es exitosa, actualizamos la lista de eventos
    await fetchAPIEvents();
    return true;  // Retornamos true si se creó correctamente
  } else {
    //throw Exception('Error al crear el nuevo ambiente');
    return false;  // Retornamos false si hubo un error
  }

}

Future editEventApi(id, newName, newDescription, newStarDate, newEndDate, newCategoryId, newState, newMaxCapacity, newUserId) async {
  const headers = {
    'Content-Type': 'application/json',
  };

  dynamic data = {
    'name': newName,
    'description': newDescription,
    'starDate': newStarDate,
    'endDate': newEndDate,
    'categoryId': newCategoryId,
    'state': newState,
    'maxCapacity': newMaxCapacity,
    'userId': newUserId
  };

  dynamic url = Uri.parse('${baseUrl["mibienestarsena_api"]}/api/v1/events/$id');

  final response = await http.put(
    url,
    headers: headers,
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    // Si la respuesta es exitosa, actualizamos la lista de eventos
    await fetchAPIEvents();
    return true;  // Retornamos true si se creó correctamente
  } else {
    //throw Exception('Error al crear el nuevo rol');
    return false;  // Retornamos false si hubo un error
  }

}

Future deleteEventApi(int id) async {
  final url = '${baseUrl["mibienestarsena_api"]}/api/v1/events/$id';   // Recibir el utl con id event a aliminar
  final response = await http.delete(Uri.parse(url));

  if (response.statusCode == 200) {
    // Actualizamos la lista de ambientes después de eliminar un usuario
    await fetchAPIEvents();
  } else {
    throw Exception('Error al eliminar el evento con ID: $id');
  }
}

// Login 
Future<bool> loginApi(String email, String password) async {
  const headers = {
    'Content-Type': 'application/json',
  };

  dynamic data = {
    'email': email,
    'password': password,
  };

  dynamic url = Uri.parse('${baseUrl["mibienestarsena_api"]}/api/v1/auth/login');

  print('🔐 Intentando login con:');
  print('📧 Email: $email');
  print('🔑 Password: $password');
  print('🌐 URL: $url');

  try {
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    print('📥 Respuesta del servidor:');
    print('📊 Status Code: ${response.statusCode}');
    print('📦 Body: ${response.body}');

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      
      // Verificar la estructura de la respuesta
      if (responseData['status'] == 'Ok' && responseData['data'] != null) {
        print('✅ Login exitoso');
        print('🔑 Token recibido: ${responseData['data']['token']}');
        print('👤 Datos usuario: ${responseData['data']['user']}');

        // 👇🏼 CORREGIR: Acceder a los datos dentro de 'data'
        myReactController.setToken(responseData['data']['token']);
        myReactController.setUser(responseData['data']['user']);
        return true;
      } else {
        print('❌ Estructura de respuesta inesperada');
        return false;
      }
    } else {
      print('❌ Error en login - Status code: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('💥 Excepción durante login: $e');
    return false;
  }
}