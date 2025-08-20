import 'package:get/get.dart';

class ReactController extends GetxController  {
  final _pagina = 0.obs;
  final _tituloAppBar = 'Mi Bienestar SENA controller'.obs;
  final _listPicsum = [].obs;
  final _listPlaceHolder = [].obs;
  final _listAmbients = [].obs; 

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
 
  int get getPagina => _pagina.value;
  String get getTituloAppBar => _tituloAppBar.value;
  List get getListPicsum => _listPicsum.value;
  List get getListPlaceHolder => _listPlaceHolder.value;
  List get getListAmbients => _listAmbients.value;     
}