import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/daftar_catatan_notifier.dart';

class LayarTambah extends ConsumerStatefulWidget {
  const LayarTambah({super.key});

  @override
  ConsumerState<LayarTambah> createState() => _LayarTambahState();
}

class _LayarTambahState extends ConsumerState<LayarTambah> {
  final _judulController = TextEditingController();
  final _isiController = TextEditingController();

  @override
  void dispose() {
    _judulController.dispose();
    _isiController.dispose();
    super.dispose();
  }

  bool get _judulValid {
    final teks = _judulController.text.trim();
    return teks.isNotEmpty && teks.length <= 80;
  }

  void _simpan() {
    if (!_judulValid) return;
    ref
        .read(daftarCatatanProvider.notifier)
        .tambah(_judulController.text, _isiController.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Catatan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _judulController,
              maxLength: 80,
              decoration: const InputDecoration(
                labelText: 'Judul',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _isiController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Isi',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _judulValid ? _simpan : null,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
