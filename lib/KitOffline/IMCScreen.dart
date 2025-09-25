import 'package:flutter/material.dart';

class IMCScreen extends StatefulWidget {
  const IMCScreen({super.key});

  @override
  State<IMCScreen> createState() => _IMCScreenState();
}

class _IMCScreenState extends State<IMCScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pesoCtrl = TextEditingController();
  final TextEditingController _estaturaCtrl = TextEditingController();

  void _calcularIMC() {
    if (!_formKey.currentState!.validate()) return;

    double peso = double.parse(_pesoCtrl.text);
    double estatura = double.parse(_estaturaCtrl.text);
    double imc = peso / (estatura * estatura);

    String categoria;
    Color color;

    if (imc < 18.5) {
      categoria = "Bajo peso";
      color = Colors.blue;
    } else if (imc < 25) {
      categoria = "Normal";
      color = Colors.green;
    } else if (imc < 30) {
      categoria = "Sobrepeso";
      color = Colors.orange;
    } else {
      categoria = "Obesidad";
      color = Colors.red;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("IMC: ${imc.toStringAsFixed(2)} ($categoria)"),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _limpiar() {
    _pesoCtrl.clear();
    _estaturaCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculadora de IMC")),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Calcula tu Índice de Masa Corporal",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _pesoCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Peso (kg)",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.fitness_center),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return "Ingresa tu peso";
                          if (double.tryParse(v) == null ||
                              double.parse(v) <= 0) {
                            return "Número válido mayor a 0";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _estaturaCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Estatura (m)",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.height),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Ingresa tu estatura";
                          }
                          if (double.tryParse(v) == null ||
                              double.parse(v) <= 0) {
                            return "Número válido mayor a 0";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _calcularIMC,
                              icon: const Icon(Icons.calculate),
                              label: const Text("Calcular"),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _limpiar,
                              icon: const Icon(Icons.cleaning_services),
                              label: const Text("Limpiar"),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                side: const BorderSide(color: Colors.teal),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
