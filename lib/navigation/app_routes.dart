import 'package:flutter/material.dart';
import '../pages/halaman_detail_layanan.dart';
import '../pages/halaman_pengaturan_kota.dart';
import '../pages/halaman_riwayat_laporan.dart';
import '../pages/halaman_tentang_aplikasi.dart';
import '../pages/halaman_tanya_petugas.dart';
import '../pages/halaman_lokasi_kantor.dart';
import '../pages/halaman_statistik_layanan.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String detailLayanan = '/detail_layanan';
  static const String riwayatLaporan = '/riwayat_laporan';
  static const String pengaturanKota = '/pengaturan_kota';
  static const String tentangAplikasi = '/tentang_aplikasi';
  static const String tanyaPetugas = '/tanya_petugas';
  static const String lokasiKantor = '/lokasi_kantor';
  static const String statistikLayanan = '/statistik_layanan';

  // Daftar rute statis tanpa parameter dinamis
  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (context) => const KerangkaNavigasi(),
      riwayatLaporan: (context) => const HalamanRiwayatLaporan(),
      pengaturanKota: (context) => const HalamanPengaturanKota(),
      tentangAplikasi: (context) => const HalamanTentangAplikasi(),
      tanyaPetugas: (context) => const HalamanTanyaPetugas(),
      lokasiKantor: (context) => const HalamanLokasiKantor(),
      statistikLayanan: (context) => const HalamanStatistikLayanan(),
    };
  }

  // Pembangun rute dinamis dengan arguments
  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    if (settings.name == detailLayanan) {
      final data = settings.arguments as Map<String, String>? ?? const {};
      return MaterialPageRoute(
        builder: (context) => HalamanDetailLayanan(
          namaLayanan: data['namaLayanan'] ?? 'Pendaftaran Layanan Terpadu Cerdas',
          dinas: data['dinas'] ?? 'Dinas Komunikasi, Informatika & Tata Ruang Kota',
          jamOperasional: data['jamOperasional'] ?? '08:00 - 15:30 WITA',
          keterangan: data['keterangan'] ?? 'Formulir terpadu pengajuan permohonan layanan publik warga.',
        ),
      );
    }
    return null;
  }

  // Penanganan rute yang tidak terdaftar (onUnknownRoute)
  static Route<dynamic> routeTidakDikenal(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          title: const Text('Rute Tidak Ditemukan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFF1E3A8A),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  size: 64,
                  color: Color(0xFF1E3A8A),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Galat 404 - Halaman Tidak Ditemukan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Rute "${settings.name}" belum terdaftar pada sistem Nusantara Cerdas.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF475569)),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, size: 16),
                  label: const Text('Kembali ke Halaman Sebelumnya'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
