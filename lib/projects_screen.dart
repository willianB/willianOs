import 'package:flutter/material.dart';
import 'package:mobile/bubble_notification_animated.dart';
import 'package:mobile/gallery_screen.dart';

class ProjectsScreen extends StatelessWidget {
  // callback opcional para solicitar la navegación dentro del "device simulator"
  final void Function(String target)? onNavigate;

  const ProjectsScreen({Key? key, this.onNavigate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BubbleNotification.show(
        context,
        duration: const Duration(seconds: 15),
        message:
            "Actualmente me estoy divirtiendo \nmigrando Pico y Placa Popayán  \na Kotlin Multi Platform 📲🤩",
      );
    });

    final projects = [
      {
        "id": "picoplaca",
        "title": "Pico y Placa Popayán",
        "year": "2025",
        "description":
            "App Android que notifica restricciones vehiculares en Popayán. Cuenta con verificación de seguridad de app y dispositivo.",
        "image": "../assets/image/logo_pico_placa.png",
        "tags": [
          "Ktor",
          "EC2",
          "Jetpack Compose",
          "MVVM",
          "Dagger Hilt",
          "CI/CD",
          "Firebase",
        ],
        "link": "https://play.google.com/store/apps/details?id=...",
      },
      {
        "id": "ecohogar",
        "title": "EcoHogar",
        "year": "2022",
        "description":
            "App de monitoreo de consumo eléctrico en tiempo real, control remoto de dispositivos y generación de reportes.",
        "image": "../assets/image/ecohogar_logo.png",
        "tags": [
          "Kotlin",
          "MongoDB",
          "Jetpack Compose",
          "MVVM",
          "Retrofit2",
          "Room DB",
          "IoT",
        ],
        "link": null,
      }
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final project = projects[index];
            // pasamos el context al card para usar Navigator local si hace falta
            return _projectCard(context, project);
          },
        ),
      ),
    );
  }

  Widget _projectCard(BuildContext context, Map<String, dynamic> project) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del proyecto
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              project["image"],
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(
                height: 180,
                color: Colors.grey.shade200,
                child: const Center(child: Icon(Icons.broken_image)),
              ),
            ),
          ),

          // Info del proyecto
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${project["title"]} (${project["year"]})",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Text(
                  project["description"],
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 12),

                // Tags de tecnologías
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: (project["tags"] as List<String>)
                      .map((tag) => Chip(
                            label: Text(tag),
                            backgroundColor: Colors.blue.shade50,
                            labelStyle: const TextStyle(
                                color: Colors.blue, fontSize: 12),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 12),

                // Botón de acción (link a Google Play)
                if (project["link"] != null)
                  ElevatedButton.icon(
                    onPressed: () {
                      // Aquí abres el enlace en web (puedes usar url_launcher)
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.open_in_new, color: Colors.white),
                    label: const Text("Ver en Google Play",
                        style: TextStyle(color: Colors.white)),
                  ),

                const SizedBox(height: 8),

                // Botón Galería — usa la callback si está disponible; si no, hace Navigator.push
                ElevatedButton.icon(
                  onPressed: () {
                    onNavigate!(project["id"]);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.photo_library, color: Colors.white),
                  label: const Text("Ver imágenes",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
