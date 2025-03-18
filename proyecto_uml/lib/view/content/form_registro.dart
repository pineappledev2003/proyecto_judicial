import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_uml/controllers/cuaderno/cuaderno_controller_list.dart';
import 'package:proyecto_uml/controllers/despacho/despacho_controller_list.dart';
import 'package:proyecto_uml/controllers/expediente/expediente_controller_list.dart';
import 'package:proyecto_uml/controllers/persona/persona_controller_list.dart';
import 'package:proyecto_uml/controllers/retencion_documental/retencion_documental_controller_list.dart';
import 'package:proyecto_uml/models/cuaderno.dart';
import 'package:proyecto_uml/models/despacho_judicial.dart';
import 'package:proyecto_uml/models/persona.dart';
import 'package:proyecto_uml/models/serie.dart';
import 'package:proyecto_uml/models/subserie.dart';
import 'package:proyecto_uml/utils/notification.dart';
import 'package:proyecto_uml/view/content/form_persona.dart';
import 'package:proyecto_uml/view/custom_widgets/boxlist.dart';
import 'package:proyecto_uml/view/custom_widgets/button.dart';
import 'package:proyecto_uml/view/custom_widgets/input.dart';
import 'package:proyecto_uml/widgets/counter_controls.dart';
import 'package:validatorless/validatorless.dart';

class FormExpediente extends StatefulWidget {
  final String title;

  const FormExpediente({super.key, required this.title});

  @override
  FormExpedienteState createState() => FormExpedienteState();
}

class FormExpedienteState extends State<FormExpediente> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codigoController = TextEditingController();
  int _countNumeroCuadero = 0;

  String generarCodigoUnico() {
    List<int> digitos = List.generate(10, (index) => index); // Números del 0 al 9
    digitos.shuffle(Random());

    return digitos.take(10).join() + List.generate(13, (_) => Random().nextInt(10)).join();
  }

  void _handleSubmit() {
    Notificacion.mostrar("Registro guardado correctamente");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _codigoController.text = generarCodigoUnico();
    _countNumeroCuadero = 1;
  }

  void _handlePersonas() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 500,
            width: 800,
            child: FormPersona(title: "Registro de personas"),
          ),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("Cerrar"))],
        );
      },
    );
  }

  DespachoJudicial? _seleccionarDespacho;
  Serie? _seleccionarCodigoSerie;
  SubSerie? _seleccionarCodigoSubSerie;

  List<DespachoJudicial> _despachoJudicialList = [];

  List<Serie> _codigoSerieList = [];

  List<SubSerie> _codigoSubSerieList = [];

  List<String>? _nombreCuadernos = [];
  List<String>? _descripcionCuadernos = [];

  bool _expfisico = false;
  bool _docfisico = false;

  @override
  Widget build(BuildContext context) {
    final _controllerDespachoList = Provider.of<DespachoListaController>(context);
    _despachoJudicialList = _controllerDespachoList.obtenerListaDespacho();

    final _controllerRetencionDocumentalList = Provider.of<RetencionDocumentalControllerList>(
      context,
    );

    _codigoSerieList = _controllerRetencionDocumentalList.obtenerListaSerieEnLista;

    final _controllerPersonaList = Provider.of<ControllerPersonaList>(context);

    List<Persona> _personasTipoAList = _controllerPersonaList.filtarPorRolA();
    List<Persona> _personasTipoBList = _controllerPersonaList.filtarPorRolB();

    final _controllerExpedienteList = Provider.of<ControllerExpedienteList>(context);

    final _controllerCuadernoList = Provider.of<ControllerCuadernoList>(context);

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
              label: "Número de radicado",
              controller: _codigoController,
              keyboardType: TextInputType.number,
              maxLength: 23,
              readOnly: true,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: BoxList(
                      items:
                          _despachoJudicialList.map((DespachoJudicial despacho) {
                            return DropdownMenuItem(
                              value: despacho,
                              child: Text(
                                "Ciudad: ${despacho.obtenerCiudad.obtenerNombreCiudad} - Despacho: ${despacho.obtenerNombreDespacho}",
                              ),
                            );
                          }).toList(),
                      hint: 'Despacho Judicial',
                      value: _seleccionarDespacho,
                      onChanged: (newValue) {
                        setState(() {
                          _seleccionarDespacho = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Selecciona un despacho";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                CustomButton(text: "Personas", onPressed: _handlePersonas),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: BoxList(
                      items:
                          _codigoSerieList.map((Serie serie) {
                            return DropdownMenuItem(
                              value: serie,
                              child: Text(
                                "Codigo: ${serie.obtenerCodigoSerie} - Descripcion: ${serie.obtenerDescripcionSerie}",
                              ),
                            );
                          }).toList(),
                      hint: 'Serie',
                      value: _seleccionarCodigoSerie,
                      onChanged: (newValue) {
                        setState(() {
                          _seleccionarCodigoSerie = newValue!;
                          _codigoSubSerieList =
                              _seleccionarCodigoSerie!.obtenerSubSerie.values.toList();
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Selecciona una Serie";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: BoxList(
                      items:
                          _codigoSubSerieList.map((SubSerie subSerie) {
                            return DropdownMenuItem(
                              value: subSerie,
                              child: Text(
                                "Codigo: ${subSerie.obtenerCodigoSubSerie} - Descripcion: ${subSerie.obtenerDescripcionSubSerie}",
                              ),
                            );
                          }).toList(),
                      hint: 'Subserie',
                      value: _seleccionarCodigoSubSerie,
                      onChanged: (newValue) {
                        setState(() {
                          _seleccionarCodigoSubSerie = newValue!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Selecciona una SubSerie";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text("Personas Parte A", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: _personasTipoAList.length,
                itemBuilder: (context, index) {
                  Persona persona = _personasTipoAList[index];
                  return ListTile(
                    title: Text("${persona.obtenerNombrePersona} - ${persona.obtenerRol}"),
                    subtitle: Text(
                      "${persona.obtenerTipoDocumento}: ${persona.obtenerNumeroDocumento}",
                    ),
                  );
                },
              ),
            ),
            Text("Personas Parte B", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: _personasTipoBList.length,
                itemBuilder: (context, index) {
                  Persona persona = _personasTipoBList[index];
                  return ListTile(
                    title: Text("${persona.obtenerNombrePersona} - ${persona.obtenerRol}"),
                    subtitle: Text(
                      "${persona.obtenerTipoDocumento}: ${persona.obtenerNumeroDocumento}",
                    ),
                  );
                },
              ),
            ),
            counterControles(increment, decrement, refresh),
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
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("¿Expediente físico?", style: TextStyle(fontSize: 16)),
                SizedBox(width: 10),
                Switch(
                  activeColor: Colors.indigo,
                  value: _expfisico,
                  onChanged: (value) {
                    setState(() {
                      _expfisico = value;
                    });
                  },
                ),
                Text("¿Documento físico?", style: TextStyle(fontSize: 16)),
                SizedBox(width: 10),
                Switch(
                  activeColor: Colors.indigo,
                  value: _docfisico,
                  onChanged: (value) {
                    setState(() {
                      _docfisico = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            CustomButton(
              text: "Registrar",
              onPressed: () {
                if (_personasTipoAList.isEmpty || _personasTipoBList.isEmpty) {
                  Notificacion.mostrar(
                    "Debe agregar al menos un demandante y un demandado antes de registrar el expediente.",
                    isError: true,
                  );
                  return;
                }

                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  List<Cuaderno> listaCuadernos = [];
                  for (int i = 0; i < _nombreCuadernos!.length; i++) {
                    listaCuadernos.add(
                      Cuaderno(
                        nombreCuaderno: _nombreCuadernos![i],
                        descripcion: _descripcionCuadernos![i],
                        documentos: [],
                      ),
                    );
                  }

                  for (var cuaderno in listaCuadernos) {
                    _controllerCuadernoList.registrarCuaderno(
                      cuaderno.obtenerNombreCuaderno,
                      cuaderno.obtenerDescripcion,
                    );
                  }

                  _controllerExpedienteList.registarExpediente(
                    _seleccionarDespacho!,
                    _codigoController.text,
                    _seleccionarCodigoSerie!,
                    _seleccionarCodigoSubSerie!,
                    _personasTipoAList,
                    _personasTipoBList,
                    {for (var cuaderno in listaCuadernos) cuaderno.obtenerNombreCuaderno: cuaderno},
                    _expfisico,
                    _docfisico,
                  );

                  _handleSubmit();

                  _controllerExpedienteList.mostrarListaExpedientesEnConsola();

                  _formKey.currentState!.reset();

                  setState(() {
                    _codigoController.text = generarCodigoUnico();
                    _seleccionarDespacho = null;
                    _seleccionarCodigoSerie = null;
                    _seleccionarCodigoSubSerie = null;
                    _nombreCuadernos = [];
                    _descripcionCuadernos = [];
                    _countNumeroCuadero = 1;
                    _expfisico = false;
                    _docfisico = false;
                    _controllerPersonaList.limpiarPersonas();
                  });
                }
              },
            ),
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

  void decrement() {
    if (_countNumeroCuadero > 1) {
      setState(() {
        _countNumeroCuadero--;
      });
    }
  }

  void refresh() {
    setState(() {
      _countNumeroCuadero = 1;
    });
  }
}
