class Catatan {
  final String id;
  final String judul;
  final String isi;
  final DateTime dibuatPada;
  final bool disematkan;

  const Catatan({
    required this.id,
    required this.judul,
    required this.isi,
    required this.dibuatPada,
    this.disematkan = false,
  });

  factory Catatan.baru({required String judul, required String isi}) {
    return Catatan(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      judul: judul.trim(),
      isi: isi,
      dibuatPada: DateTime.now(),
    );
  }

  bool get judulValid => judul.trim().isNotEmpty && judul.trim().length <= 80;

  Catatan copyWith({String? judul, String? isi, bool? disematkan}) {
    return Catatan(
      id: id,
      judul: judul ?? this.judul,
      isi: isi ?? this.isi,
      dibuatPada: dibuatPada,
      disematkan: disematkan ?? this.disematkan,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'isi': isi,
      'dibuatPada': dibuatPada.toIso8601String(),
      'disematkan': disematkan,
    };
  }

  factory Catatan.fromMap(Map<String, dynamic> map) {
    return Catatan(
      id: map['id'] as String,
      judul: map['judul'] as String,
      isi: map['isi'] as String,
      dibuatPada: DateTime.parse(map['dibuatPada'] as String),
      disematkan: map['disematkan'] as bool,
    );
  }

  String get ringkasan => isi.length <= 50 ? isi : '${isi.substring(0, 50)}...';

  bool get baruSaja => DateTime.now().difference(dibuatPada).inHours < 24;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Catatan &&
          other.id == id &&
          other.judul == judul &&
          other.isi == isi &&
          other.disematkan == disematkan;

  @override
  int get hashCode => Object.hash(id, judul, isi, disematkan);

  @override
  String toString() => 'Catatan(id: $id, judul: $judul)';
}
