import 'package:flutter/material.dart';
import 'NotasRapidasScreen.dart';
import 'IMCScreen.dart';
import 'GaleriaScreen.dart';
import 'ParImparScreen.dart';

class KitOfflineScreen extends StatelessWidget {
  const KitOfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kit Offline")),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 200, 16, 237),
              Color.fromARGB(255, 23, 217, 110),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              _moduleButton(
                context,
                title: "Notas",
                icon: Icons.note_alt,
                route: '/kit/notas',
              ),
              _moduleButton(
                context,
                title: "IMC",
                icon: Icons.monitor_weight,
                route: '/kit/imc',
              ),
              _moduleButton(
                context,
                title: "Galería",
                icon: Icons.photo,
                route: '/kit/galeria',
              ),
              _moduleButton(
                context,
                title: "Par/Impar",
                icon: Icons.calculate,
                route: '/kit/parimpar',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _moduleButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String route,
  }) {
    return SizedBox(
      width: 150,
      height: 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.9),
          foregroundColor: const Color.fromARGB(255, 24, 24, 24),
          shadowColor: Colors.black26,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () => Navigator.pushNamed(context, route),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
