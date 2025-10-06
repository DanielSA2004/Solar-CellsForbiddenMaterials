// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: unused_import
import 'Frontend/appmain.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 221, 149)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 227, 146),
      body: Stack(
        children: [
          // Logo arriba a la izquierda
          Positioned(
            top: 40,
            left: 10,
            child: Image.asset(
              'assets/logo.png',
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.1,
              fit: BoxFit.contain,
            ),
          ),

          // Contenido central
          Center(
            child: Column(
              children: [
                const SizedBox(height: 15),
                const Spacer(flex: 30),
                Text(
                  'Materials: Forbbiden Transitions',
                  style: GoogleFonts.orbitron(
                    textStyle: TextStyle(
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = const Color.fromARGB(255, 10, 1, 1),
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MymainApp(title: ''),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 30),
                    backgroundColor:
                        const Color.fromARGB(255, 255, 221, 149),
                  ),
                  child: Text(
                    'Start',
                    style: GoogleFonts.orbitron(
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Spacer(flex: 30),
              ],
            ),
          ),

          // Firma en la esquina inferior derecha
          Positioned(
            right: 10,
            bottom: 10,
            child: Text(
              'Made by: Daniel Silva',
              style: GoogleFonts.orbitron(
                textStyle: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
