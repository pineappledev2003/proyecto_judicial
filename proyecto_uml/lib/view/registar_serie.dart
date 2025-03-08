import 'package:flutter/material.dart';
import 'package:proyecto_uml/controller/serie_controller.dart';
import 'package:proyecto_uml/models/sub_serie.dart';
import 'package:validatorless/validatorless.dart';

class RegistarSerie extends StatefulWidget {
  const RegistarSerie({super.key});

  @override
  State<RegistarSerie> createState() => _RegistarSerieState();
}

class _RegistarSerieState extends State<RegistarSerie> {
  final SerieController _serieController = SerieController();
  final _formKey = GlobalKey<FormState>();

  // Variables para la serie
  String? _codigoSerie;
  String? _descripcionSerie;

  // Variables para la subserie
  String? _codigoSubSerie;
  String? _descripcionSubSerie;

  bool _registrarSerie = false;
  bool _registrarSubserie = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registrar Serie y Subserie"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo para el código de la serie
              TextFormField(
                decoration: InputDecoration(label: Text("Código de la Serie")),
                keyboardType: TextInputType.number,
                onSaved: (newValue) {
                  _codigoSerie = newValue;
                },
                validator: Validatorless.required("Este campo es requerido"),
              ),
              // Campo para la descripción de la serie
              TextFormField(
                decoration: InputDecoration(label: Text("Descripción de la Serie")),
                keyboardType: TextInputType.text,
                onSaved: (newValue) {
                  _descripcionSerie = newValue;
                },
                validator: Validatorless.required("Este campo es requerido"),
              ),
              // Botón para registrar la serie
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Llamamos al controlador para registrar la serie
                    _serieController.agregarSerieConSubserie(_codigoSerie!, _descripcionSerie!, []);
                    setState(() {
                      _registrarSerie = true;
                    });
                  }
                },
                child: const Text("Registrar Serie"),
              ),
              // Solo mostrar si la serie ha sido registrada
              if (_registrarSerie) ...[
                SizedBox(height: 20),
                // Campo para el código de la subserie
                TextFormField(
                  decoration: InputDecoration(label: Text("Código de la Subserie")),
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) {
                    _codigoSubSerie = newValue;
                  },
                  validator: Validatorless.required("Este campo es requerido"),
                ),
                // Campo para la descripción de la subserie
                TextFormField(
                  decoration: InputDecoration(label: Text("Descripción de la Subserie")),
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) {
                    _descripcionSubSerie = newValue;
                  },
                  validator: Validatorless.required("Este campo es requerido"),
                ),
                // Botón para registrar la subserie
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Crear la nueva subserie
                      SubSerie nuevaSubSerie = SubSerie(
                        codigo: _codigoSubSerie!,
                        descripcion: _descripcionSubSerie!,
                      );
                      // Agregar la subserie a la serie registrada
                      _serieController.agregarSerieConSubserie(_codigoSerie!, _descripcionSerie!, [
                        nuevaSubSerie,
                      ]);
                      setState(() {
                        _registrarSubserie = true;
                      });
                    }
                  },
                  child: const Text("Registrar Subserie"),
                ),
              ],
              SizedBox(height: 20),
              // Mostrar las series registradas
              ElevatedButton(
                onPressed: () {
                  _serieController.mostrarSeries();
                },
                child: const Text("Mostrar Series Registradas"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
