import 'package:flutter/material.dart';
import 'package:proyecto_uml/controller/controller_despacho_judicial.dart';
import 'package:proyecto_uml/data/departamentos_data.dart';
import 'package:proyecto_uml/models/departamento.dart';
import 'package:proyecto_uml/view/despacho_judicial.dart';
import 'package:proyecto_uml/view/registar_serie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<Departamento> departamentos = obtenerDepartamentos();
    ControllerDespachoJudicial controller = ControllerDespachoJudicial(departamentos);

    return MaterialApp(
      title: "PRUEBA",
      initialRoute: "/",
      routes: {
        "/": (context) => RegistarDespachoJudicial(controllerDespachoJudicial: controller),
        "/RegistarSerie": (context) => RegistarSerie(),
      },
    );
  }
}
