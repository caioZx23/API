import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraApp extends StatefulWidget {
  final CameraDescription camera;

  const CameraApp({super.key, required this.camera});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController? camera;
  XFile? foto;
  String? erroCamera;

  @override
  void initState() {
    super.initState();

    _inicializarCamera();
  }

  Future<void> _inicializarCamera() async {
    final controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    try {
      await controller.initialize();
      if (!mounted) {
        await controller.dispose();
        return;
      }
      setState(() => camera = controller);
    } catch (_) {
      await controller.dispose();
      if (mounted) {
        setState(() => erroCamera = 'Não foi possível iniciar a câmera.');
      }
    }
  }

  @override
  void dispose() {
    camera?.dispose();
    super.dispose();
  }

  Future<void> tirarFoto() async {
    final controller = camera;
    if (controller == null || !controller.value.isInitialized) return;

    try {
      final imagem = await controller.takePicture();
      if (mounted) setState(() => foto = imagem);
    } catch (_) {
      if (mounted) {
        setState(() => erroCamera = 'Não foi possível tirar a foto.');
      }
    }
  }

  void abrirCamera() {
    setState(() {
      foto = null;
      erroCamera = null;
    });
  }

  Future<void> galeria() async {
    try {
      final imagem = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (mounted && imagem != null) setState(() => foto = imagem);
    } catch (_) {
      if (mounted) {
        setState(() => erroCamera = 'Não foi possível abrir a galeria.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = camera;
    if (erroCamera != null) {
      return const Scaffold(
        body: Center(child: Text('Não foi possível usar a câmera.')),
      );
    }
    if (controller == null || !controller.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Câmera')),

      body: Column(
        children: [
          Expanded(
            child: foto == null
                ? CameraPreview(controller)
                : FutureBuilder<Uint8List>(
                    future: foto!.readAsBytes(),
                    builder: (_, imagem) {
                      if (!imagem.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return Image.memory(imagem.data!, fit: BoxFit.contain);
                    },
                  ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CÂMERA / NOVA FOTO
              FloatingActionButton(
                onPressed: foto == null ? tirarFoto : abrirCamera,
                child: Icon(foto == null ? Icons.camera_alt : Icons.camera),
              ),

              const SizedBox(width: 30),

              // GALERIA
              FloatingActionButton(
                onPressed: galeria,
                child: const Icon(Icons.photo),
              ),
            ],
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
