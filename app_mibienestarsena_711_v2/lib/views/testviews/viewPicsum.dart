import 'package:app_mibienestarsena_711_v2/api/apiBienestar.dart';
import 'package:app_mibienestarsena_711_v2/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewPicsum extends StatefulWidget {
  const ViewPicsum({super.key});

  @override
  State<ViewPicsum> createState() => _ViewPicsumState();
}

class _ViewPicsumState extends State<ViewPicsum> {
  @override
  void initState() {
    super.initState();
    fetchPicsum();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: myReactController.getListPicsum.length,
        itemBuilder: (BuildContext context, int index) {
          final itemPicsum = myReactController.getListPicsum[index];
          return Card(
            color: const Color.fromARGB(255, 113, 179, 234),
            child: ListTile(
              title: Text(itemPicsum['author']),
              subtitle: Text(itemPicsum['url']),
              leading: Image(image: NetworkImage(itemPicsum['download_url'])),
              ),
          );
        },
      ),
    );
  }
}