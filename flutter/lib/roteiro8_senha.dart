import 'package:flutter/material.dart';

void main() => runApp(const PasswordApp());

enum Strength {
  empty('Digite uma senha', 0),
  weak('Senha Fraca', 0.33),
  medium('Senha Média', 0.66),
  strong('Senha Forte', 1);

  const Strength(this.label, this.progress);
  final String label;
  final double progress;
}

Strength classify(String password) {
  final length = password.runes.length;
  if (length == 0) return Strength.empty;
  if (length < 6) return Strength.weak;
  if (length < 10) return Strength.medium;
  return Strength.strong;
}

class PasswordApp extends StatelessWidget {
  const PasswordApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Verificador de senha',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF155E59),
        useMaterial3: true,
      ),
      home: const PasswordScreen(),
    );
  }
}

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  Strength strength = Strength.empty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verificador de senha')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Classificação didática pelo comprimento'),
                  const SizedBox(height: 16),
                  TextField(
                    obscureText: true,
                    onChanged: (value) {
                      setState(() => strength = classify(value));
                    },
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 18),
                  LinearProgressIndicator(value: strength.progress),
                  const SizedBox(height: 10),
                  Semantics(
                    liveRegion: true,
                    child: Text(strength.label, textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
