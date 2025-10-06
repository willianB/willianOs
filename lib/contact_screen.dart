import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _launchUrl(String url) async {
  final Uri uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication, // 🔹 abre en navegador o app externa
    );
  } else {
    throw Exception('No se pudo abrir $url');
  }
}

  Widget _buildContactCard({
    required IconData icon,
    required Color color,
    required String text,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.1),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Foto circular con animación
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage("../assets/image/willian.jpeg"),
                    ),
                    const SizedBox(height: 24),

                    // Contact Cards
                    _buildContactCard(
                      icon: Icons.email,
                      color: Colors.redAccent,
                      text: "wilianandres1@gmail.com",
                      onTap: () =>
                          _launchUrl("mailto:wilianandres1@gmail.com"),
                    ),
                    _buildContactCard(
                      icon: Icons.code,
                      color: Colors.black,
                      text: "github.com/willianB",
                      onTap: () => _launchUrl("https://github.com/willianB"),
                    ),
                    _buildContactCard(
                      icon: Icons.business_center,
                      color: Colors.blue,
                      text: "LinkedIn",
                      onTap: () => _launchUrl(
                          "https://co.linkedin.com/in/willian-andres-bustos-toro"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
