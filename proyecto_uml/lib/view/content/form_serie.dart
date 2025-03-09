import 'package:flutter/material.dart';
import 'package:proyecto_uml/view/custom_widgets/button.dart';
import 'package:proyecto_uml/view/custom_widgets/input.dart';
import 'package:proyecto_uml/utils/notification.dart';


class FormSerie extends StatefulWidget {
  final String title;

  const FormSerie({super.key, required this.title});

  @override
  _FormSerieState createState() => _FormSerieState();
}

class _FormSerieState extends State<FormSerie> {
  final TextEditingController _codigoSerieController = TextEditingController();
  final TextEditingController _descSerieController = TextEditingController();

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
          CustomInput(label: "Código de Serie", controller: _codigoSerieController),
          CustomInput(label: "Descripción de Serie", controller: _descSerieController),
          CustomButton(text: "Registrar", onPressed: _handleSubmit),
        ],
      ),
    );
  }
}