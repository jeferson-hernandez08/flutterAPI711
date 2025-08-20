import 'package:app_mibienestarsena_711_v1/views/ambients/viewAmbients.dart';
import 'package:app_mibienestarsena_711_v1/views/interface/homePrincipal.dart';
import 'package:app_mibienestarsena_711_v1/views/testviews/viewPlaceHolder.dart';
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
  HomePrincipal(),     // 0 Home Principal
  ViewPicsum(),        // 1 View Picsum
  Viewplaceholder(),   // 2 View PlaceHolder
  ViewAmbientsCPIC(),   // 3 View Ambientes CPIC

];