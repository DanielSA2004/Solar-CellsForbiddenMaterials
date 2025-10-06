import 'package:flutter/material.dart';
import 'Widgets/pythonconsole.dart';

class MymainApp extends StatefulWidget {
  const MymainApp({super.key, required this.title});

  final String title;

  @override
  State<MymainApp> createState() => _MymainAppState();
}

class _MymainAppState extends State<MymainApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    PythonConsole(),
    Center(child: Text('Módulo 2')),
    Center(child: Text('Módulo 3')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _goHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo con patrón de cuadrados
          CustomPaint(
            size: Size.infinite,
            painter: SquarePatternPainter(),
          ),

          // Contenido principal
          SafeArea(
            child: _pages[_selectedIndex],
          ),
        ],
      ),

      // Barra inferior de navegación
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: const Color.fromARGB(255, 255, 221, 149),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.terminal),
              tooltip: 'Consola',
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: const Icon(Icons.widgets),
              tooltip: 'Módulo 2',
              onPressed: () => _onItemTapped(1),
            ),
            const SizedBox(width: 40), // espacio central
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Ajustes',
              onPressed: () => _onItemTapped(2),
            ),
          ],
        ),
      ),

      // Botón flotante (Home)
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 255, 223, 135),
        onPressed: () => _goHome(context),
        tooltip: 'Volver al inicio',
        child: const Icon(Icons.home, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class SquarePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double squareSize = 30.0; // tamaño de cada cuadrado
    final Paint paint = Paint()
      ..color = const Color.fromARGB(255, 252, 225, 135); // negro translúcido

    for (double y = 0; y < size.height; y += squareSize) {
      for (double x = 0; x < size.width; x += squareSize) {
        if (((x + y) / squareSize) % 2 == 0) {
          // alterna el patrón (tipo tablero)
          canvas.drawRect(
            Rect.fromLTWH(x, y, squareSize, squareSize),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
