import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {

  final String projectId;

  const GalleryScreen({super.key,
  required this.projectId});


  final List<String> images = const [
    "../assets/gallery/ecohogar_home.png",
    "../assets/gallery/ecohogar_home.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 columnas
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          final img = images[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FullImageScreen(image: img),
                ),
              );
            },
            child: Hero(
              tag: img,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(img, fit: BoxFit.cover),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FullImageScreen extends StatelessWidget {
  final String image;

  const FullImageScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Imagen completa
          Center(
            child: Hero(
              tag: image,
              child: InteractiveViewer(
                child: Image.asset(image),
              ),
            ),
          ),

          // Botón de cerrar arriba a la derecha
          Positioned(
            top: 40, // separa del borde superior
            right: 20, // separa del borde derecho
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 32),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}

