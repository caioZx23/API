import 'package:flutter/material.dart';
import 'package:projeto_api/app_colors.dart';

class TelaConsultas extends StatefulWidget {
  const TelaConsultas({super.key});

  @override
  State<TelaConsultas> createState() =>
      _TelaConsultasState();
}

class _TelaConsultasState
    extends State<TelaConsultas> {
  final TextEditingController cepController =
      TextEditingController();

  final TextEditingController cnpjController =
      TextEditingController();

  String resultadoCep = '';
  String resultadoCnpj = '';

  void consultarCep() {
    if (cepController.text.isEmpty) {
      setState(() {
        resultadoCep =
            'Digite um CEP para consultar.';
      });

      return;
    }

    setState(() {
      resultadoCep =
          'Consulta realizada para o CEP: '
          '${cepController.text}';
    });
  }

  void consultarCnpj() {
    if (cnpjController.text.isEmpty) {
      setState(() {
        resultadoCnpj =
            'Digite um CNPJ para consultar.';
      });

      return;
    }

    setState(() {
      resultadoCnpj =
          'Consulta realizada para o CNPJ: '
          '${cnpjController.text}';
    });
  }

  @override
  void dispose() {
    cepController.dispose();
    cnpjController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: verdeEscuro,
        foregroundColor: Colors.white,
        title: const Text('Consultas'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            const Text(
              'Consultas',

              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: verdeEscuro,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Consulte informações de CEP e CNPJ.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            // CEP
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: verde,
                          size: 30,
                        ),

                        SizedBox(width: 10),

                        Text(
                          'Consulta de CEP',

                          style: TextStyle(
                            fontSize: 19,
                            fontWeight:
                                FontWeight.bold,
                            color: verdeEscuro,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: cepController,

                      keyboardType:
                          TextInputType.number,

                      maxLength: 8,

                      decoration:
                          InputDecoration(
                        labelText: 'Digite o CEP',

                        prefixIcon:
                            const Icon(Icons.search),

                        filled: true,

                        fillColor:
                            Colors.grey.shade100,

                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,

                      child:
                          ElevatedButton.icon(
                        onPressed: consultarCep,

                        icon: const Icon(
                          Icons.search,
                        ),

                        label: const Text(
                          'Consultar CEP',
                        ),

                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              verdeEscuro,

                          foregroundColor:
                              Colors.white,
                        ),
                      ),
                    ),

                    if (resultadoCep.isNotEmpty)
                      Padding(
                        padding:
                            const EdgeInsets.only(
                          top: 15,
                        ),

                        child: Text(
                          resultadoCep,

                          style: const TextStyle(
                            color: verdeEscuro,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // CNPJ
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.business,
                          color: roxo,
                          size: 30,
                        ),

                        SizedBox(width: 10),

                        Text(
                          'Consulta de CNPJ',

                          style: TextStyle(
                            fontSize: 19,
                            fontWeight:
                                FontWeight.bold,
                            color: roxo,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: cnpjController,

                      keyboardType:
                          TextInputType.number,

                      maxLength: 14,

                      decoration:
                          InputDecoration(
                        labelText: 'Digite o CNPJ',

                        prefixIcon:
                            const Icon(Icons.search),

                        filled: true,

                        fillColor:
                            Colors.grey.shade100,

                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,

                      child:
                          ElevatedButton.icon(
                        onPressed: consultarCnpj,

                        icon: const Icon(
                          Icons.search,
                        ),

                        label: const Text(
                          'Consultar CNPJ',
                        ),

                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor: roxo,

                          foregroundColor:
                              Colors.white,
                        ),
                      ),
                    ),

                    if (resultadoCnpj.isNotEmpty)
                      Padding(
                        padding:
                            const EdgeInsets.only(
                          top: 15,
                        ),

                        child: Text(
                          resultadoCnpj,

                          style: const TextStyle(
                            color: roxo,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}