import 'package:flutter_test/flutter_test.dart';
import 'package:belajar_flutter/domain/entity/catatan.dart';

void main() {
  group('Pengujian Model Catatan', () {
    test('1. ringkasan mengembalikan teks isi catatan', () {
      final c = Catatan.baru(judul: 'Tes', isi: 'Pemrograman Perangkat Bergerak');
      expect(c.ringkasan, equals('Pemrograman Perangkat Bergerak'));
    });

    test('2. ringkasan mengembalikan teks isi pendek', () {
      final c = Catatan.baru(judul: 'Tes', isi: 'Halo');
      expect(c.ringkasan, equals('Halo'));
    });

    test('3. judulValid true jika judul berisi 1-80 karakter', () {
      final c = Catatan.baru(judul: 'Catatan 1', isi: 'Isi');
      expect(c.judulValid, isTrue);
    });

    test('4. judulValid false jika judul kosong', () {
      final c = Catatan.baru(judul: '', isi: 'Isi');
      expect(c.judulValid, isFalse);
    });

    test('5. judulValid false jika judul melebihi 80 karakter', () {
      final c = Catatan.baru(judul: 'A' * 81, isi: 'Isi');
      expect(c.judulValid, isFalse);
    });

    test('6. baruSaja mengembalikan true untuk catatan baru', () {
      final c = Catatan.baru(judul: 'Tes', isi: 'Isi');
      expect(c.baruSaja, isTrue);
    });

    test('7. toMap menghasilkan Map yang sesuai', () {
      final c = Catatan.baru(judul: 'Tes', isi: 'Isi');
      final map = c.toMap();
      expect(map['judul'], equals('Tes'));
      expect(map['isi'], equals('Isi'));
    });

    test('8. fromMap membuat objek Catatan yang valid', () {
      final map = {
        'id': '123',
        'judul': 'Judul Map',
        'isi': 'Isi Map',
        'dibuatPada': DateTime.now().toIso8601String(),
        'disematkan': false,
      };
      final c = Catatan.fromMap(map);
      expect(c.judul, equals('Judul Map'));
      expect(c.id, equals('123'));
    });

    test('9. Catatan baru tidak disematkan secara default', () {
      final c = Catatan.baru(judul: 'Tes', isi: 'Isi');
      expect(c.disematkan, isFalse);
    });

    test('10. id Catatan baru tidak boleh kosong', () {
      final c = Catatan.baru(judul: 'Tes', isi: 'Isi');
      expect(c.id.isNotEmpty, isTrue);
    });
  });
}