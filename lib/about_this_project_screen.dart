import 'package:flutter/material.dart';
import 'package:mobile/UrlLauncherHelper.dart';

class AboutThisProjectScreen extends StatefulWidget {
  const AboutThisProjectScreen({super.key});

  @override
  State<AboutThisProjectScreen> createState() => _AboutThisProjectScreenState();
}

class _AboutThisProjectScreenState extends State<AboutThisProjectScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<AnimationController> _sectionControllers;
  late Animation<double> _headerAnimation;
  late List<Animation<double>> _sectionAnimations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _headerAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    // Animaciones para cada sección
    _sectionControllers = List.generate(
      5,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      ),
    );

    _sectionAnimations = _sectionControllers
        .map((controller) => CurvedAnimation(
              parent: controller,
              curve: Curves.easeOutBack,
            ))
        .toList();

    // Iniciar animaciones
    _controller.forward().then((_) {
      for (int i = 0; i < _sectionControllers.length; i++) {
        Future.delayed(Duration(milliseconds: i * 150), () {
          if (mounted) _sectionControllers[i].forward();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var controller in _sectionControllers) {
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
            colors: [
              Colors.blue.shade50,
              Colors.white,
              Colors.purple.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header con hero image
                FadeTransition(
                  opacity: _headerAnimation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -0.2),
                      end: Offset.zero,
                    ).animate(_headerAnimation),
                    child: _buildHeroSection(),
                  ),
                ),

                const SizedBox(height: 32),

                // Descripción
                _buildAnimatedSection(
                  index: 0,
                  child: _buildDescriptionSection(),
                ),

                const SizedBox(height: 24),

                // Tecnologías
                _buildAnimatedSection(
                  index: 1,
                  child: _buildTechnologiesSection(),
                ),

                const SizedBox(height: 24),

                // Objetivo
                /*_buildAnimatedSection(
                  index: 2,
                  child: _buildObjectiveSection(),
                ),*/

                const SizedBox(height: 24),

                // Características
                _buildAnimatedSection(
                  index: 3,
                  child: _buildFeaturesSection(),
                ),

                const SizedBox(height: 24),

                // Estadísticas
                _buildAnimatedSection(
                  index: 4,
                  child: _buildStatsSection(),
                ),

                const SizedBox(height: 32),

                // Botones de acción
                //_buildActionButtons(),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedSection({required int index, required Widget child}) {
    return FadeTransition(
      opacity: _sectionAnimations[index],
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.15),
          end: Offset.zero,
        ).animate(_sectionAnimations[index]),
        child: child,
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade700,
            Colors.blue.shade500,
            Colors.purple.shade400,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Imagen placeholder o icono
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
              color: Colors.white.withOpacity(0.1),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.phone_android_rounded,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Portafolio Interactivo",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Título y subtítulo
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Text(
                  "Mi Portafolio Flutter",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "Diseñado con pasión y las mejores prácticas de desarrollo",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return _buildCard(
      icon: Icons.description_rounded,
      iconColor: Colors.blue,
      title: "Descripción del Proyecto",
      child: const Text(
        "Este proyecto es un simulador interactivo desarrollado completamente en Flutter que representa mi portafolio profesional. "
        "La aplicación tiene como objetivo mostrar mis habilidades como desarrollador Flutter, mi experiencia en arquitectura limpia y el uso de buenas prácticas en el desarrollo multiplataforma.",
        style: TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildTechnologiesSection() {
    final technologies = [
      {"icon": Icons.flutter_dash, "label": "Flutter", "color": Colors.blue},
      {"icon": Icons.code, "label": "Dart", "color": Colors.teal},
      {"icon": Icons.layers, "label": "Clean Architecture", "color": Colors.indigo},
      {"icon": Icons.architecture, "label": "MVVM", "color": Colors.purple},
      {"icon": Icons.settings_suggest, "label": "State Management", "color": Colors.orange},
      {"icon": Icons.animation, "label": "Animations", "color": Colors.pink},
      {"icon": Icons.widgets, "label": "Material Design 3", "color": Colors.green},
      {"icon": Icons.web, "label": "Flutter Web", "color": Colors.cyan},
    ];

    return _buildCard(
      icon: Icons.code_rounded,
      iconColor: Colors.purple,
      title: "Tecnologías Utilizadas",
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: technologies.map((tech) {
          return _TechChip(
            icon: tech["icon"] as IconData,
            label: tech["label"] as String,
            color: tech["color"] as Color,
          );
        }).toList(),
      ),
    );
  }

  /*Widget _buildObjectiveSection() {
    return _buildCard(
      icon: Icons.flag_rounded,
      iconColor: Colors.orange,
      title: "Objetivo del Proyecto",
      child: const Text(
        "El objetivo principal de este portafolio es demostrar mi capacidad para construir interfaces modernas, animadas y modulares en Flutter. "
        "Cada sección fue pensada como si fuera una 'feature' dentro de una aplicación real, aplicando principios de composición, "
        "responsividad y buenas prácticas de desarrollo.",
        style: TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
        textAlign: TextAlign.justify,
      ),
    );
  }*/

  Widget _buildFeaturesSection() {
    final features = [
      "Diseño 100% desarrollado en Flutter",
      "Arquitectura modular basada en Clean Architecture",
      "Transiciones fluidas y animaciones personalizadas",
      "Adaptable a dispositivos móviles y web",
      "Secciones interactivas de experiencia, proyectos y logros",
      "Gestión del estado desacoplada de la UI",
    ];

    return _buildCard(
      icon: Icons.stars_rounded,
      iconColor: Colors.amber,
      title: "Características Principales",
      child: Column(
        children: features
            .map((feature) => _FeatureItem(feature))
            .toList(),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.palette_rounded,
            label: "Diseño",
            value: "100%",
            color: Colors.pink,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.speed_rounded,
            label: "Performance",
            value: "60 FPS",
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.devices_rounded,
            label: "Plataformas",
            value: "Multi",
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade600],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        // Botón principal
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () async {
              await UrlLauncherHelper.launchURL(
                'https://github.com/willianB', // Reemplaza con tu repo
                context: context,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            icon: const Icon(Icons.code_rounded, size: 24),
            label: const Text(
              "Ver Código Fuente en GitHub",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Botón secundario
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () async {
              await UrlLauncherHelper.launchURL(
                'https://tu-demo.web.app', // Reemplaza con tu demo
                context: context,
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blue.shade700,
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: Colors.blue.shade300, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            icon: const Icon(Icons.play_circle_rounded, size: 24),
            label: const Text(
              "Ver Demo en Vivo",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TechChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _TechChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.1), color.withOpacity(0.2)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: Colors.blue.shade700,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String text;

  const _FeatureItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              color: Colors.green.shade700,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}