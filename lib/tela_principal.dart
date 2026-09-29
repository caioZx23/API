import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:projeto_api/app_colors.dart';
import 'package:projeto_api/camera.dart';
import 'package:projeto_api/tela_consultas.dart';
import 'package:projeto_api/tela_trabalho.dart';
import 'package:projeto_api/tela_gps.dart';

class TelaPrincipal extends StatelessWidget {
  const TelaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [verdeEscuro, verde]),
              ),

              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,

                child: Icon(Icons.person, color: verdeEscuro, size: 40),
              ),

              accountName: const Text('Usuário'),
              accountEmail: const Text('usuario@email.com'),
            ),

            ListTile(
              leading: const Icon(Icons.home, color: verdeEscuro),

              title: const Text('Principal'),

              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.search, color: verde),

              title: const Text('Consultas'),

              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TelaConsultas(),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.work, color: marrom),

              title: const Text('Trabalho'),

              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaTrabalho()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: roxo),

              title: const Text('Minha Localização'),

              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaGPS()),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.location_on, color: roxo),

              title: const Text('Câmera'),

              onTap: () {
                Navigator.pop(context);

                _abrirTelaCamera(context);
              },
            ),

            const Spacer(),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout, color: marrom),

              title: const Text('Sair'),

              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),

      appBar: AppBar(
        backgroundColor: verdeEscuro,
        foregroundColor: Colors.white,
        title: const Text('Principal'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(25),

              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [verdeEscuro, verde]),

                borderRadius: BorderRadius.circular(22),
              ),

              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Icon(Icons.waving_hand, color: Colors.white, size: 40),

                  SizedBox(height: 15),

                  Text(
                    'Sejam Bem Vindos!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Utilize o menu para acessar '
                    'as funcionalidades do sistema.',
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Acessos rápidos',

              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: verdeEscuro,
              ),
            ),

            const SizedBox(height: 15),

            _BotaoMenu(
              titulo: 'Consultas',
              descricao: 'Consultar CEP e CNPJ',
              icone: Icons.search,
              cor: verde,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TelaConsultas(),
                  ),
                );
              },
            ),

            _BotaoMenu(
              titulo: 'Trabalho',
              descricao: 'Acessar tarefas e atividades',
              icone: Icons.work,
              cor: marrom,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaTrabalho()),
                );
              },
            ),

            _BotaoMenu(
              titulo: 'Minha Localização',
              descricao: 'Consultar latitude e longitude',
              icone: Icons.location_on,
              cor: roxo,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaGPS()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _abrirTelaCamera(BuildContext context) async {
  try {
    final cameras = await availableCameras();
    if (!context.mounted) return;

    if (cameras.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nenhuma câmera foi encontrada.')),
      );
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraApp(camera: cameras.first)),
    );
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível acessar a câmera.')),
      );
    }
  }
}

class _BotaoMenu extends StatelessWidget {
  final String titulo;
  final String descricao;
  final IconData icone;
  final Color cor;
  final VoidCallback onTap;

  const _BotaoMenu({
    required this.titulo,
    required this.descricao,
    required this.icone,
    required this.cor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),

      child: ListTile(
        contentPadding: const EdgeInsets.all(15),

        leading: CircleAvatar(
          backgroundColor: cor,

          child: Icon(icone, color: Colors.white),
        ),

        title: Text(
          titulo,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),

        subtitle: Text(descricao),

        trailing: const Icon(Icons.arrow_forward_ios, size: 18),

        onTap: onTap,
      ),
    );
  }
}
