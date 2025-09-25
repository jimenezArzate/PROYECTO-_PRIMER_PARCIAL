import 'package:flutter/material.dart';

/// Pantalla "Primera"
/// Muestra un fondo degradado, el nombre "Lupita",
/// el texto "Hola Mundo!" en el centro y un botón para regresar.
class Primera extends StatelessWidget {
  const Primera({super.key}); // Constructor de la clase

  /// El método build es el que crea y dibuja
  /// todos los widgets de esta pantalla.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold es la estructura base de la pantalla
      // (permite usar fondo, botones flotantes, etc.)
      body: Container(
        // Container es un contenedor que se puede decorar.
        // Aquí lo usamos para poner el fondo degradado.
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            // Colores del degradado: de morado a azul
            colors: [Colors.deepPurple, Colors.blueAccent],
            begin: Alignment.topLeft, // Inicio del degradado
            end: Alignment.bottomRight, // Fin del degradado
          ),
        ),
        child: Column(
          // Coloca los elementos en columna vertical
          children: [
            // ---- ENCABEZADO CON NOMBRE ----
            Container(
              padding: const EdgeInsets.all(16), // Espacio interno
              alignment: Alignment.center, // Centra el texto
              child: const Text(
                "Lupita", // Texto que aparece arriba
                style: TextStyle(
                  fontSize: 28, // Tamaño de letra
                  fontWeight: FontWeight.bold, // Negritas
                  fontFamily: "Roboto", // Tipo de letra
                  color: Colors.white, // Color blanco
                  letterSpacing: 2, // Espacio entre letras
                ),
              ),
            ),

            // Spacer agrega espacio flexible para empujar
            // el siguiente widget hacia el centro.
            const Spacer(),

            // ---- TEXTO PRINCIPAL ----
            const Text(
              'Hola Mundo!', // Mensaje principal
              style: TextStyle(
                fontSize: 24, // Tamaño del texto
                color: Colors.white, // Color blanco
                fontWeight: FontWeight.w600, // Semi-negritas
              ),
            ),

            const Spacer(),

            // ---- BOTÓN REGRESAR ----
            Padding(
              padding: const EdgeInsets.all(16.0), // Margen alrededor del botón
              child: ElevatedButton(
                // Estilo del botón
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Color de fondo
                  foregroundColor: Colors.deepPurple, // Color del texto/ícono
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ), // Tamaño interno
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30,
                    ), // Bordes redondeados
                  ),
                ),
                // onPressed: acción que ocurre al tocar el botón
                onPressed: () => Navigator.pop(context),
                // Navigator.pop(context) cierra esta pantalla
                // y regresa a la anterior.
                child: const Text(
                  "Regresar",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold, // Texto en negritas
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
