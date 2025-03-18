import 'package:flutter/material.dart';
import 'package:proyecto_uml/controllers/retencion_documental/retencion_documental_controller_list.dart';
import 'package:proyecto_uml/controllers/retencion_documental/retencion_documental_controller_map.dart';
import 'package:proyecto_uml/models/subserie.dart';
import 'package:proyecto_uml/utils/notification.dart';
import 'package:proyecto_uml/view/custom_widgets/button.dart';
import 'package:proyecto_uml/view/custom_widgets/input.dart';
import 'package:proyecto_uml/widgets/counter_controls.dart';
import 'package:validatorless/validatorless.dart';

class FormSerie extends StatefulWidget {
  final String title;
  final dynamic controllerRetencionDocumental;

  const FormSerie({super.key, required this.title, required this.controllerRetencionDocumental});

  @override
  FormSerieState createState() => FormSerieState();
}

class FormSerieState extends State<FormSerie> {
  final _formKey = GlobalKey<FormState>();
  String? _codigoSerie;
  String? _descripcionSerie;

  List<TextEditingController> _codigoSubSerieControllers = [];
  List<TextEditingController> _descripcionSubSerieControllers = [];

  List<String>? _codigoSubSerie = [];
  List<String>? _descripcionSubSerie = [];
  List<SubSerie> _subSeriesTemporales = [];

  int count = 0;

  bool _registarSerie = false;
  bool _errorSerie = false;
  void _handleSubmit() {
    Notificacion.mostrar("Registro guardado correctamente");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count = 1;
    _codigoSubSerieControllers.add(TextEditingController());
    _descripcionSubSerieControllers.add(TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.title, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            CustomInput(
              label: "Código de Serie",
              keyboardType: TextInputType.number,
              onSaved: (value) {
                _codigoSerie = value;
              },
              validator: Validatorless.multiple([
                Validatorless.required("Este campo es requerido"),
                Validatorless.regex(RegExp(r'^\d+$'), "Solo se permiten números"),
              ]),
            ),
            CustomInput(
              label: "Descripción de Serie",
              onSaved: (value) {
                _descripcionSerie = value;
              },
              validator: Validatorless.multiple([
                Validatorless.required("Este campo es requerido"),
                Validatorless.regex(RegExp(r'^[a-zA-Z\s]+$'), "Solo se permiten letras y espacios"),
              ]),
            ),

            CustomButton(
              text: "Registrar",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  try {
                    setState(() {
                      _errorSerie = false;
                      _registarSerie = true;
                    });
                    widget.controllerRetencionDocumental.agregarSerie(
                      _codigoSerie!,
                      _descripcionSerie!,
                    );
                  } on ArgumentError catch (e) {
                    Notificacion.mostrar("Error: ${e.message}", isError: true);
                    setState(() {
                      _errorSerie = true;
                      _registarSerie = false;
                    });
                  } catch (e) {
                    Notificacion.mostrar("Error de entrada: $e", isError: true);
                    setState(() {
                      _errorSerie = true;
                      _registarSerie = false;
                    });
                  }
                }
              },
            ),

            if (_registarSerie == true && _errorSerie == false) ...[
              SizedBox(height: 20.0),
              Text(
                "Registro de SubSerie",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              counterControles(increment, decrement, refresh),
              Expanded(
                child: ListView.builder(
                  itemCount: count,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        SizedBox(height: 20.0),
                        CustomInput(
                          label: "Código de Subserie",
                          controller: _codigoSubSerieControllers[index],
                          validator: Validatorless.multiple([
                            Validatorless.required("Este campo es requerido"),
                            Validatorless.regex(RegExp(r'^\d+$'), "Solo se permiten números"),
                          ]),
                        ),
                        CustomInput(
                          label: "Descripción de Subserie",
                          controller: _descripcionSubSerieControllers[index],
                          validator: Validatorless.multiple([
                            Validatorless.required("Este campo es requerido"),
                            Validatorless.regex(
                              RegExp(r'^[a-zA-Z\s]+$'),
                              "Solo se permiten letras y espacios",
                            ),
                          ]),
                        ),
                      ],
                    );
                  },
                ),
              ),
              CustomButton(
                text: "Registrar SubSerie",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    try {
                      _codigoSubSerie!.clear();
                      _descripcionSubSerie!.clear();

                      for (var i = 0; i < count; i++) {
                        _codigoSubSerie!.add(_codigoSubSerieControllers[i].text.trim());
                        _descripcionSubSerie!.add(_descripcionSubSerieControllers[i].text.trim());
                      }

                      Set<String> codigosUnicos = {};
                      for (var codigo in _codigoSubSerie!) {
                        if (!codigosUnicos.add(codigo)) {
                          Notificacion.mostrar(
                            "Error: Hay códigos de subserie duplicados. Corrige antes de continuar.",
                            isError: true,
                          );
                          return;
                        }
                      }

                      setState(() {
                        _subSeriesTemporales.clear();

                        for (var i = 0; i < _codigoSubSerie!.length; i++) {
                          _subSeriesTemporales.add(
                            SubSerie(
                              codigoSubSerie: _codigoSubSerie![i],
                              descripcionSubSerie: _descripcionSubSerie![i],
                            ),
                          );
                        }
                      });

                      switch (widget.controllerRetencionDocumental) {
                        case RetencionDocumentalControllerList controlador:
                          controlador.agregarSubSerie(_codigoSerie!, _subSeriesTemporales);
                          _handleSubmit();
                          break;
                        case RetencionDocumentalMapaController controlador:
                          controlador.agregarSubSerie(_codigoSerie!, _subSeriesTemporales);
                          _handleSubmit();
                          break;
                      }

                      setState(() {
                        for (var controller in _codigoSubSerieControllers) {
                          controller.clear();
                        }
                        for (var controller in _descripcionSubSerieControllers) {
                          controller.clear();
                        }
                      });
                    } on ArgumentError catch (e) {
                      Notificacion.mostrar("Error: ${e.message}", isError: true);
                    } catch (e) {
                      Notificacion.mostrar("Ocurrió un error inesperado: $e", isError: true);
                    }

                    setState(() {
                      _registarSerie = false;
                    });
                  }
                },
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
      _codigoSubSerieControllers.add(TextEditingController());
      _descripcionSubSerieControllers.add(TextEditingController());
    });
  }

  void decrement() {
    if (count > 1) {
      setState(() {
        count--;
        _codigoSubSerieControllers.removeLast();
        _descripcionSubSerieControllers.removeLast();
      });
    }
  }

  void refresh() {
    setState(() {
      count = 1;
    });
  }
}
