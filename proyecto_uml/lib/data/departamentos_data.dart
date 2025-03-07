import 'package:proyecto_uml/models/ciudad.dart';
import 'package:proyecto_uml/models/departamento.dart';

List<Departamento> obtenerDepartamentos() {
  //Ciudades del Departamento de Antioquia

  Ciudad c1 = Ciudad(nombreCiudad: "Medellin");
  Ciudad c2 = Ciudad(nombreCiudad: "Envigado");
  Ciudad c3 = Ciudad(nombreCiudad: "Itagui");
  Ciudad c4 = Ciudad(nombreCiudad: "Bello");
  Ciudad c5 = Ciudad(nombreCiudad: "Rio negro");
  Ciudad c6 = Ciudad(nombreCiudad: "Turbo");

  //Ciudades del departmento de Cundinamarca

  Ciudad c7 = Ciudad(nombreCiudad: "Bogota");
  Ciudad c8 = Ciudad(nombreCiudad: "Soacha");
  Ciudad c9 = Ciudad(nombreCiudad: "Zipaquira");
  Ciudad c10 = Ciudad(nombreCiudad: "Chia");
  Ciudad c11 = Ciudad(nombreCiudad: "Fusagause");
  Ciudad c12 = Ciudad(nombreCiudad: "Girardot");

  //Ciudades del departamento de Valle de Cauca

  Ciudad c13 = Ciudad(nombreCiudad: "Cali");
  Ciudad c14 = Ciudad(nombreCiudad: "Palmira");
  Ciudad c15 = Ciudad(nombreCiudad: "Tulua");
  Ciudad c16 = Ciudad(nombreCiudad: "Buenaventura");
  Ciudad c17 = Ciudad(nombreCiudad: "Buga");
  Ciudad c18 = Ciudad(nombreCiudad: "Cartago");

  //Ciudades del departamento de Atlantico

  Ciudad c19 = Ciudad(nombreCiudad: "Barranquilla");
  Ciudad c20 = Ciudad(nombreCiudad: "Soledad");
  Ciudad c21 = Ciudad(nombreCiudad: "Malambo");
  Ciudad c22 = Ciudad(nombreCiudad: "Puerto Colombia");
  Ciudad c23 = Ciudad(nombreCiudad: "Sabanalagra");
  Ciudad c24 = Ciudad(nombreCiudad: "Galapa");

  //Ciudades del departamento de Cesar

  Ciudad c25 = Ciudad(nombreCiudad: "Aguachica");
  Ciudad c26 = Ciudad(nombreCiudad: "Astrea");
  Ciudad c27 = Ciudad(nombreCiudad: "Paz");
  Ciudad c28 = Ciudad(nombreCiudad: "Bosconia");
  Ciudad c29 = Ciudad(nombreCiudad: "San diego");
  Ciudad c30 = Ciudad(nombreCiudad: "Valledupar");

  Departamento antioquia = Departamento(
    nombreDepartamento: "Antioquia",
    ciudades: [c1, c2, c3, c4, c5, c6],
  );

  Departamento cundinamarca = Departamento(
    nombreDepartamento: "Cundinamarca",
    ciudades: [c7, c8, c9, c10, c11, c12],
  );

  Departamento valleDelCauda = Departamento(
    nombreDepartamento: "Valle del Cauca",
    ciudades: [c13, c14, c15, c16, c17, c18],
  );

  Departamento atlantico = Departamento(
    nombreDepartamento: "Atlantico",
    ciudades: [c19, c20, c21, c22, c23, c24],
  );

  Departamento cesar = Departamento(
    nombreDepartamento: "Cesar",
    ciudades: [c25, c26, c27, c28, c29, c30],
  );

  return [antioquia, cundinamarca, valleDelCauda, atlantico, cesar];
}
