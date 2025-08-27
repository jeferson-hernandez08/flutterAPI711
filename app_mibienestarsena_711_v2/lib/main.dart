import 'package:app_mibienestarsena_711_v2/views/categories/viewCategories.dart';
import 'package:app_mibienestarsena_711_v2/views/events/viewEvents.dart';
import 'package:app_mibienestarsena_711_v2/views/interface/homePrincipal.dart';
import 'package:app_mibienestarsena_711_v2/views/rols/viewRols.dart';
import 'package:app_mibienestarsena_711_v2/views/testviews/viewPlaceHolder.dart';
import 'package:app_mibienestarsena_711_v2/views/users/viewUsers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/reactController.dart';
import 'views/interface/principal.dart';
import 'views/testviews/viewPicsum.dart';

void main(List<String> args) {
  // Se inyecta en memoria el controlador con las variables reactivas
  Get.put(ReactController()); 
  runApp(Principal());
}

// Se busca la instancia del controlador
ReactController myReactController = Get.find();

// Lista de páginas
List menuPages = [
  HomePrincipal(),       // 0 Home Principal
  // ViewPicsum(),            // 1 View Picsum
  // Viewplaceholder(),       // 2 View PlaceHolder
  ViewRolsCPIC(),        // 1 View rols CPIC
  ViewUsersCPIC(),       // 2 View user CPIC
  ViewCategoriesCPIC(),  // 3 View categories CPIC
  ViewEventsCPIC()       // 4 View events CPIC
 
];