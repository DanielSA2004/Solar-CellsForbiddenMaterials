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

//hola mudo xd

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 15),
                Spacer(flex: 30),
                Text(
                  'Materials: Forbbiden Transitions',
                  style: GoogleFonts.orbitron(
                    textStyle: TextStyle(
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = Color.fromARGB(255, 10, 1, 1),
                      fontSize: MediaQuery.of(context).size.width * 0.05, // 8% del ancho
                    ),
                  ),
                  textAlign: TextAlign.center, // Centrado si se parte en varias líneas
                ),
                SizedBox(height: 15),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MymainApp(
                                    title: '',
                                  )));
                    },
                    // ignore: sort_child_properties_last
                    child: Text(
                      'Start',
                      style: GoogleFonts.orbitron(
                          textStyle: TextStyle(fontSize: 15)),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 100, vertical: 30))),
                SizedBox(height: 15),
                Spacer(flex: 30),
              ],
            ),
          )
        ]),
        backgroundColor: Color.fromARGB(255, 252, 227, 146));
  }
}
