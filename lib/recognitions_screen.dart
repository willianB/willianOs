import 'package:flutter/material.dart';

class RecognitionsScreen extends StatelessWidget {
  const RecognitionsScreen({super.key});

  final List<Map<String, String>> logros = const [
    {
      "titulo": "Top performance Globant 2024",
      "descripcion": "Reconocimiento por alto desempeño en 2024."
    },
    {
      "titulo": "Reconocimiento Interbank Perú Q2 (2024)",
      "descripcion": "Reconocimiento por desempeño en el segundo trimestre."
    },
    {
      "titulo": "Reconocimiento Interbank Q2",
      "descripcion": "Destacado en el segundo trimestre."
    },
    {
      "titulo": "Reconocimiento Interbank Perú Q3 (2024)",
      "descripcion": "Reconocimiento por desempeño en el tercer trimestre."
    },
    {
      "titulo": "Reconocimiento Interbank Q3",
      "descripcion": "Destacado en el tercer trimestre."
    },
    {
      "titulo": "WorldSkills Colombia 2013",
      "descripcion": "Medalla de Bronce en Diseño Web a nivel nacional."
    },
    {
      "titulo": "Senasoft 2013",
      "descripcion": "Primer puesto a nivel nacional en programación PHP."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: logros.length,
        itemBuilder: (context, index) {
          final logro = logros[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.star, color: Colors.amber, size: 32),
              title: Text(
                logro["titulo"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(logro["descripcion"]!),
            ),
          );
        },
      ),
    );
  }
}
