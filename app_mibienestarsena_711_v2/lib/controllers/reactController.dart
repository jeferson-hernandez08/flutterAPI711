import 'package:get/get.dart';

class ReactController extends GetxController  {
  final _pagina = 0.obs;
  final _tituloAppBar = 'Mi Bienestar SENA controller'.obs;
  final _listPicsum = [].obs;
  final _listPlaceHolder = [].obs;
  final _listAmbients = [].obs; 
  final _listRols = [].obs; 
  final _listUsers = [].obs; 
  final _listCategories = [].obs; 
  final _listEvents = [].obs; 

  void setPagina(int newPage){
    _pagina.value = newPage;
  }
  void setTituloAppBar(String newTitle){
    _tituloAppBar.value = newTitle;
  }
  void setListPicsum(List itemList){
    _listPicsum.value = itemList;
  }
  void setListPlaceHolder(List itemList){
    _listPlaceHolder.value = itemList;
  }
  void setListAmbients(List itemList){
    _listAmbients.value = itemList;
  }
  void setListRols(List itemList){
    _listRols.value = itemList;
  }
  void setListUsers(List itemList){
    _listUsers.value = itemList;
  }
  void setListCategories(List itemList){
    _listCategories.value = itemList;
  }
  void setListEvents(List itemList){
    _listEvents.value = itemList;
  }
 
  int get getPagina => _pagina.value;
  String get getTituloAppBar => _tituloAppBar.value;
  List get getListPicsum => _listPicsum.value;
  List get getListPlaceHolder => _listPlaceHolder.value;
  List get getListAmbients => _listAmbients.value;     
  List get getListRols => _listRols.value;     
  List get getListUsers => _listUsers.value;     
  List get getListCategories => _listCategories.value;     
  List get getListEvents => _listEvents.value;     
}