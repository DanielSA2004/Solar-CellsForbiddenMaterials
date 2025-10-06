import 'dart:io';
import 'package:flutter/material.dart';

class PythonConsole extends StatefulWidget {
  const PythonConsole({super.key});

  @override
  State<PythonConsole> createState() => _PythonConsoleState();
}

class _PythonConsoleState extends State<PythonConsole> {
  final List<String> _output = [">>> Python console ready"];
  bool _isRunning = false;

  Future<void> _runPythonScript() async {
    if (_isRunning) return;
    setState(() {
      _isRunning = true;
      _output.add(">>> Ejecutando main.py...");
    });

    try {
      // Ruta al intérprete Python y script
      final pythonPath = 'lib/Backend/.venv/bin/python';
      final result = await Process.run(
        pythonPath,
        ['lib/Backend/main.py'],
      );

      setState(() {
        _output.add("Salida estándar:");
        _output.add(result.stdout.toString().trim());
        if (result.stderr.toString().isNotEmpty) {
          _output.add("Error:");
          _output.add(result.stderr.toString().trim());
        } else {
          _output.add(">>> Ejecución completada");
        }
      });
    } catch (e) {
      setState(() {
        _output.add("Error al ejecutar Python: $e");
      });
    } finally {
      if (mounted) {
        setState(() {
          _isRunning = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade700, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Python Console",
              style: TextStyle(
                color: Color.fromARGB(255, 255, 239, 150),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(color: Color.fromARGB(255, 253, 243, 154)),
            Expanded(
              child: ListView.builder(
                itemCount: _output.length,
                itemBuilder: (context, index) => Text(
                  _output[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: ElevatedButton(
                onPressed: _isRunning ? null : _runPythonScript,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 236, 150),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                child: Text(
                  _isRunning ? "Ejecutando..." : "Run Python",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
