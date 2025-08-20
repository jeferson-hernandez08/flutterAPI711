import 'package:app_mibienestarsena_711_v1/api/apiBienestar.dart';
import 'package:app_mibienestarsena_711_v1/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'detailUser.dart';

class Viewplaceholder extends StatefulWidget {
  const Viewplaceholder({super.key});

  @override
  State<Viewplaceholder> createState() => _ViewplaceholderState();
}

class _ViewplaceholderState extends State<Viewplaceholder> {
  @override
  void initState() {
    super.initState();
    fetchPlaceholder();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: myReactController.getListPlaceHolder.length,
        itemBuilder: (BuildContext context, int index) {
          final itemPlaceholder = myReactController.getListPlaceHolder[index];
          return Card(
            color: const Color.fromARGB(255, 113, 179, 234),
            child: ListTile(
              onTap: (){
                modalDetailUser(context, itemPlaceholder);
              }, 
              leading: Icon(Icons.people),
              title: Text(itemPlaceholder['name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(itemPlaceholder['email']),
                  Text(itemPlaceholder['website']),
                ],
              ),
              trailing: Row(
                // spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(itemPlaceholder['username']),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}