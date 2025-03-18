import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_uml/controllers/cuaderno/cuaderno_controller_list.dart';
import 'package:proyecto_uml/controllers/cuaderno/cuaderno_controller_map.dart';
import 'package:proyecto_uml/controllers/departamento_controller.dart';
import 'package:proyecto_uml/controllers/despacho/despacho_controller_list.dart';
import 'package:proyecto_uml/controllers/despacho/despacho_controller_map.dart';
import 'package:proyecto_uml/controllers/expediente/expediente_controller_list.dart';
import 'package:proyecto_uml/controllers/expediente/expediente_controller_map.dart';
import 'package:proyecto_uml/controllers/persona/persona_controller_list.dart';
import 'package:proyecto_uml/controllers/persona/persona_controller_map.dart';
import 'package:proyecto_uml/controllers/retencion_documental/retencion_documental_controller_list.dart';
import 'package:proyecto_uml/controllers/retencion_documental/retencion_documental_controller_map.dart';
import 'package:proyecto_uml/view/home.dart';

void main() {
  runApp(
    OKToast(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => DepartamentoController()),
          ChangeNotifierProvider(create: (context) => DespachoListaController()),
          ChangeNotifierProvider(create: (context) => DespachoMapaController()),
          ChangeNotifierProvider(create: (context) => RetencionDocumentalControllerList()),
          ChangeNotifierProvider(create: (context) => RetencionDocumentalMapaController()),

          ChangeNotifierProvider(create: (context) => ControllerPersonaList()),
          ChangeNotifierProvider(create: (context) => ControllerPersonaMap()),

          ChangeNotifierProvider(create: (context) => ControllerCuadernoList()),
          ChangeNotifierProvider(create: (context) => ControllerCuadernoMap()),

          ChangeNotifierProvider(create: (context) => ControllerExpedienteList()),
          ChangeNotifierProvider(create: (context) => ControllerExpedienteMap()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.rubikTextTheme()),
      initialRoute: "/home",
      routes: {"/home": (context) => Home()},
    );
  }
}
