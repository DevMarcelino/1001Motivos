import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert'; // Para decodificar o JSON
import 'package:flutter/services.dart'; // Para carregar o arquivo JSON
import 'dart:math';
import 'package:milmotivos/tempo_page.dart';
import 'package:milmotivos/RecordacoesPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Número de abas
      child: Scaffold(
        appBar: AppBar(
          title: const Text('1001 Motivos Para te Amar'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Motivos'),
              Tab(text: 'Tempo'),
              Tab(text: 'Recordações'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MotivosPage(),
            TempoPage(),
            RecordacoesPage(),
          ],
        ),
        backgroundColor: Colors.pink[100], // Cor de fundo rosa claro
      ),
    );
  }
}

class MotivosPage extends StatefulWidget {
  const MotivosPage({super.key});

  @override
  _MotivosPageState createState() => _MotivosPageState();
}

class _MotivosPageState extends State<MotivosPage> {
  List<String> motivos = [];
  String motivoAtual = '';
  List<Widget> coracoes = [];

  @override
  void initState() {
    super.initState();
    carregarMotivos();
    _verificarPrimeiraAbertura();
  }

  Future<void> carregarMotivos() async {
    final String resposta = await rootBundle.loadString('assets/motivos.json');
    final Map<String, dynamic> dados = json.decode(resposta);
    setState(() {
      motivos = List<String>.from(dados['motivos']);
    });
  }

  Future<void> _verificarPrimeiraAbertura() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? primeiraAbertura = prefs.getBool('primeiraAbertura');

    if (primeiraAbertura == null || primeiraAbertura) {
      // Exibe o pop-up
      _mostrarPopup();
      // Atualiza o valor para indicar que o app já foi aberto
      await prefs.setBool('primeiraAbertura', false);
    }
  }

  void _mostrarPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Feliz 1 Ano'),
          content: const Text('Meu amor, não há palavras para descrever o que sinto por você. Você é a minha inspiração para tudo que faço, e espero que esse aplicativo seja mais uma prova do meu amor. Me perdoe por ter me atrasado com o presente de um ano, mas prometo que essa é apenas uma pequena parte do que quero te dar. Eu te amo mais que tudo!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o pop-up
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void gerarMotivo() {
    // Gera um novo motivo diretamente
    _mostrarMotivo();
  }

  void _mostrarMotivo() {
    final random = Random();
    setState(() {
      motivoAtual = motivos[random.nextInt(motivos.length)];
      coracoes.add(_buildCoracao());
      _removeCoracao(coracoes.length - 1); // Remove o coração após a animação
    });
  }

  Widget _buildCoracao() {
    return const AnimatedOpacity (
      opacity: 1.0,
      duration: Duration(milliseconds: 500),
      child: Icon(Icons.favorite, color: Colors.red, size: 30),
    );
  }

  void _removeCoracao(int index) {
    setState(() {
      coracoes[index] = Opacity(opacity: 0.0, child: coracoes[index]);
    });

    // Remove o coração após a animação
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        coracoes.removeAt(index);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Espaçamento ao redor do texto
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Usando SingleChildScrollView para permitir rolagem
            SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8), // Limita a largura do texto
                child: Text(
                  motivoAtual,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05, // Tamanho de fonte adaptável
                    height: 1.5, // Aumenta o espaçamento entre linhas
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: gerarMotivo,
              child: const Text('Saiba um Motivo'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: coracoes,
            ),
            const SizedBox(height: 20),
            // Adicionando um ícone de coração no rodapé
            const Icon(Icons.favorite, color: Colors.red, size: 50),
          ],
        ),
      ),
    );
  }
}