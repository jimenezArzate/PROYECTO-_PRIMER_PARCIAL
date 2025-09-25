import 'package:flutter/material.dart';

class GaleriaScreen extends StatelessWidget {
  const GaleriaScreen({super.key});

  final List<String> _imagenes = const [
    'assets/imagenes/bacalar.jpg',
    'assets/imagenes/lalo.jpg',
    'assets/imagenes/paraiso.jpg',
    'assets/imagenes/viaje.jpg',
    // Más imágenes
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Galería")),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _imagenes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // dos columnas
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.8, // < 1 => más alto que ancho
          ),
          itemBuilder: (context, index) {
            final img = _imagenes[index];
            return _imageCard(context, img);
          },
        ),
      ),
    );
  }

  Widget _imageCard(BuildContext context, String img) {
    return GestureDetector(
      onTap: () => _mostrarImagen(context, img),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.all(
                  8.0,
                ), // hace la imagen un poco más pequeña
                child: Image.asset(
                  img,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black54, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  img.split('/').last,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarImagen(BuildContext context, String img) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: Colors.black,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(img, fit: BoxFit.cover),
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.black87,
                      width: double.infinity,
                      child: Text(
                        img.split('/').last,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
