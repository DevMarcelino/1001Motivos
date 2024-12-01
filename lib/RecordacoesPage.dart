import 'package:flutter/material.dart';

class RecordacoesPage extends StatelessWidget {
  const RecordacoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeria de Recordações'),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Número de colunas
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: 50, // Número total de imagens
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Ação ao tocar na imagem
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageDetailPage(index: index),
                ),
              );
            },
            child: Image.asset(
              'assets/images/image_$index.png', // Caminho da imagem
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}

class ImageDetailPage extends StatelessWidget {
  final int index;

  const ImageDetailPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Imagem'),
      ),
      body: Center(
        child: Image.asset('assets/images/image_$index.png'), // Caminho da imagem
      ),
    );
  }
}