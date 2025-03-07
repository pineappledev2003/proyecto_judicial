import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_uml/controller/controller_despacho_judicial.dart';
import 'package:proyecto_uml/models/ciudad.dart';
import 'package:proyecto_uml/models/departamento.dart';

class RegistarDespachoJudicial extends StatefulWidget {
  final ControllerDespachoJudicial? controllerDespachoJudicial;
  const RegistarDespachoJudicial({super.key, required this.controllerDespachoJudicial});

  @override
  State<RegistarDespachoJudicial> createState() => _RegistarDespachoJudicialState();
}

class _RegistarDespachoJudicialState extends State<RegistarDespachoJudicial> {
  final _formKey = GlobalKey<FormState>();
  Departamento? _seleccionarDepartamento;
  Ciudad? _seleccionarCiudad;
  List<Ciudad> _ciudades = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registar Despacho"), centerTitle: true),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            DropdownButton<Departamento>(
              hint: Text("Seleccione un departamento"),
              value: _seleccionarDepartamento,
              // Convertimos la lista de departamentos en una lista de DropdownMenuItem.
              // Usamos el método map para iterar sobre cada departamento y transformarlo en un DropdownMenuItem.
              // Para la iteración, necesitamos como parámetro el mismo tipo de elemento del cual se compone la lista que recibe obtenerDepartamentos.
              // Por eso, en el map usamos Departamento departamento.
              // Esto es necesario porque DropdownButton espera una lista de DropdownMenuItem en su propiedad items.
              items:
                  widget.controllerDespachoJudicial!.obtenerDepartamentos().map((
                    Departamento departamento,
                  ) {
                    return DropdownMenuItem(
                      value: departamento,
                      child: Text(departamento.obtenerNombreDepartamento),
                    );
                  }).toList(),
              // Aquí se especifica Departamento? newValue porque estamos indicando que la variable newValue debe ser de tipo Departamento.
              // Esto asegura que se pueda asignar a la variable _seleccionarDepartamento, que también es de tipo Departamento.
              // Sin embargo, podríamos eliminar Departamento? en el onChanged, ya que el tipo de valor esperado es implícito.
              // debido a que _seleccionarDepartamento es tipo Departamento
              onChanged: (Departamento? newValue) {
                setState(() {
                  _seleccionarDepartamento = newValue;

                  //Cuando seleccione un departemento este se vendra buscar en este metodo
                  _ciudades = widget.controllerDespachoJudicial!.obtenerCiudadesPorDepartamento(
                    newValue!,
                  );
                  // Aseguramos el correcto cambio de la ciudad cuando el departamento es cambiado
                  _seleccionarCiudad = null;
                });
              },
            ),
            if (_seleccionarDepartamento != null)
              DropdownButton<Ciudad>(
                hint: Text("Seleccione una ciudad"),
                value: _seleccionarCiudad,
                items:
                    _ciudades.map((Ciudad ciudad) {
                      return DropdownMenuItem<Ciudad>(
                        value: ciudad,
                        child: Text(ciudad.obtenerNombreCiudad),
                      );
                    }).toList(),
                onChanged: (Ciudad? newValue) {
                  setState(() {
                    _seleccionarCiudad = newValue;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}
