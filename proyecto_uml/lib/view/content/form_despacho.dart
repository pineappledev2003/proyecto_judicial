import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_uml/controllers/departamento_controller.dart';
import 'package:proyecto_uml/controllers/despacho/despacho_controller_list.dart';
import 'package:proyecto_uml/controllers/despacho/despacho_controller_map.dart';
import 'package:proyecto_uml/models/ciudad.dart';
import 'package:proyecto_uml/models/departamento.dart';
import 'package:proyecto_uml/utils/notification.dart';
import 'package:proyecto_uml/view/custom_widgets/boxlist.dart';
import 'package:proyecto_uml/view/custom_widgets/button.dart';
import 'package:proyecto_uml/view/custom_widgets/input.dart';
import 'package:validatorless/validatorless.dart';

class FormDespacho extends StatefulWidget {
  final String title;
  final dynamic controladorDespacho;

  const FormDespacho({super.key, required this.title, required this.controladorDespacho});

  @override
  FormDespachoState createState() => FormDespachoState();
}

class FormDespachoState extends State<FormDespacho> {
  final TextEditingController _codigoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? _nombreDespachoJudicial;
  Departamento? _seleccionarDepartamento;
  Ciudad? _seleccionarCiudad;

  String? _selectedCategoria;
  List<Ciudad> _ciudades = [];
  List<String> _categoriaDespacho = ["Municipal", "Circuito"];
  void _handleSubmit() {
    Notificacion.mostrar("Registro guardado correctamente");
  }

  String generarCodigoUnico() {
    List<int> digitos = List.generate(10, (index) => index); // Números del 0 al 9
    digitos.shuffle(Random()); // Mezcla los dígitos aleatoriamente
    return digitos.take(10).join(); // Toma los primeros 10 y los convierte en un String
  }

  @override
  void initState() {
    super.initState();
    _codigoController.text = generarCodigoUnico();
  }

  @override
  Widget build(BuildContext context) {
    final _controllerDepartamento = Provider.of<DepartamentoController>(context);

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
              label: "Código",
              keyboardType: TextInputType.number,
              controller: _codigoController,
              maxLength: 10,
              readOnly: true,
              filled: true,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              validator: Validatorless.multiple([
                Validatorless.required("Este campo es requerido"),
                Validatorless.regex(RegExp(r'^\d+$'), "Solo se permiten números"),
              ]),
            ),
            CustomInput(
              label: "Nombre Despacho",
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.characters,
              onSaved: (value) {
                _nombreDespachoJudicial = value;
              },
              validator: Validatorless.multiple([
                Validatorless.required("Este campo es requerido"),
                Validatorless.max(20, "El maximo de caracteres es 15"),
                Validatorless.min(10, "El minimo de caracteres es 10"),
                Validatorless.regex(RegExp(r'^[a-zA-Z\s]+$'), "Solo se permiten letras y espacios"),
              ]),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: BoxList(
                      items:
                          _controllerDepartamento.obtenerDepartamentos.map((departamento) {
                            return DropdownMenuItem(
                              value: departamento,
                              child: Text(departamento.obtenerNombreDepartamento),
                            );
                          }).toList(),
                      hint: 'Departamento',
                      value: _seleccionarDepartamento,
                      onChanged: (value) {
                        setState(() {
                          _seleccionarDepartamento = value;
                          _ciudades = _controllerDepartamento.obtenerCiudadesPorDepartamento(
                            value!,
                          );
                          _seleccionarCiudad = _ciudades.isNotEmpty ? _ciudades.first : null;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Seleccione un Departamento";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: BoxList<Ciudad>(
                      items:
                          _seleccionarDepartamento != null
                              ? _ciudades.map((ciudad) {
                                return DropdownMenuItem<Ciudad>(
                                  value: ciudad,
                                  child: Text(ciudad.obtenerNombreCiudad),
                                );
                              }).toList()
                              : [],
                      hint: 'Municipio',
                      value: _seleccionarCiudad,
                      onChanged:
                          _seleccionarDepartamento != null
                              ? (value) {
                                _seleccionarCiudad = value;
                              }
                              : null,
                      validator: (value) {
                        if (value == null) {
                          return "Seleccione un municipio";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: BoxList<String>(
                items:
                    _categoriaDespacho
                        .map(
                          (String categoria) =>
                              DropdownMenuItem(value: categoria, child: Text(categoria)),
                        )
                        .toList(),
                hint: "Categoria Despacho",
                onChanged: (value) {
                  _selectedCategoria = value;
                },
                validator: (value) {
                  if (value == null) {
                    return "Seleccione una categoria";
                  }
                  return null;
                },
              ),
            ),
            CustomButton(
              text: "Registrar",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  try {
                    widget.controladorDespacho.registrarDespacho(
                      _codigoController.text,
                      _seleccionarDepartamento!,
                      _seleccionarCiudad!,
                      _nombreDespachoJudicial!,
                      _selectedCategoria!,
                    );
                    _handleSubmit();

                    if (widget.controladorDespacho is DespachoListaController) {
                      (widget.controladorDespacho as DespachoListaController).mostrarListaDespachoList();
                    }else if(widget.controladorDespacho is DespachoMapaController){
                      (widget.controladorDespacho as DespachoMapaController).mostrarMapaDespachoMapa();
                    }
                  } catch (e) {
                    Notificacion.mostrar("Error en el registro: \$e", isError: true);
                  }

                  _formKey.currentState!.reset();

                  setState(() {
                    _codigoController.text = generarCodigoUnico();
                    _seleccionarCiudad = null;
                    _seleccionarDepartamento = null;
                    _selectedCategoria = null;
                  });

                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
