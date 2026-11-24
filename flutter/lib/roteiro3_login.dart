import 'package:flutter/material.dart';

void main() => runApp(const LoginApp());

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login do laboratório',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF155E59),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  String message = '';

  void login() {
    final address = email.text.trim();
    final validEmail = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(address);
    final valid = validEmail && password.text.trim().isNotEmpty;
    setState(() {
      message = valid
          ? 'Boas-vindas, $address!'
          : 'Informe um e-mail válido e a senha.';
    });
    if (valid) password.clear();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Laboratório Mobile')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Acesso ao laboratório',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: password,
                    obscureText: true,
                    onSubmitted: (_) => login(),
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(onPressed: login, child: const Text('Login')),
                  const SizedBox(height: 8),
                  Semantics(
                    liveRegion: true,
                    child: Text(message, textAlign: TextAlign.center),
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
