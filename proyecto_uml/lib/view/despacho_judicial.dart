import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_uml/controller/controller_despacho_judicial.dart';
import 'package:proyecto_uml/models/ciudad.dart';
import 'package:proyecto_uml/models/departamento.dart';
import 'package:validatorless/validatorless.dart';

class RegistarDespachoJudicial extends StatefulWidget {
  const RegistarDespachoJudicial({super.key});

  @override
  State<RegistarDespachoJudicial> createState() => _RegistarDespachoJudicialState();
}

class _RegistarDespachoJudicialState extends State<RegistarDespachoJudicial> {
  final _formKey = GlobalKey<FormState>();
  String? _codigoDespachoJudicial;
  Departamento? _seleccionarDepartamento;
  Ciudad? _seleccionarCiudad;
  String? _nombreDespachoJudicial;
  String? _categoria;
  List<Ciudad> _ciudades = [];

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ControllerDespachoJudicial>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Registar Despacho"), centerTitle: true),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(label: Text("INGRESAR EL CODIGO DESPACHO")),
              keyboardType: TextInputType.number,
              maxLength: 10,
              onSaved: (newValue) {
                _codigoDespachoJudicial = newValue;
              },
              validator: Validatorless.multiple([
                Validatorless.required("Este campo es requerido"),
              ]),
            ),

            DropdownButton<Departamento>(
              hint: Text("Seleccione un departamento"),
              value: _seleccionarDepartamento,
              // Convertimos la lista de departamentos en una lista de DropdownMenuItem.
              // Usamos el método map para iterar sobre cada departamento y transformarlo en un DropdownMenuItem.
              // Para la iteración, necesitamos como parámetro el mismo tipo de elemento del cual se compone la lista que recibe obtenerDepartamentos.
              // Por eso, en el map usamos Departamento departamento.
              // Esto es necesario porque DropdownButton espera una lista de DropdownMenuItem en su propiedad items.
              items:
                  controller.obtenerDepartamentos().map((Departamento departamento) {
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
                  _ciudades = controller.obtenerCiudadesPorDepartamento(newValue!);
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
            TextFormField(
              decoration: InputDecoration(label: Text("INGRESAR EL NOMBRE DEL DESPACHO")),
              keyboardType: TextInputType.text,
              maxLength: 15,
              onSaved: (newValue) {
                _nombreDespachoJudicial = newValue;
              },
              validator: Validatorless.multiple([
                Validatorless.required("Este campo es requerido"),
              ]),
            ),
            TextFormField(
              decoration: InputDecoration(label: Text("INGRESAR LA CATEGORIA")),
              keyboardType: TextInputType.text,
              onSaved: (newValue) {
                _categoria = newValue;
              },
              validator: Validatorless.multiple([
                Validatorless.required("Este campo es requerido"),
              ]),
            ),

            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  controller.registarDespacho(
                    _codigoDespachoJudicial!,
                    _seleccionarDepartamento!,
                    _seleccionarCiudad!,
                    _nombreDespachoJudicial!,
                    _categoria!,
                  );

                  for (var busquedaDespacho in controller.obtenerListaDespacho()) {
                    print("Codigo Despacho :${busquedaDespacho.obtenerCodigoDespacho}");
                    print(
                      "Departamento :${busquedaDespacho.obtenerDepartamento.obtenerNombreDepartamento}",
                    );
                    print("Ciudad :${busquedaDespacho.obtenerCiudad.obtenerNombreCiudad}");
                    print("NombreDespachoJudicial :${busquedaDespacho.obtenerNombreDespacho}");
                    print("Categoria :${busquedaDespacho.obtenerCategoria}");
                  }
                }
              },
              child: Text("Registar Despacho"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/RegistarSerie");
              },
              child: const Text("REGISTAR SERIE"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/registarTipoDocumental");
              },
              child: const Text("REGISTAR TIPO DOCUMENTAL"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/registrarExpediente");
              },
              child: const Text("expediente"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/registarPersona");
              },
              child: const Text("Persona"),
            ),
          ],
        ),
      ),
    );
  }
}
