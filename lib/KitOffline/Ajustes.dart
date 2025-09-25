import 'package:flutter/material.dart';

class AjustesScreen extends StatelessWidget {
  final Function(bool) toggleTheme;
  final ThemeMode themeMode;

  const AjustesScreen({
    super.key,
    required this.toggleTheme,
    required this.themeMode,
  });

  void _mostrarAcercaDe(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "Acerca de",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        content: const Text(
          "Versión 1.0\nAutor: Lupita\n\n",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text("Cerrar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajustes"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Tarjeta del modo oscuro
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SwitchListTile(
                title: const Text(
                  "Modo oscuro",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: const Text(
                  "Activa para cambiar entre tema claro y oscuro",
                  style: TextStyle(fontSize: 14),
                ),
                secondary: Icon(
                  themeMode == ThemeMode.dark
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  size: 40,
                  color: themeMode == ThemeMode.dark
                      ? Colors.black87
                      : Colors.yellow[700],
                ),
                value: themeMode == ThemeMode.dark,
                onChanged: toggleTheme,
              ),
            ),
            const SizedBox(height: 20),
            // Botón de Acerca de
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.info_outline,
                    size: 36,
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  "Acerca de",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: const Text("", style: TextStyle(fontSize: 14)),
                onTap: () => _mostrarAcercaDe(context),
              ),
            ),
            const SizedBox(height: 20),
            // Botón de soporte (opcional)
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.support_agent,
                  size: 36,
                  color: Colors.teal,
                ),
                title: const Text(
                  "Soporte",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: const Text(
                  "Contáctanos para ayuda o sugerencias",
                  style: TextStyle(fontSize: 14),
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Función de soporte próximamente"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
