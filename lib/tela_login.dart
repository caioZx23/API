import 'package:flutter/material.dart';
import 'package:projeto_api/app_colors.dart';
import 'package:projeto_api/tela_principal.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController usuarioController = TextEditingController();

  final TextEditingController senhaController = TextEditingController();

  bool mostrarSenha = false;

  @override
  void dispose() {
    usuarioController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: verdeEscuro,
        foregroundColor: Colors.white,
        title: const Text('Login'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),

        child: Column(
          children: [
            const SizedBox(height: 35),

            Container(
              width: 95,
              height: 95,

              decoration: BoxDecoration(
                color: verdeEscuro,
                borderRadius: BorderRadius.circular(25),
              ),

              child: const Icon(Icons.person, color: Colors.white, size: 55),
            ),

            const SizedBox(height: 25),

            const Text(
              'Entrar no sistema',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: verdeEscuro,
              ),
            ),

            const SizedBox(height: 35),

            TextField(
              controller: usuarioController,

              decoration: InputDecoration(
                labelText: 'Usuário',
                prefixIcon: const Icon(Icons.person_outline),

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              controller: senhaController,

              obscureText: !mostrarSenha,

              decoration: InputDecoration(
                labelText: 'Senha',

                prefixIcon: const Icon(Icons.lock_outline),

                suffixIcon: IconButton(
                  icon: Icon(
                    mostrarSenha ? Icons.visibility : Icons.visibility_off,
                  ),

                  onPressed: () {
                    setState(() {
                      mostrarSenha = !mostrarSenha;
                    });
                  },
                ),

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TelaPrincipal(),
                    ),
                  );
                },

                icon: const Icon(Icons.login),

                label: const Text(
                  'Entrar',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: verdeEscuro,
                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextButton(
              onPressed: () {},

              child: const Text(
                'Esqueci minha senha',
                style: TextStyle(color: roxo),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
