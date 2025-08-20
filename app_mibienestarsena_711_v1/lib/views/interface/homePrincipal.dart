import 'package:flutter/material.dart';

class HomePrincipal extends StatefulWidget {
  const HomePrincipal({super.key});

  @override
  State<HomePrincipal> createState() => _HomePrincipalState();
}

class _HomePrincipalState extends State<HomePrincipal> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('En la App Mi Bienestar SENA encontrarás todos los eventos deportivos y culturales del SENA Regional Caldas'),
        ),
      ),
    );
  }
}