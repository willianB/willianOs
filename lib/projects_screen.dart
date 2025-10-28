import 'package:flutter/material.dart';
import 'package:mobile/UrlLauncherHelper.dart';
import 'package:mobile/bubble_notification_animated.dart';

class ProjectsScreen extends StatefulWidget {
  final void Function(String target)? onNavigate;

  const ProjectsScreen({Key? key, this.onNavigate}) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  final projects = [
    {
      "id": "picoplaca",
      "title": "Pico y Placa Popayán",
      "year": "2025",
      "description":
          "App Android que notifica restricciones vehiculares en Popayán. Cuenta con verificación de seguridad de app y dispositivo.",
      "image": "assets/image/logo_pico_placa.png",
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
      "color": Colors.blue,
      "icon": Icons.directions_car,
    },
    {
      "id": "ecohogar",
      "title": "EcoHogar",
      "year": "2022",
      "description":
          "App de monitoreo de consumo eléctrico en tiempo real, control remoto de dispositivos y generación de reportes.",
      "image": "assets/image/ecohogar_logo.png",
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
      "color": Colors.green,
      "icon": Icons.energy_savings_leaf,
    },
  ];

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      projects.length,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 800),
      ),
    );

    _animations = _controllers.map((controller) {
      return CurvedAnimation(parent: controller, curve: Curves.easeOutCubic);
    }).toList();

    // Animar cards con delay
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) _controllers[i].forward();
      });
    }

    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      BubbleNotification.show(
        context,
        duration: const Duration(seconds: 15),
        message:
            "Actualmente me estoy divirtiendo \nmigrando Pico y Placa Popayán  \na Kotlin Multi Platform 📲🤩",
      );
    });*/
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade50, Colors.white, Colors.purple.shade50],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // Lista de proyectos
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 30, 16, 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return FadeTransition(
                      opacity: _animations[index],
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.2),
                          end: Offset.zero,
                        ).animate(_animations[index]),
                        child: _projectCard(context, projects[index], index),
                      ),
                    );
                  }, childCount: projects.length),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _projectCard(
    BuildContext context,
    Map<String, dynamic> project,
    int index,
  ) {
    final MaterialColor color = project["color"] as MaterialColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con imagen y overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                child: Image.asset(
                  project["image"],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color.shade400, color.shade600],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        project["icon"] as IconData,
                        size: 80,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
              // Overlay gradient
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  ),
                ),
              ),
              // Badge del año
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: color.shade700,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        project["year"],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: color.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Título sobre la imagen
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        project["icon"] as IconData,
                        color: color.shade600,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        project["title"],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.black45, blurRadius: 8),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Contenido del card
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Descripción
                Text(
                  project["description"],
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),

                // Sección de tecnologías
                Row(
                  children: [
                    Icon(Icons.code, size: 18, color: color.shade600),
                    const SizedBox(width: 8),
                    const Text(
                      "Tecnologías",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Tags de tecnologías
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (project["tags"] as List<String>)
                      .map(
                        (tag) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [color.shade50, color.shade100],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: color.shade200, width: 1),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              color: color.shade700,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 20),

                // Botones de acción
                Row(
                  children: [
                    // Botón Google Play (si existe)
                    if (project["link"] != null) ...[
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            await UrlLauncherHelper.launchStore(
                              androidPackageId: "com.zefiroft.picoplaca",
                              context: context,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: color.shade700,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: BorderSide(color: color.shade300, width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Icons.shop, size: 20),
                          label: const Text(
                            "Ver en Play Store",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
