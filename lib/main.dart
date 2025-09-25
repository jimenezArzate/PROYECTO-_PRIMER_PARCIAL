import 'package:flutter/material.dart';

// Importa tus pantallas (asegúrate de que los archivos existan y las clases estén exportadas)
import 'Primera.dart';
import 'Segunda.dart';
import 'Prac4.dart';
import 'JuegoRPS.dart';

import 'KitOffline/KitOfflineScreen.dart';
import 'KitOffline/NotasRapidasScreen.dart';
import 'KitOffline/IMCScreen.dart';
import 'KitOffline/GaleriaScreen.dart';
import 'KitOffline/ParImparScreen.dart';
import 'KitOffline/Ajustes.dart';

void main() => runApp(const MyApp());
// main(): punto de entrada de la aplicación.
// runApp() monta el widget raíz (MyApp) en el framework Flutter.

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // of(context): función de conveniencia para que otras pantallas puedan
  // obtener el estado (_MyAppState) y llamar métodos públicos (por ejemplo toggleTheme).
  // Útil cuando quieres cambiar el tema desde una pantalla hija.
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;

  @override
  State<MyApp> createState() => _MyAppState();
  // MyApp es Stateful porque guarda el ThemeMode (estado global de tema).
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  // _themeMode: almacena si la app está en modo claro u oscuro.

  // toggleTheme: función que cambia el themeMode. Se usa desde AjustesScreen.
  void toggleTheme(bool dark) {
    setState(() {
      _themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  // isDark: getter conveniente para saber rápidamente si el tema actual es oscuro.
  bool get isDark => _themeMode == ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    // build(): construye el MaterialApp con las rutas y la configuración de tema.
    // Cuando se llama setState en toggleTheme, build() se vuelve a ejecutar con el nuevo themeMode.
    return MaterialApp(
      title: 'Hub Principal - Kit Offline',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      themeMode: _themeMode, // <-- aquí se aplica el tema elegido
      initialRoute: '/',
      routes: {
        // Rutas nombradas: asocian cadenas a widgets. Navigator.pushNamed usa estas claves.
        '/': (_) => const HomeScreen(),
        '/ajustes': (_) =>
            AjustesScreen(toggleTheme: toggleTheme, themeMode: _themeMode),
        '/p1': (_) => const Primera(),
        '/p2': (_) => const Segunda(),
        '/p4': (_) => const Prac4(),
        '/juegoRPS': (_) => const JuegoRPS(),
        '/kit/offline': (_) => const KitOfflineScreen(),
        '/kit/notas': (_) => const NotasRapidasScreen(),
        '/kit/imc': (_) => const IMCScreen(),
        '/kit/galeria': (_) => const GaleriaScreen(),
        '/kit/parimpar': (_) => const ParImparScreen(),
      },
    );
  }
}

/// HomeScreen con mensaje tipo "grafiti"
/// Esta pantalla es la pantalla principal (ruta '/').
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold: proporciona la estructura básica (barra, cuerpo, etc.)
    return Scaffold(
      body: Stack(
        children: [
          // 1) Fondo degradado que ocupa toda la pantalla.
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 213, 109, 226),
                  Color.fromARGB(255, 214, 112, 112),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // 2) Contenido principal sobre el fondo (texto de bienvenida + botones)
          Column(
            children: [
              const SizedBox(height: 60),

              // Mensaje de bienvenida con estilo "grafiti" (shader + sombras)
              Center(
                child: Text(
                  "¡Bienvenida Lupita!",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    fontFamily:
                        'Cursive', // solicita una familia "cursiva"/tipo graffiti
                    // paint shader: aplica un degradado de color sobre el texto
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: <Color>[
                          const Color.fromARGB(255, 16, 16, 16),
                          const Color.fromARGB(255, 13, 13, 13),
                          const Color.fromARGB(255, 18, 18, 18),
                        ],
                      ).createShader(const Rect.fromLTWH(0, 0, 300, 70)),
                    shadows: const [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 4,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 40),

              // Botones principales (Prácticas, Kit Offline, Ajustes)
              Expanded(
                child: Center(
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      // Los _homeButton llaman a onTap que usa Navigator o showDialog.
                      _homeButton(context, "Prácticas", Icons.list, () {
                        showDialog(
                          context: context,
                          builder: (_) => const PracIndexDialog(),
                        );
                      }),
                      _homeButton(
                        context,
                        "Kit Offline",
                        Icons.videogame_asset,
                        () => Navigator.pushNamed(context, '/kit/offline'),
                      ),
                      _homeButton(
                        context,
                        "Ajustes",
                        Icons.settings,
                        () => Navigator.pushNamed(context, '/ajustes'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // _homeButton: helper que crea cada botón grande de la pantalla principal.
  // - onTap: callback que se ejecuta cuando el usuario pulsa el botón.
  // - aquí se estiliza con ElevatedButton.styleFrom para bordes, sombras y colores.
  Widget _homeButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return SizedBox(
      width: 150,
      height: 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.9),
          foregroundColor: const Color.fromARGB(255, 60, 61, 61),
          shadowColor: Colors.black26,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onTap,
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

/// PracIndexDialog: diálogo que muestra el índice de prácticas.
/// Cada ListTile cierra el diálogo y luego navega a la ruta correspondiente.
class PracIndexDialog extends StatelessWidget {
  const PracIndexDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Índice de Prácticas"),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: [
            // Cada ListTile:
            // - Navigator.pop(context) cierra el diálogo.
            // - Navigator.pushNamed(context, '/p1') navega a la ruta '/p1'.
            ListTile(
              leading: const Icon(Icons.looks_one),
              title: const Text("Hola Mundo"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/p1');
              },
            ),
            ListTile(
              leading: const Icon(Icons.looks_two),
              title: const Text("Hola MUndo 10 veces "),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/p2');
              },
            ),
            ListTile(
              leading: const Icon(Icons.looks_4),
              title: const Text(" (Registro)"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/p4');
              },
            ),
            ListTile(
              leading: const Icon(Icons.sports_handball),
              title: const Text("Juego: Piedra, Papel o Tijera"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/juegoRPS');
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // cierra el diálogo
          child: const Text("Cerrar"),
        ),
      ],
    );
  }
}
