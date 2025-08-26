import 'package:app_mibienestarsena_711_v2/api/apiBienestar.dart';
import 'package:app_mibienestarsena_711_v2/views/rols/editNewRol.dart';
import 'package:app_mibienestarsena_711_v2/views/users/editNewUser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../main.dart';
import 'homePrincipal.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Center(child: Text(myReactController.getTituloAppBar)),
          backgroundColor: Colors.amber,
          foregroundColor: Colors.white,
        ),
        body: menuPages[myReactController.getPagina],
        floatingActionButton: Visibility(       // Aquí comentar para probar la otra opcion realizada de viewCreateAmbient.dart
          visible: (myReactController.getPagina == 1 || myReactController.getPagina == 2 ) ? true : false,
          child: FloatingActionButton(    
            backgroundColor: Colors.amber,
            foregroundColor: Colors.white,
            child: Icon(Icons.add),
            onPressed: () {
              var page = myReactController.getPagina;
              if (page == 1) {  // Agregar editar rol
                modalEditNewRol(context, "new", null);
              } else if(page == 2) {  // Agregar editar user
                modalEditNewUser(context, "new", null);
              }
            }),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Text('Info Mi Bienestar SENA'),
                leading: Icon(Icons.person),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: (){
                  myReactController.setTituloAppBar('Mi Bienestar SENA');
                  myReactController.setPagina(0); // Página de Picsum
                  Get.back();
                },
              ),
              // Divider(),
              // ListTile(
              //   title: Text('Listado Picsum'),
              //   leading: Icon(Icons.image),
              //   trailing: Icon(Icons.arrow_forward_ios),
              //   onTap: (){
              //     myReactController.setTituloAppBar('Listado Picsum');
              //     myReactController.setPagina(1); // Página de Picsum
              //     Get.back();
              //   },
              // ),
              // Divider(),
              // ListTile(
              //   title: Text('Listado Placeholder'),
              //   leading: Icon(Icons.image),
              //   trailing: Icon(Icons.arrow_forward_ios),
              //   onTap: (){
              //     myReactController.setTituloAppBar('Listado PlaceHolder');
              //     myReactController.setPagina(2); 
              //     Get.back();
              //   },
              // ),
              Divider(),
              ListTile(
                title: Text('Listado del Roles CPIC'),
                leading: Icon(Icons.image),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: (){
                  myReactController.setTituloAppBar('Listado Roles CPIC');
                  myReactController.setPagina(1);   // Aqui se trae en main el array List menuPages = [
                  Get.back();
                },
              ),
              Divider(),
              Divider(),
              ListTile(
                title: Text('Listado del Usuarios CPIC'),
                leading: Icon(Icons.image),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: (){
                  myReactController.setTituloAppBar('Listado Usuarios CPIC');
                  myReactController.setPagina(2);   // Aqui se trae en main el array List menuPages = [
                  Get.back();
                },
              ),
              Divider(),
              
            ],
          ),
        ),
      ),
    );
  }
}