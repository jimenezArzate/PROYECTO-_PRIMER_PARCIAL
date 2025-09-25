import 'dart:math';
import 'package:flutter/material.dart';

class ParImparScreen extends StatefulWidget {
  const ParImparScreen({super.key});

  @override
  State<ParImparScreen> createState() => _ParImparScreenState();
}

class _ParImparScreenState extends State<ParImparScreen> {
  int usuario = 0;
  int cpu = 0;
  String resultado = "";

  void jugar(bool esParUsuario, int numeroUsuario) {
    int numeroCPU = Random().nextInt(6);
    int suma = numeroUsuario + numeroCPU;
    bool esPar = suma % 2 == 0;

    if (esPar == esParUsuario) {
      usuario++;
      resultado = "¡Ganaste! $numeroUsuario + $numeroCPU = $suma";
    } else {
      cpu++;
      resultado = "Perdiste! $numeroUsuario + $numeroCPU = $suma";
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(resultado),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: esPar == esParUsuario ? Colors.green : Colors.red,
      ),
    );

    setState(() {});
  }

  void reiniciar() {
    setState(() {
      usuario = 0;
      cpu = 0;
      resultado = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Par o Impar"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Marcador\nUsuario: $usuario  |  CPU: $cpu",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Elige Par o Impar",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _mostrarSelector(true),
                  icon: const Icon(Icons.circle_outlined),
                  label: const Text("Par"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: () => _mostrarSelector(false),
                  icon: const Icon(Icons.cancel_outlined),
                  label: const Text("Impar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            OutlinedButton.icon(
              onPressed: reiniciar,
              icon: const Icon(Icons.refresh),
              label: const Text("Reiniciar"),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (resultado.isNotEmpty)
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.black87,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    resultado,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _mostrarSelector(bool esParUsuario) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Elige un número (0-5)"),
        content: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(6, (i) {
            return ElevatedButton(
              onPressed: () {
                jugar(esParUsuario, i);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade400,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text("$i", style: const TextStyle(fontSize: 18)),
            );
          }),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
