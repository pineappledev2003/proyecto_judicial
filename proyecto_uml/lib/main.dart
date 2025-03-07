// import 'package:proyecto_uml/models/ciudad.dart';
// import 'package:proyecto_uml/models/depacho_judicial.dart';
// import 'package:proyecto_uml/models/departamento.dart';
// import 'package:proyecto_uml/models/serie.dart';
// import 'package:proyecto_uml/models/sub_serie.dart';
// import 'package:proyecto_uml/models/tipo_documental.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_uml/controller/controller_despacho_judicial.dart';
import 'package:proyecto_uml/data/departamentos_data.dart';
import 'package:proyecto_uml/models/departamento.dart';
import 'package:proyecto_uml/view/despacho_judicial.dart';

// Departamento d1 = Departamento(nombreDepartamento: "Antioquia");
// Departamento d2 = Departamento(nombreDepartamento: "Cundinamarca");

// List<Departamento> departamentos = [d1, d2];

// Ciudad c1 = Ciudad(nombreCiudad: "Medellin");
// Ciudad c2 = Ciudad(nombreCiudad: "Envigado");
// Ciudad c3 = Ciudad(nombreCiudad: "Bello");

// Ciudad c4 = Ciudad(nombreCiudad: "Soacha");
// Ciudad c5 = Ciudad(nombreCiudad: "Zipaquira");
// Ciudad c6 = Ciudad(nombreCiudad: "Chia");

// List<Ciudad> nuevasCiudadesAntioquia = [c1, c2, c3];
// List<Ciudad> nuevasCiudadesCundinamarca = [c4, c5, c6];

// d1.agregarCiudad(nuevasCiudadesAntioquia);
// d2.agregarCiudad(nuevasCiudadesCundinamarca);

// // 🔹 Recorrer la lista de departamentos(es decir la que cree en la linea 8) para imprimir su información
// for (var busquedaDepartamento in departamentos) {
//   print("Departamentos: ${busquedaDepartamento.obtenerNombreDepartamento}");

//   // 🔹 Recorrer la lista de ciudades asociadas a este departamento
//   for (var ciudad in busquedaDepartamento.obtenerListaCiudades) {
//     print("Ciudad: ${ciudad.obtenerNombreCiudad}");
//   }
// }

// DespachoJudicial de1 = DespachoJudicial(
//   codigoDespacho: "D001",
//   departamento: d2,
//   ciudad: c1,
//   nombreDespachoJudicial: "Despacho 1",
//   categoria: "Civil",
// );

// // Imprimir los detalles del despacho y sus ciudades
// print("Despacho Judicial: ${de1.obtenerNombreDespacho}");
// print("Código del despacho: ${de1.obtenerCodigoDespacho}");
// print("Categoría: ${de1.obtenerCategoria}");

// print("\nCiudades del Departamento '${de1.obtenerDepartamento.obtenerNombreDepartamento}':");
// List<Ciudad> ciudades = de1.obtenerCiudadesPorDepartamento();
// for (var ciudad in ciudades) {
//   print("Ciudad: ${ciudad.obtenerNombreCiudad}");
// }

// Serie s1 = Serie(codigo: "05", descripcion: "Acciones constitucionales");

// SubSerie sub1 = SubSerie(codigo: "15", descripcion: "Acciones de habeas Corpus");
// SubSerie sub2 = SubSerie(codigo: "25", descripcion: "Acciones de tutela");

// s1.agregarSubserie(sub1);
// s1.agregarSubserie(sub2);

// print("Serie - Código: ${s1.obtenerCodigo}, Descripción: ${s1.obtenerDescripicion}");
// s1.mostarSubSerie();

// TipoDocumental tipoDoc1 = TipoDocumental(tipoDocumental: "Solicitud de habeas corpus");
// TipoDocumental tipoDoc2 = TipoDocumental(tipoDocumental: "Acción de tutela");

// sub1.agregarTipoDocumentalSubSerie(tipoDoc1);
// sub2.agregarTipoDocumentalSubSerie(tipoDoc2);

// sub1.mostrarTipoDocumental();
// sub2.mostrarTipoDocumental();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<Departamento> departamentos = obtenerDepartamentos();
    ControllerDespachoJudicial controller = ControllerDespachoJudicial(departamentos);

    return MaterialApp(home: RegistarDespachoJudicial(controllerDespachoJudicial: controller));
  }
}
