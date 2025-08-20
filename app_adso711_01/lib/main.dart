import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App test ADSO711',
      home: Principal(),
      debugShowCheckedModeBanner: false,

    );
  }
}

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        title: Center(child: Text('Test app ADSO711')),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('Aplicación de prueba para el ADSO2873711'),
          ),
          Text('Este es un widget de Texto'),
          Divider(),
          Image(image: NetworkImage('asset/jiren.png')),
          Divider(),
          Text('Aplicación de prueba para el ADSO2873711'),
          Text('Aplicación de prueba para el ADSO2873711'),
          Text('Aplicación de prueba para el ADSO2873711'),
          Divider(),
          Image.asset('goku.png', width: 40,),
          Image(image: NetworkImage('asset/goku.png')),

          Card(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('Nombre del Estudiante'),
              subtitle: Text('ADSO711'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('¡Hola!')),
              );
            },
            child: Text('Mostrar mensaje'),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Icon(Icons.star, color: Colors.orange),
                  Text('Favoritos'),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.settings, color: Colors.grey),
                  Text('Configuración'),
                ],
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Escribe tu nombre',
                border: OutlineInputBorder(),
              ),
            ),
          ),

          SwitchListTile(
            title: Text('Activar modo oscuro'),
            value: false,
            onChanged: (bool value) {
              // Puedes cambiar el estado aquí
            },
          ),

          const Column(
            children: <Widget>[
              Text('Deliver features faster'),
              Text('Craft beautiful UIs'),
              Expanded(
                child: FittedBox(
                  child: FlutterLogo(),
                ),
              ),
            ],
          )



          
        ],
      ),
    );
  }
}

