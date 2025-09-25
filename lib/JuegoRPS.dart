import 'dart:math';
import 'package:flutter/material.dart';

class JuegoRPS extends StatefulWidget {
  const JuegoRPS({super.key});

  @override
  State<JuegoRPS> createState() => _JuegoRPSState();
}

class _JuegoRPSState extends State<JuegoRPS> {
  final List<String> opciones = ["Piedra", "Papel", "Tijera"];
  String? eleccionUsuario;
  String? eleccionApp;
  String resultado = "";
  int puntosUsuario = 0;
  int puntosApp = 0;

  void jugar(String eleccion) {
    final random = Random();
    final app = opciones[random.nextInt(opciones.length)];

    setState(() {
      eleccionUsuario = eleccion;
      eleccionApp = app;

      if (eleccion == app) {
        resultado = "¡Empate!";
      } else if ((eleccion == "Piedra" && app == "Tijera") ||
          (eleccion == "Papel" && app == "Piedra") ||
          (eleccion == "Tijera" && app == "Papel")) {
        resultado = "¡Ganaste!";
        puntosUsuario++;
      } else {
        resultado = "Perdiste...";
        puntosApp++;
      }
    });
  }

  void reiniciar() {
    setState(() {
      puntosUsuario = 0;
      puntosApp = 0;
      resultado = "";
      eleccionUsuario = null;
      eleccionApp = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Juego: Piedra, Papel o Tijera"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Marcador
            Text(
              "Usuario $puntosUsuario : $puntosApp App",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Elecciones
            if (eleccionUsuario != null && eleccionApp != null) ...[
              Text(
                "Tú elegiste: $eleccionUsuario",
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                "App eligió: $eleccionApp",
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                resultado,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Botones para jugar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var opcion in opciones)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () => jugar(opcion),
                      child: Text(
                        opcion,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),

            // Botón Reiniciar
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              onPressed: reiniciar,
              child: const Text("Reiniciar marcador"),
            ),
          ],
        ),
      ),
    );
  }
}
