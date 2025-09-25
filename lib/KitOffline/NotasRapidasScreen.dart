import 'package:flutter/material.dart';

class NotasRapidasScreen extends StatefulWidget {
  const NotasRapidasScreen({super.key});

  @override
  State<NotasRapidasScreen> createState() => _NotasRapidasScreenState();
}

class _NotasRapidasScreenState extends State<NotasRapidasScreen> {
  final List<String> _notas = [];
  final TextEditingController _controller = TextEditingController();

  void _agregarNota() {
    if (_controller.text.isEmpty) return;
    setState(() {
      _notas.add(_controller.text);
      _controller.clear();
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Nota agregada")));
  }

  void _borrarTodo() {
    setState(() => _notas.clear());
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Todas las notas borradas")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notas Rápidas"),
        backgroundColor: const Color.fromARGB(255, 231, 62, 228),
        actions: [
          IconButton(
            tooltip: "Borrar todas las notas",
            onPressed: _notas.isEmpty ? null : _borrarTodo,
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 237, 91, 227), Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: _notas.isEmpty
            ? const Center(
                child: Text(
                  "No tienes notas aún.\nPulsa el botón + para agregar una nota",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _notas.length,
                itemBuilder: (_, index) => Card(
                  elevation: 8,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.note_alt,
                      color: Color.fromARGB(255, 199, 65, 236),
                      size: 32,
                    ),
                    title: Text(
                      _notas[index],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.close, color: Colors.redAccent),
                      onPressed: () {
                        setState(() {
                          _notas.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Nota eliminada")),
                        );
                      },
                    ),
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                "Nueva Nota",
                style: TextStyle(color: Colors.teal),
              ),
              content: TextField(
                controller: _controller,
                autofocus: true,
                maxLength: 50,
                decoration: const InputDecoration(
                  hintText: "Escribe tu nota aquí",
                  counterText: "",
                  prefixIcon: Icon(Icons.edit_note, color: Colors.teal),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _agregarNota();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Agregar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 43, 157, 192),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Nueva Nota"),
        backgroundColor: const Color.fromARGB(255, 191, 71, 218),
        elevation: 8,
      ),
    );
  }
}
