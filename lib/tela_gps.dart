import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projeto_api/app_colors.dart';

class TelaGPS extends StatefulWidget {
  const TelaGPS({super.key});

  @override
  State<TelaGPS> createState() => _TelaGPSState();
}

class _TelaGPSState extends State<TelaGPS> {
  String latitude = 'Aguardando...';
  String longitude = 'Aguardando...';

  bool carregando = false;

  Future<void> buscarLocalizacao() async {
    setState(() {
      carregando = true;
    });

    try {
      bool servicoAtivado = await Geolocator.isLocationServiceEnabled();

      if (!servicoAtivado) {
        setState(() {
          latitude = 'GPS desativado';
          longitude = 'GPS desativado';
          carregando = false;
        });
        return;
      }

      LocationPermission permissao = await Geolocator.checkPermission();

      if (permissao == LocationPermission.denied) {
        permissao = await Geolocator.requestPermission();
      }

      if (permissao == LocationPermission.denied ||
          permissao == LocationPermission.deniedForever) {
        setState(() {
          latitude = 'Permissão negada';
          longitude = 'Permissão negada';
          carregando = false;
        });
        return;
      }

      Position posicao = await Geolocator.getCurrentPosition();

      setState(() {
        latitude = posicao.latitude.toString();
        longitude = posicao.longitude.toString();
        carregando = false;
      });
    } catch (e) {
      setState(() {
        latitude = 'Erro ao obter localização';
        longitude = 'Erro ao obter localização';
        carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: verdeEscuro,
        foregroundColor: Colors.white,
        title: const Text(
          'Minha Localização',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),

        child: Column(
          children: [
            const SizedBox(height: 20),

            // Ícone
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [verdeEscuro, verde]),
                borderRadius: BorderRadius.circular(30),
              ),

              child: const Icon(
                Icons.location_on,
                color: Colors.white,
                size: 70,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Localização GPS',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: verdeEscuro,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Obtenha sua localização geográfica '
              'através do GPS.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 35),

            // Latitude
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Row(
                  children: [
                    Container(
                      width: 55,
                      height: 55,

                      decoration: BoxDecoration(
                        color: verdeEscuro,
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: const Icon(
                        Icons.north,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          const Text(
                            'Latitude',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: verdeEscuro,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(latitude, style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Longitude
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Row(
                  children: [
                    Container(
                      width: 55,
                      height: 55,

                      decoration: BoxDecoration(
                        color: roxo,
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: const Icon(
                        Icons.east,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          const Text(
                            'Longitude',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: roxo,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(longitude, style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Botão
            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: carregando ? null : buscarLocalizacao,

                icon: carregando
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.gps_fixed),

                label: Text(
                  carregando ? 'Obtendo localização...' : 'Obter Localização',

                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
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

            const SizedBox(height: 20),

            // Informação
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: verde.withAlpha(25),
                borderRadius: BorderRadius.circular(15),

                border: Border.all(color: verde),
              ),

              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Icon(Icons.info_outline, color: verdeEscuro),

                  SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      'A latitude e a longitude '
                      'representam a posição geográfica '
                      'atual do dispositivo.',

                      style: TextStyle(fontSize: 14, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
