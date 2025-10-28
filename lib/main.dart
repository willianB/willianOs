import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile/about_this_project_screen.dart';
import 'package:mobile/contact_screen.dart';
import 'package:mobile/cv_screen.dart';
import 'package:mobile/gallery_screen.dart';
import 'package:mobile/projects_screen.dart';
import 'package:mobile/recognitions_screen.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PhonePortfolioApp());
}

class PhonePortfolioApp extends StatelessWidget {
  const PhonePortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PhonePortfolio(),
    );
  }
}

class PhonePortfolio extends StatefulWidget {
  const PhonePortfolio({super.key});

  @override
  State<PhonePortfolio> createState() => _PhonePortfolioState();
}

class _PhonePortfolioState extends State<PhonePortfolio> {
  String screen = "home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Fondo degradado
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0D47A1),
                  Color(0xFF1976D2),
                  Color(0xFF42A5F5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // 🔹 Marcas de agua: círculos grandes y suaves
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            right: -40,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),

          // 🔹 Contenido principal
          _phoneFrame(),
        ],
      ),
    );
  }

  Widget _phoneFrame() {
    return Center(
      child: Container(
        width: 400,
        height: 690,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Notch
            Container(
              width: 100,
              height: 20,
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
            ),

            // Pantalla con animación
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                  image: screen == "home"
                      ? const DecorationImage(
                          image: AssetImage("assets/image/iphone.jpg"),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(scale: animation, child: child),
                      );
                    },
                    child: _buildScreen(),
                  ),
                ),
              ),
            ),

            // Barra inferior
            Container(
              width: 80,
              height: 6,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreen() {
    if (screen == "home") {
      return Container(key: const ValueKey("home"), child: _homeScreen());
    }

    return Container(
      key: ValueKey(screen),
      child: Column(
        children: [
          buildTopBar(),
          Expanded(child: _getScreenContent()),
        ],
      ),
    );
  }

  Widget buildTopBar() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white24,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => setState(() => screen = "home"),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) => SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.2, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                ),
                child: Text(
                  _getTitle(screen),
                  key: ValueKey<String>(_getTitle(screen)),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(width: 52),
        ],
      ),
    );
  }

  Widget _homeScreen() {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  _appButton(
                    icon: Icons.person,
                    label: "CV",
                    color: Colors.blue,
                    target: "cv",
                  ),
                  _appButton(
                    icon: Icons.work,
                    label: "Proyectos",
                    color: Colors.green,
                    target: "projects",
                  ),
                  _appButton(
                    icon: Icons.email,
                    label: "Contacto",
                    color: Colors.orange,
                    target: "contact",
                  ),
                  _appButton(
                    iconWidget: SvgPicture.asset(
                      'assets/image/flutter.svg',
                      height: 50,
                      width: 50,
                    ),
                    label: "Este proyecto",
                    color: Colors.purple,
                    target: "about",
                  ),
                  _appButton(
                    icon: Icons.star,
                    label: "Reconocimientos",
                    color: Colors.red,
                    target: "recognitions",
                  ),
                  _appButton(
                    iconWidget: SvgPicture.asset(
                      'assets/image/github.svg',
                      height: 80,
                      width: 80,
                    ),
                    label: "GitHub",
                    color: Colors.white54,
                    target: "github",
                    url: "https://github.com/willianB",
                  ),
                  _appButton(
                    iconWidget: SvgPicture.asset(
                      'assets/image/linkedin.svg',
                      height: 50,
                      width: 50,
                    ),
                    label: "LinkedIn",
                    url:
                        "https://co.linkedin.com/in/willian-andres-bustos-toro",
                    color: Colors.white60,
                    target: "linkedin",
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "WillianOs v1.0",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appButton({
    String url = "",
    IconData? icon,
    Widget? iconWidget,
    required String label,
    required Color color,
    required String target,
  }) {
    return GestureDetector(
      onTap: () {
        if (url != "") {
          _launchUrl(url);
        } else {
          setState(() => screen = target);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.6),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: Center(
                child: iconWidget ?? Icon(icon, color: Colors.white, size: 36),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  String _getTitle(String screen) {
    switch (screen) {
      case "cv":
        return "Currículum";
      case "projects":
        return "🚀 Proyectos Personales";
      case "contact":
        return "Contacto";
      case "recognitions":
        return "🎖️ Logros y Premios";
      case "about":
        return "Este proyecto";
      default:
        return "App";
    }
  }

  Widget _getScreenContent() {
    switch (screen) {
      case "cv":
        return const CvScreen();
      case "projects":
        return ProjectsScreen(
          onNavigate: (target) => setState(() => screen = target),
        );
      case "recognitions":
        return const RecognitionsScreen();
      case "contact":
        return const ContactScreen();
      case "picoplaca":
        return const GalleryScreen(projectId: "picoplaca");
      case "ecohogar":
        return const GalleryScreen(projectId: "ecohogar");
      case "about":
        return const AboutThisProjectScreen();
      default:
        return const Center(child: Text("Pantalla en construcción..."));
    }
  }
}

void _launchUrl(String url) async {
  final Uri uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
      mode:
          LaunchMode.externalApplication, // 🔹 abre en navegador o app externa
    );
  } else {
    throw Exception('No se pudo abrir $url');
  }
}
