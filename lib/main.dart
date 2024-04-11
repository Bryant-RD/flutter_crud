import 'package:crud_cita/API/CitaService.dart';
import 'package:crud_cita/CitaForm.dart';
import 'package:crud_cita/CitaProvider.dart';
import 'package:crud_cita/Entitys/Cita.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CitaProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CitaService httpClient;
  List<Cita> citas = [];

  @override
  void initState() {
    super.initState();
    httpClient = CitaService();
    httpClient.getCitas().then((value) {
      setState(() {
        citas = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // body: const CitaFormWidget(cita: null)

      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: const TextField(
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelText: 'Buscar',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CitaFormWidget(cita: null),
                    ),
                  );
                },
                child: const Text('Agregar Cita'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: citas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(citas[index].id.toString() +
                      " " +
                      citas[index].cliente.nombre),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(citas[index].fecha),
                      Text(citas[index].hora),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      httpClient.deleteCita(citas[index].id!).then((value) {
                        httpClient.getCitas().then((value) {
                          setState(() {
                            citas = value;
                          });
                        });
                      });
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CitaFormWidget(cita: citas[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
