import 'package:flutter/material.dart';

class AboutThisProjectScreen extends StatelessWidget {
  const AboutThisProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del proyecto (screenshot de tu portafolio)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                "assets/images/portfolio_preview.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // Descripción general
            const Text(
              "Descripción del Proyecto",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Este proyecto es un simulador interactivo desarrollado completamente en Flutter que representa mi portafolio profesional. "
              "La aplicación tiene como objetivo mostrar mis habilidades como desarrollador Flutter, mi experiencia en arquitectura limpia y el uso de buenas prácticas en el desarrollo multiplataforma.",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 20),

            // Tecnologías usadas
            const Text(
              "Tecnologías Flutter Utilizadas",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                TechChip(icon: Icons.flutter_dash, label: "Flutter"),
                TechChip(icon: Icons.developer_mode, label: "Dart"),
                TechChip(icon: Icons.layers, label: "Clean Architecture"),
                TechChip(icon: Icons.architecture, label: "MVVM Pattern"),
                TechChip(icon: Icons.settings_suggest, label: "State Management"),
                TechChip(icon: Icons.animation, label: "Animations & Transitions"),
                TechChip(icon: Icons.widgets, label: "Material Design 3"),
                TechChip(icon: Icons.web, label: "Flutter Web"),
              ],
            ),
            const SizedBox(height: 20),

            // Objetivo del proyecto
            const Text(
              "Objetivo del Proyecto",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "El objetivo principal de este portafolio es demostrar mi capacidad para construir interfaces modernas, animadas y modulares en Flutter. "
              "Cada sección fue pensada como si fuera una 'feature' dentro de una aplicación real, aplicando principios de composición, "
              "responsividad y buenas prácticas de desarrollo.",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 20),

            // Características principales
            const Text(
              "Características Principales",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const FeatureItem("Diseño 100% desarrollado en Flutter"),
            const FeatureItem("Arquitectura modular basada en Clean Architecture"),
            const FeatureItem("Transiciones fluidas y animaciones personalizadas"),
            const FeatureItem("Adaptable a dispositivos móviles y web"),
            const FeatureItem("Secciones interactivas de experiencia, proyectos y logros"),
            const FeatureItem("Gestión del estado desacoplada de la UI"),
            const SizedBox(height: 30),

            // Botones
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.code),
                    label: const Text("Ver Código Fuente"),
                    onPressed: () {
                      // TODO: agregar enlace a GitHub
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.play_circle_fill),
                    label: const Text("Ver Demo en Vivo"),
                    onPressed: () {
                      // TODO: agregar enlace demo web
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TechChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const TechChip({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18, color: Colors.indigoAccent),
      label: Text(label),
      backgroundColor: Colors.indigo[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String text;

  const FeatureItem(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.indigoAccent, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
