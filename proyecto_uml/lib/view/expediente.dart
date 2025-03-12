import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_uml/controller/controller_cuaderno.dart';
import 'package:proyecto_uml/controller/controller_despacho_judicial.dart';
import 'package:proyecto_uml/controller/controller_expediente.dart';
import 'package:proyecto_uml/controller/controller_persona.dart';
import 'package:proyecto_uml/controller/controller_retencion_documental.dart';
import 'package:proyecto_uml/models/cuaderno.dart';
import 'package:proyecto_uml/models/despacho_judicial.dart';
import 'package:proyecto_uml/models/persona.dart';
import 'package:proyecto_uml/models/serie.dart';
import 'package:proyecto_uml/models/subserie.dart';
import 'package:validatorless/validatorless.dart';

class RegistarExpediente extends StatefulWidget {
  const RegistarExpediente({super.key});

  @override
  State<RegistarExpediente> createState() => _RegistarExpedienteState();
}

class _RegistarExpedienteState extends State<RegistarExpediente> {
  final _formKey = GlobalKey<FormState>();

  Serie? _seleccionarCodigoSerie;
  SubSerie? _seleccionarCodigoSubSerie;
  DespachoJudicial? _seleccionarDespacho;

  Persona? _seleccionarPersonaA;
  Persona? _seleccionarPersonaB;

  List<Serie> _codigoSerie = [];
  List<SubSerie> _codigoSubSerie = [];
  List<DespachoJudicial> _despachoJudicial = [];

  List<Persona> _personasTipoA = [];
  List<Persona> _personasTipoB = [];

  bool? _tieneExpedienteFisico;
  bool? _tieneDocumentoFisico;

  int _countNumeroCuadero = 0;

  List<String>? _nombreCuadernos = [];
  List<String>? _descripcionCuadernos = [];

  @override
  Widget build(BuildContext context) {
    final controllerTipoSerieSubSerie = Provider.of<ControllerRetencionDocumental>(context);
    _codigoSerie = controllerTipoSerieSubSerie.obtenerListaSeries.values.toList();

    final controllerDespacho = Provider.of<ControllerDespachoJudicial>(context);
    _despachoJudicial = controllerDespacho.obtenerListaDespacho();

    final controllerPersona = Provider.of<ControllerPersona>(context);
    _personasTipoA = controllerPersona.filtarPorRolA();
    _personasTipoB = controllerPersona.filtarPorRolB();

    final controllerCuadero = Provider.of<ControllerCuaderno>(context);

    final controllerExpediente = Provider.of<ControllerExpediente>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar Expediente"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              increment();
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              decrement(_countNumeroCuadero);
            },
            icon: const Icon(Icons.abc),
          ),
          IconButton(
            onPressed: () {
              refresh();
            },
            icon: const Icon(Icons.new_label),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            DropdownButton<DespachoJudicial>(
              hint: Text("Seleccione Despacho"),
              value: _seleccionarDespacho,
              items:
                  _despachoJudicial.map((DespachoJudicial despacho) {
                    return DropdownMenuItem(
                      value: despacho,
                      child: Text(
                        "Ciudad: ${despacho.obtenerCiudad.obtenerNombreCiudad} - Despacho: ${despacho.obtenerNombreDespacho}",
                      ),
                    );
                  }).toList(),

              onChanged: (newValue) {
                setState(() {
                  _seleccionarDespacho = newValue;
                });
              },
            ),
            if (_codigoSerie.isEmpty) ...[
              Text("No hay series registradas"),
            ] else ...[
              DropdownButton<Serie>(
                hint: Text("Seleccione codigo serie"),
                value: _seleccionarCodigoSerie,
                items:
                    _codigoSerie.map((Serie serie) {
                      return DropdownMenuItem(
                        value: serie,
                        child: Text(
                          "Codigo: ${serie.obtenerCodigoSerie} - Descripcion: ${serie.obtenerDescripcionSerie}",
                        ),
                      );
                    }).toList(),

                onChanged: (newValue) {
                  setState(() {
                    _seleccionarCodigoSerie = newValue!;
                    _codigoSubSerie = _seleccionarCodigoSerie!.obtenerMapSubSerie.values.toList();
                  });
                },
              ),
              if (_seleccionarCodigoSerie != null) ...[
                if (_codigoSubSerie.isEmpty) ...[
                  const Text("No hay subseries registradas para esta serie"),
                ] else ...[
                  DropdownButton<SubSerie>(
                    hint: Text("Seleccione codigo serie"),
                    value: _seleccionarCodigoSubSerie,
                    items:
                        _codigoSubSerie.map((SubSerie subSerie) {
                          return DropdownMenuItem(
                            value: subSerie,
                            child: Text(
                              "Codigo: ${subSerie.obtenerCodigoSubSerie} - Descripcion: ${subSerie.obtenerDescripcionSubSerie}",
                            ),
                          );
                        }).toList(),

                    onChanged: (newValue) {
                      setState(() {
                        _seleccionarCodigoSubSerie = newValue!;
                      });
                    },
                  ),
                ],
              ],
              DropdownButton(
                hint: Text("Personas de TIPO A"),
                value: _seleccionarPersonaA,
                items:
                    _personasTipoA.map((Persona personaTipoA) {
                      return DropdownMenuItem(
                        value: personaTipoA,
                        child: Text(personaTipoA.obtenerNombrePersona),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    _seleccionarPersonaA = value;
                    _personasTipoA.add(value!);
                  });
                },
              ),
              DropdownButton(
                hint: Text("Personas de TIPO B"),
                value: _seleccionarPersonaB,
                items:
                    _personasTipoB.map((Persona personaTipoB) {
                      return DropdownMenuItem(
                        value: personaTipoB,
                        child: Text(personaTipoB.obtenerNombrePersona),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    _seleccionarPersonaB = value;
                    _personasTipoB.add(value!);
                  });
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _countNumeroCuadero,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(label: Text("INGRESAR NOMBRE CUADERNO")),
                          keyboardType: TextInputType.text,
                          onSaved: (newValue) {
                            _nombreCuadernos!.add(newValue!);
                          },
                          validator: Validatorless.multiple([
                            Validatorless.required("Este campo es requerido"),
                          ]),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text("INGRESAR LA DESCRIPCION CUADERNO"),
                          ),
                          keyboardType: TextInputType.text,
                          onSaved: (newValue) {
                            _descripcionCuadernos!.add(newValue!);
                          },
                          validator: Validatorless.multiple([
                            Validatorless.required("Este campo es requerido"),
                          ]),
                        ),
                      ],
                    );
                  },
                ),
              ),
              DropdownButton(
                value: _tieneDocumentoFisico,
                items: [
                  DropdownMenuItem(value: true, child: const Text("SI")),
                  DropdownMenuItem(value: false, child: const Text("NO")),
                ],
                onChanged: (value) {
                  setState(() {
                    _tieneDocumentoFisico = value;
                  });
                },
              ),
              DropdownButton(
                value: _tieneExpedienteFisico,
                items: [
                  DropdownMenuItem(value: true, child: const Text("SI")),
                  DropdownMenuItem(value: false, child: const Text("NO")),
                ],
                onChanged: (value) {
                  setState(() {
                    _tieneExpedienteFisico = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    if (_seleccionarPersonaA == null || _seleccionarPersonaB == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Debe seleccionar ambas personas antes de registrar"),
                        ),
                      );
                      return;
                    }

                    List<Cuaderno> listaCuadernos = [];
                    for (int i = 0; i < _nombreCuadernos!.length; i++) {
                      listaCuadernos.add(
                        Cuaderno(
                          nombreCuaderno: _nombreCuadernos![i],
                          descripcion: _descripcionCuadernos![i],
                        ),
                      );
                    }

                    for (var cuaderno in listaCuadernos) {
                      controllerCuadero.registarCuaderno(cuaderno);
                    }

                    controllerExpediente.registarExpediente(
                      _seleccionarDespacho!,
                      "2123",
                      _seleccionarCodigoSerie!,
                      _seleccionarCodigoSubSerie!,
                      [_seleccionarPersonaA!],
                      [_seleccionarPersonaB!],
                      {
                        for (var cuaderno in listaCuadernos)
                          cuaderno.obtenerNombreCuaderno: cuaderno,
                      },
                      _tieneExpedienteFisico!,
                      _tieneDocumentoFisico!,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Expediente registrado correctamente")),
                    );
                  }
                },
                child: const Text("Registrar Expediente"),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void increment() {
    setState(() {
      _countNumeroCuadero++;
    });
  }

  void decrement(int count) {
    if (_countNumeroCuadero > 1) {
      _countNumeroCuadero--;
    }
  }

  void refresh() {
    setState(() {
      _countNumeroCuadero = 1;
    });
  }
}
