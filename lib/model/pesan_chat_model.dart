import 'package:flutter/foundation.dart';

class PesanChat {
  final String id;
  final String pengirim; // 'warga' atau 'petugas'
  final String teks;
  final DateTime waktu;

  PesanChat({
    required this.id,
    required this.pengirim,
    required this.teks,
    required this.waktu,
  });

  bool get isWarga => pengirim == 'warga';
}

class PesanChatModel extends ChangeNotifier {
  final List<PesanChat> _daftarPesan = [
    PesanChat(
      id: 'MSG-001',
      pengirim: 'petugas',
      teks: 'Halo! Selamat datang di layanan Tanya Petugas Nusantara Cerdas. Ada yang bisa kami bantu seputar permohonan layanan publik?',
      waktu: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
    PesanChat(
      id: 'MSG-002',
      pengirim: 'warga',
      teks: 'Selamat siang min, untuk syarat permohonan izin usaha mikro apakah berkas KTP wajib dilegalisir?',
      waktu: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
    PesanChat(
      id: 'MSG-003',
      pengirim: 'petugas',
      teks: 'Cukup melampirkan foto KTP asli dan surat pengantar RT/RW melalui formulir pengajuan online, tidak perlu legalisir fisik ya.',
      waktu: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
  ];

  List<PesanChat> get daftarPesan => List.unmodifiable(_daftarPesan);

  void kirimPesanWarga(String teks) {
    if (teks.trim().isEmpty) return;
    
    _daftarPesan.add(
      PesanChat(
        id: 'MSG-${DateTime.now().millisecondsSinceEpoch}',
        pengirim: 'warga',
        teks: teks.trim(),
        waktu: DateTime.now(),
      ),
    );
    notifyListeners();

    // Simulasi balasan otomatis dari petugas setelah 1.5 detik
    Future.delayed(const Duration(milliseconds: 1500), () {
      _daftarPesan.add(
        PesanChat(
          id: 'MSG-RESP-${DateTime.now().millisecondsSinceEpoch}',
          pengirim: 'petugas',
          teks: 'Terima kasih atas pesan Anda. Petugas loket kami telah menerima informasi ini dan siap melayani kunjungan Anda sesuai sesi.',
          waktu: DateTime.now(),
        ),
      );
      notifyListeners();
    });
  }
}
