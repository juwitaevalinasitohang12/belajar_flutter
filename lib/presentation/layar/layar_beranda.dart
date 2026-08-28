import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/daftar_catatan_notifier.dart';
import '../widget/kartu_catatan.dart';

class LayarBeranda extends ConsumerWidget {
  const LayarBeranda({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catatan = ref.watch(daftarCatatanProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Catatan POLNES')),
      body: catatan.isEmpty
          ? const Center(child: Text('Belum ada catatan'))
          : ListView.builder(
              itemCount: catatan.length,
              itemBuilder: (context, i) {
                final item = catatan[i];
                return Dismissible(
                  key: ValueKey(item.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    ref.read(daftarCatatanProvider.notifier).hapus(item.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('"${item.judul}" dihapus'),
                        action: SnackBarAction(
                          label: 'Urungkan',
                          onPressed: () {
                            ref
                                .read(daftarCatatanProvider.notifier)
                                .tambahKembali(item);
                          },
                        ),
                      ),
                    );
                  },
                  child: KartuCatatan(
                    catatan: item,
                    onKetuk: () => context.pushNamed(
                      'detailCatatan',
                      pathParameters: {'id': item.id},
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed('tambahCatatan'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
