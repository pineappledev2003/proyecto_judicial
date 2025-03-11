import 'package:flutter/material.dart';
import 'package:proyecto_uml/view/custom_widgets/button.dart';
import 'package:proyecto_uml/view/custom_widgets/input.dart';
import 'package:proyecto_uml/utils/notification.dart';


class FormCuaderno extends StatefulWidget {
  final String title;

  const FormCuaderno({super.key, required this.title});

  @override
  _FormCuadernoState createState() => _FormCuadernoState();
}

class _FormCuadernoState extends State<FormCuaderno> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  void _handleSubmit() {
    Notificacion.mostrar("Registro guardado correctamente");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0), 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.title, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          SizedBox(height: 20.0,),
          CustomInput(label: "Nombre", controller: _nombreController),
          CustomInput(label: "Descripción", controller: _descripcionController),
          CustomButton(text: "Registrar", onPressed: _handleSubmit),
        ],
      ),
    );
  }
}