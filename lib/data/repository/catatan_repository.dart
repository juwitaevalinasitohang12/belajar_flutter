import '../../domain/entity/catatan.dart';

class CatatanRepository {
  final List<Catatan> _data = [];

  List<Catatan> ambilSemua() => List.unmodifiable(_data);

  void tambah(Catatan catatan) => _data.add(catatan);

  void hapus(String id) => _data.removeWhere((c) => c.id == id);
}
