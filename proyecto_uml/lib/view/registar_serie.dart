import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_uml/controller/controller_retencion_documental.dart';
import 'package:proyecto_uml/models/serie.dart';
import 'package:proyecto_uml/models/subserie.dart';
import 'package:validatorless/validatorless.dart';

class RegistarSerieSubSerie extends StatefulWidget {
  const RegistarSerieSubSerie({super.key});

  @override
  State<RegistarSerieSubSerie> createState() => _RegistarSerieSubSerieState();
}

class _RegistarSerieSubSerieState extends State<RegistarSerieSubSerie> {
  final _formKey = GlobalKey<FormState>();
  String? _codigoSerie;
  String? _descripcionSerie;

  bool _registarSerie = false;

  List<String>? _codigoSubSerie = [];
  List<String>? _descripcionSubSerie = [];

  List<SubSerie> _subSeriesTemporales = [];
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count = 1;
  }

  @override
  Widget build(BuildContext context) {
    final _controllerRetencionDocumental = Provider.of<ControllerRetencionDocumental>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registar Serie con SubSerie"),
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
              decrement(count);
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
            TextFormField(
              decoration: InputDecoration(label: Text("INGRESAR EL CODIGO SERIE")),
              keyboardType: TextInputType.number,
              onSaved: (newValue) {
                _codigoSerie = newValue;
              },
              validator: Validatorless.multiple([
                Validatorless.required("Este campo es requerido"),
              ]),
            ),
            TextFormField(
              decoration: InputDecoration(label: Text("INGRESAR LA DESCRIPCION SERIE")),
              keyboardType: TextInputType.text,
              onSaved: (newValue) {
                _descripcionSerie = newValue;
              },
              validator: Validatorless.multiple([
                Validatorless.required("Este campo es requerido"),
              ]),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  Serie nuevaSerie = Serie(
                    codigoSerie: _codigoSerie!,
                    descripcionSerie: _descripcionSerie!,
                  );

                  _controllerRetencionDocumental.agregarSerie(nuevaSerie);

                  setState(() {
                    _registarSerie = true;
                  });
                }
              },
              child: const Text("Registar Serie"),
            ),

            if (_registarSerie == true) ...[
              Expanded(
                child: ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(label: Text("INGRESAR EL CODIGO SUBSERIE")),
                          keyboardType: TextInputType.number,
                          onSaved: (newValue) {
                            _codigoSubSerie!.add(newValue!);
                          },
                          validator: Validatorless.multiple([
                            Validatorless.required("Este campo es requerido"),
                          ]),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text("INGRESAR LA DESCRIPCION SUBSERIE"),
                          ),
                          keyboardType: TextInputType.text,
                          onSaved: (newValue) {
                            _descripcionSubSerie!.add(newValue!);
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    setState(() {
                      _subSeriesTemporales.clear();

                      for (int i = 0; i < _codigoSubSerie!.length; i++) {
                        if (!_subSeriesTemporales.any(
                          (existeSubSerie) =>
                              existeSubSerie.obtenerCodigoSubSerie == _codigoSubSerie![i],
                        )) {
                          _subSeriesTemporales.add(
                            SubSerie(
                              codigoSubSerie: _codigoSubSerie![i],
                              descripcionSubSerie: _descripcionSubSerie![i],
                            ),
                          );
                        }
                      }
                    });

                    _controllerRetencionDocumental.agregarSubSerie(
                      _codigoSerie!,
                      _subSeriesTemporales,
                    );
                  }
                },
                child: const Text("Registar SubSerie"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _controllerRetencionDocumental.mostrar();
                },
                child: const Text("Mostar"),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void increment() {
    setState(() {
      count++;
    });
  }

  void decrement(int count) {
    if (count > 1) {
      count--;
    }
  }

  void refresh() {
    setState(() {
      count = 1;
    });
  }
}
