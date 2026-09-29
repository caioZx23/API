import 'package:flutter/material.dart';
import 'package:projeto_api/app_colors.dart';
import 'package:projeto_api/tela_login.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu Sistema',

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: verdeEscuro,
          primary: verdeEscuro,
          secondary: roxo,
          tertiary: marrom,
          error: roxo,
        ),
      ),

      home: const TelaInicial(),
    );
  }
}

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [verdeEscuro, verde],
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                  width: 120,
                  height: 120,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),

                  child: const Icon(
                    Icons.apps_rounded,
                    size: 65,
                    color: verdeEscuro,
                  ),
                ),

                const SizedBox(height: 35),

                const Text(
                  'Bem-vindo!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Acesse o sistema para continuar',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 17),
                ),

                const SizedBox(height: 45),

                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TelaLogin(),
                        ),
                      ); // Aqui você poderá abrir a tela de Login
                    },

                    icon: const Icon(Icons.login),

                    label: const Text(
                      'Acessar sistema',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: verdeEscuro,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
