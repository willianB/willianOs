import 'package:flutter/material.dart';

class CvScreen extends StatefulWidget {
  const CvScreen({super.key});

  @override
  State<CvScreen> createState() => _CvScreenState();
}

class _CvScreenState extends State<CvScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
            .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();
  }

  Widget _sectionTitle(IconData icon, String title) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Icon(icon, color: Colors.blue),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _animatedSection(Widget child, {int delay = 0}) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F2FD), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _animatedSection(
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Willian Andrés Bustos",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Ingeniero Informático | Desarrollador Android | Especialista en Aplicaciones Móviles",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text("✉️ wilianandres1@gmail.com"),
                          Text("🌐 github.com/willianB"),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                _animatedSection(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 8),
                    Text(
                      "Ingeniero informático con más de 8 años de experiencia en desarrollo "
                      "de software, enfocado en el desarrollo de aplicaciones móviles (Android e iOS). "
                      "Apasionado por la resolución de problemas y la creación de soluciones innovadoras...",
                      textAlign: TextAlign.justify,
                    ),
                  ],
                )),

                const SizedBox(height: 20),
                _sectionTitle(Icons.build, "Habilidades Técnicas"),
                _animatedSection(const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "- Java, Kotlin, Swift\n"
                    "- Android Jetpack, Compose, Coroutines\n"
                    "- MVVM, Clean Architecture, Modularización\n"
                    "- CI/CD, GitHub Actions\n"
                    "- Seguridad: ProGuard, R8, DexGuard, AES, RSA, SHA",
                  ),
                )),

                const SizedBox(height: 20),
                _sectionTitle(Icons.work, "Experiencia Profesional"),
                _animatedSection(Column(
                  children: const [
                    Card(
                      child: ListTile(
                        title: Text("Globant (2021 - Actualidad)"),
                        subtitle: Text("Android Developer Senior"),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text("Pragma (2020 - 2021)"),
                        subtitle: Text("Desarrollador de Software"),
                      ),
                    ),
                  ],
                )),

                const SizedBox(height: 20),
                _sectionTitle(Icons.school, "Estudios"),
                _animatedSection(const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "- Ingeniero Informático (2019) - Unimayor\n"
                    "- Esp. Tecnológica en Apps Móviles (2015) - SENA\n"
                    "- Tecnólogo en ADSI (2014) - SENA\n"
                    "- Técnico en Sistemas (2011)\n"
                    "- Bachiller Técnico Industrial (2010) - Don Bosco",
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
