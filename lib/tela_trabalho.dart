import 'package:flutter/material.dart';
import 'package:projeto_api/app_colors.dart';

class TelaTrabalho extends StatefulWidget {
  const TelaTrabalho({super.key});

  @override
  State<TelaTrabalho> createState() => _TelaTrabalhoState();
}

class _TelaTrabalhoState extends State<TelaTrabalho> {
  int indice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: marrom,
        foregroundColor: Colors.white,
        title: const Text('Trabalho'),
      ),

      body: IndexedStack(
        index: indice,

        children: const [
          _Tarefas(),
          _Atividades(),
          _Informacoes(),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: indice,

        onDestinationSelected: (index) {
          setState(() {
            indice = index;
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.task_outlined),
            selectedIcon: Icon(Icons.task),
            label: 'Tarefas',
          ),

          NavigationDestination(
            icon: Icon(
              Icons.calendar_month_outlined,
            ),
            selectedIcon: Icon(
              Icons.calendar_month,
            ),
            label: 'Atividades',
          ),

          NavigationDestination(
            icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info),
            label: 'Informações',
          ),
        ],
      ),
    );
  }
}

class _Tarefas extends StatelessWidget {
  const _Tarefas();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),

      children: [
        const Text(
          'Minhas Tarefas',

          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: marrom,
          ),
        ),

        const SizedBox(height: 20),

        _TarefaCard(
          titulo: 'Desenvolver aplicativo',
          descricao: 'Finalizar a tela principal',
          concluida: false,
        ),

        _TarefaCard(
          titulo: 'Testar navegação',
          descricao: 'Verificar todas as telas',
          concluida: true,
        ),

        _TarefaCard(
          titulo: 'Finalizar projeto',
          descricao: 'Preparar apresentação',
          concluida: false,
        ),
      ],
    );
  }
}

class _Atividades extends StatelessWidget {
  const _Atividades();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),

      children: [
        const Text(
          'Atividades',

          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: marrom,
          ),
        ),

        const SizedBox(height: 20),

        Card(
          child: ListTile(
            leading: const Icon(
              Icons.today,
              color: verdeEscuro,
            ),

            title: const Text(
              'Atividade de hoje',
            ),

            subtitle: const Text(
              'Desenvolvimento do sistema',
            ),
          ),
        ),

        Card(
          child: ListTile(
            leading: const Icon(
              Icons.event,
              color: marrom,
            ),

            title: const Text(
              'Próxima atividade',
            ),

            subtitle: const Text(
              'Revisão do projeto',
            ),
          ),
        ),
      ],
    );
  }
}

class _Informacoes extends StatelessWidget {
  const _Informacoes();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(25),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            Icon(
              Icons.info,
              color: verdeEscuro,
              size: 70,
            ),

            SizedBox(height: 20),

            Text(
              'Informações do sistema',

              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: verdeEscuro,
              ),
            ),

            SizedBox(height: 12),

            Text(
              'Este espaço apresenta informações '
              'importantes sobre o sistema.',

              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TarefaCard extends StatelessWidget {
  final String titulo;
  final String descricao;
  final bool concluida;

  const _TarefaCard({
    required this.titulo,
    required this.descricao,
    required this.concluida,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: ListTile(
        contentPadding: const EdgeInsets.all(12),

        leading: CircleAvatar(
          backgroundColor:
              concluida ? verde : marrom,

          child: Icon(
            concluida
                ? Icons.check
                : Icons.work,
            color: Colors.white,
          ),
        ),

        title: Text(
          titulo,

          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(descricao),

        trailing: Icon(
          concluida
              ? Icons.check_circle
              : Icons.pending,

          color: concluida
              ? verde
              : marrom,
        ),
      ),
    );
  }
}