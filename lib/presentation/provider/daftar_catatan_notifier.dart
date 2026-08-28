import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/catatan.dart';

class CatatanRepository {
  final List<Catatan> _data = [];

  List<Catatan> ambilSemua() => List.unmodifiable(_data);

  void tambah(Catatan catatan) => _data.add(catatan);

  void hapus(String id) => _data.removeWhere((c) => c.id == id);
}

final catatanRepositoryProvider = Provider<CatatanRepository>((ref) {
  return CatatanRepository();
});

class DaftarCatatanNotifier extends Notifier<List<Catatan>> {
  @override
  List<Catatan> build() {
    return ref.watch(catatanRepositoryProvider).ambilSemua();
  }

  void tambah(String judul, String isi) {
    final baru = Catatan.baru(judul: judul, isi: isi);
    if (!baru.judulValid) return;
    ref.read(catatanRepositoryProvider).tambah(baru);
    state = [baru, ...state];
  }

  void hapus(String id) {
    ref.read(catatanRepositoryProvider).hapus(id);
    state = state.where((c) => c.id != id).toList();
  }
}

class daftar_catatan_notifier extends Notifier<List<Catatan>> {
  @override
  List<Catatan> build() {
    return ref.watch(catatanRepositoryProvider).ambilSemua();
  }

  void tambah(String judul, String isi) {
    final baru = Catatan.baru(judul: judul, isi: isi);
    if (!baru.judulValid) return;
    ref.read(catatanRepositoryProvider).tambah(baru);
    state = [baru, ...state];
  }

  void hapus(String id) {
    ref.read(catatanRepositoryProvider).hapus(id);
    state = state.where((c) => c.id != id).toList();
  }

  void tambahKembali(Catatan catatan) {
    ref.read(catatanRepositoryProvider).tambah(catatan);
    state = [catatan, ...state];
  }
}

final daftarCatatanProvider =
    NotifierProvider<daftar_catatan_notifier, List<Catatan>>(
      daftar_catatan_notifier.new,
    );
