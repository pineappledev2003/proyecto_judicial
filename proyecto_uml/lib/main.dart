import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_uml/controller/controller_cuaderno.dart';
import 'package:proyecto_uml/controller/controller_despacho_judicial.dart';
import 'package:proyecto_uml/controller/controller_expediente.dart';
import 'package:proyecto_uml/controller/controller_persona.dart';
import 'package:proyecto_uml/controller/controller_retencion_documental.dart';
import 'package:proyecto_uml/data/departamentos_data.dart';
import 'package:proyecto_uml/models/departamento.dart';
import 'package:proyecto_uml/view/despacho_judicial.dart';
import 'package:proyecto_uml/view/expediente.dart';
import 'package:proyecto_uml/view/personas.dart';
import 'package:proyecto_uml/view/registar_serie.dart';
import 'package:proyecto_uml/view/registrar_tipo_documental.dart';
//import 'package:proyecto_uml/view/registar_serie.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ControllerRetencionDocumental()),
        ChangeNotifierProvider(
          create: (context) {
            List<Departamento> departamentos = obtenerDepartamentos();
            return ControllerDespachoJudicial(departamentos);
          },
        ),
        ChangeNotifierProvider(create: (context) => ControllerExpediente()),
        ChangeNotifierProvider(create: (context) => ControllerPersona()),
        ChangeNotifierProvider(create: (context) => ControllerCuaderno()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PRUEBA",
      initialRoute: "/",
      routes: {
        //---------- MALOS -----------------------
        "/": (context) => RegistarDespachoJudicial(),
        "/RegistarSerie": (context) => RegistarSerieSubSerie(),
        "/registarTipoDocumental": (context) => RegistrarTipoDocumental(),
        "/registrarExpediente": (context) => RegistarExpediente(),
        "/registarPersona": (context) => RegistarPersona(),
      },
    );
  }
}
