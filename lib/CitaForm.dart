import 'dart:convert';
import 'dart:math';

import 'package:crud_cita/API/CitaService.dart';
import 'package:crud_cita/API/ServiciosService.dart';
import 'package:crud_cita/CitaProvider.dart';
import 'package:crud_cita/Entitys/Cita.dart';
import 'package:crud_cita/Entitys/Cliente.dart';
import 'package:crud_cita/Entitys/DetalleCita.dart';
import 'package:crud_cita/Entitys/Servicio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CitaFormWidget extends StatefulWidget {
  const CitaFormWidget({super.key, required this.cita});
  final Cita? cita;

  @override
  _CitaFormWidgetState createState() => _CitaFormWidgetState();
}

class _CitaFormWidgetState extends State<CitaFormWidget> {
  final _formKey = GlobalKey<FormState>();
  // final _fechaController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  // final _horaController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  Cliente? _selectedCliente;
  Empleado? selectedEmpleado;
  late List<DetallesCita> serviciosSeleccionados = [];
  late List<Servicio> servicios = [];
  late List<Cliente> clientes = [];
  late ServiciosService httpClient;
  late CitaService servicioCita;
  late List<Empleado> empleados = [];

  @override
  void initState() {
    super.initState();
    if (widget.cita != null) {
      // _fechaController.text = widget.cita!.fecha;
      // _horaController.text = widget.cita!.hora;
      _selectedCliente = widget.cita!.cliente;
      serviciosSeleccionados = widget.cita!.detallesCitas;
      print(serviciosSeleccionados.length);
    }
    httpClient = ServiciosService();
    servicioCita = CitaService();
    httpClient.getServicios().then((value) {
      setState(() {
        servicios = value;
      });
    });

    httpClient.getClientes().then((value) {
      setState(() {
        clientes = value;
      });
    });

    httpClient.getEmpleados().then((value) {
      setState(() {
        empleados = value;
      });
    });

    print(servicios.length);
  }

  @override
  Widget build(BuildContext context) {
    final citaProvider = Provider.of<CitaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cita == null ? 'Crear Cita' : 'Editar Cita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
// Inside your build method or widget
              Row(
                children: [
                  const Text(
                    "Selecicona la fecha de la cita:",
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate, // Refer to step 1
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2025),
                      );
                      if (picked != null && picked != selectedDate) {
                        setState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                    child: Text(
                      "${selectedDate.toLocal()}".split(' ')[0],
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Selecciona la hora de la cita:",
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                      );
                      if (picked != null && picked != selectedTime) {
                        setState(() {
                          selectedTime = picked;
                        });
                      }
                    },
                    child: Text(
                      selectedTime.format(context),
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Selecciona el cliente:",
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Selecciona un cliente"),
                              content: Column(
                                children: clientes
                                    .map((cliente) => InkWell(
                                          onTap: () {
                                            setState(() {
                                              _selectedCliente = cliente;
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(cliente.nombre),
                                        ))
                                    .toList(),
                              ),
                            );
                          });
                    },
                    child: Text(
                      _selectedCliente != null
                          ? _selectedCliente!.nombre
                          : 'Selecciona un cliente',
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
              Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Selecciona los servicios:",
                        style: TextStyle(fontSize: 18)),
                    Column(
                        children: servicios
                            .map((servicio) => InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (serviciosSeleccionados.any(
                                          (element) =>
                                              element.servicio.id ==
                                              servicio.id)) {
                                        serviciosSeleccionados.removeWhere(
                                            (element) =>
                                                element.id == servicio.id);
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    "Selecciona un empleado"),
                                                content: Column(
                                                  children: empleados
                                                      .map(
                                                          (empleado) => InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    selectedEmpleado =
                                                                        empleado;
                                                                  });
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  serviciosSeleccionados.add(DetallesCita(
                                                                      servicio:
                                                                          servicio,
                                                                      empleado:
                                                                          empleado));
                                                                },
                                                                child: Text(
                                                                    empleado
                                                                        .nombre),
                                                              ))
                                                      .toList(),
                                                ),
                                              );
                                            });
                                      }
                                    });
                                  },
                                  child: Text(servicio.nombre),
                                ))
                            .toList())
                  ],
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Servicios seleccionados:",
                        style: TextStyle(fontSize: 18)),
                    Column(
                        children: serviciosSeleccionados
                            .map((e) => InkWell(
                                  onTap: () {
                                    setState(() {
                                      serviciosSeleccionados.remove(e);
                                    });
                                  },
                                  child: Text(e.servicio.nombre),
                                ))
                            .toList())
                  ],
                ),
              ]),

              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      widget.cita == null) {
                    // Guardar la cita
                    Cita cita = Cita(
                      id: Random().nextInt(1000),
                      fecha: selectedDate.toString(),
                      hora: selectedTime.toString(),
                      cliente: _selectedCliente!,
                      detallesCitas: serviciosSeleccionados,
                    );
                    // Aquí puedes guardar la cita en tu base de datos o hacer lo que necesites con ella
                    // print(jsonEncode(cita.toJson()));
                    servicioCita.createCita(cita);
                    citaProvider.addCita(cita);
                    Navigator.pop(context, cita);
                  }
                  if (_formKey.currentState!.validate() &&
                      widget.cita != null) {
                    // Actualizar la cita
                    Cita cita = Cita(
                      id: widget.cita!.id,
                      fecha: selectedDate.toString(),
                      hora: selectedTime.toString(),
                      cliente: _selectedCliente!,
                      detallesCitas: serviciosSeleccionados,
                    );
                    // Aquí puedes guardar la cita en tu base de datos o hacer lo que necesites con ella
                    // print(jsonEncode(cita.toJson()));
                    servicioCita.updateCita(cita.id, cita.toJson());

                    Navigator.pop(context);
                  }
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
