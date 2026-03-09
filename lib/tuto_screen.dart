import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TutoScreen extends StatefulWidget {
  const TutoScreen({super.key});

  @override
  State<TutoScreen> createState() => _CvScreenState();
}

class _CvScreenState extends State<TutoScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  final List<Animation<double>> _itemAnimations = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    for (int i = 0; i < 10; i++) {
      final start = i * 0.1;
      final end = start + 0.4;

      _itemAnimations.add(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeOutCubic),
        ),
      );
    }

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _animatedItem(Widget child, int index) {

    if (index >= _itemAnimations.length) {
      index = _itemAnimations.length - 1;
    }

    return FadeTransition(
      opacity: _itemAnimations[index],
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        ).animate(_itemAnimations[index]),
        child: child,
      ),
    );
  }

  Widget _sectionTitle(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.blue.shade700],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget _chip(String label) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF1976D2),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Future<void> _openUrl(String url) async {

    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade50,
              Colors.white,
              Colors.purple.shade50
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

                /// YOUTUBE
                _animatedItem(
                  _sectionTitle("Contenido en YouTube", Icons.ondemand_video),
                  7,
                ),

                _animatedItem(
                  Column(
                    children: [

                      _youtubeCard(
                        title: "Migré mi app Android a Kotlin Multiplatform + Compose Multiplatform (mi experiencia real)",
                        description:
                            "En este video te cuento mi experiencia migrando una app Android a Kotlin Multiplatform (KMP) y Compose Multiplatform, con un enfoque totalmente práctico y real.",
                        videoId: "xxRJJws9D_Q",
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                  8,
                ),

                const SizedBox(height: 40),

                Text(
                  "© 2026 Willian Bustos",
                  style: TextStyle(color: Colors.grey.shade500),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {

    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade700,
            Colors.blue.shade500,
            Colors.purple.shade400
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [

          const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage("assets/image/willian.jpeg"),
          ),

          const SizedBox(height: 20),

          const Text(
            "Willian Andrés Bustos",
            style: TextStyle(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Ingeniero Informático | Android Senior",
            style: TextStyle(color: Colors.white),
          ),

          const SizedBox(height: 16),

          _contactItem(Icons.email, "wilianandres1@gmail.com"),
          _contactItem(Icons.code, "github.com/willianB"),
        ],
      ),
    );
  }

  Widget _aboutCard() {

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        "Ingeniero informático con más de 8 años de experiencia en desarrollo "
        "de aplicaciones Android y arquitectura de software.",
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _contactItem(IconData icon, String text) {

    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _experienceCard({
    required String company,
    required String period,
    required String position,
    required String description,
    required MaterialColor color,
  }) {

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            company,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color.shade800,
            ),
          ),

          Text(period),

          const SizedBox(height: 10),

          Text(
            position,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Text(description),
        ],
      ),
    );
  }

  Widget _educationTile(
      String title,
      String institution,
      String year,
      IconData icon) {

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [

          Icon(icon, color: Colors.blue),

          const SizedBox(width: 16),

          Expanded(
            child: Text(
              "$title - $institution ($year)",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget _youtubeCard({
    required String title,
    required String description,
    required String videoId,
  }) {

    final thumbnail =
        "https://img.youtube.com/vi/$videoId/0.jpg";

    final url =
        "https://youtube.com/watch?v=$videoId";

    return GestureDetector(
      onTap: () => _openUrl(url),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              alignment: Alignment.center,
              children: [

                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Image.network(
                    thumbnail,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}