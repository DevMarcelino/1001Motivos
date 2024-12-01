import 'package:flutter/material.dart';
import 'dart:async';

class TempoPage extends StatefulWidget {
  const TempoPage({super.key});

  @override
  _TempoPageState createState() => _TempoPageState();
}

class _TempoPageState extends State<TempoPage> {
  DateTime dataInicio = DateTime(2023, 11, 17);
  Duration duracao = const Duration();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    iniciarRelogio();
  }

  void iniciarRelogio() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        duracao = DateTime.now().difference(dataInicio);
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      color: Colors.pink[100], // Cor de fundo rosa claro
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Alinhando no topo
          children: [
            const SizedBox(height: 20), // Espaçamento superior
            // Substituindo o ícone pela imagem
            Image.asset(
              'assets/ampulheta.png', // Caminho da imagem
              width: 300, // Largura da imagem
              height: 300, // Altura da imagem
            ),
            const SizedBox(height: 20), // Espaçamento entre a imagem e o texto
            Text(
              'Tempo desde o início do nosso Amor:   ${duracao.inDays} dias, ${duracao.inHours.remainder(24)} horas, ${duracao.inMinutes.remainder(60)} minutos, ${duracao.inSeconds.remainder(60)} segundos',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30,
                fontFamily: 'GreatVibes', // Usando a fonte "Great Vibes"
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}