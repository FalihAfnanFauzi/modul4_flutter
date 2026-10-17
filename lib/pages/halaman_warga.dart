import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/pengajuan_model.dart';
import '../navigation/app_routes.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  // Palet 2-3 warna solid sederhana tanpa gradasi
  static const Color warnaUtama = Color(0xFF1E3A8A); // Deep Solid Navy
  static const Color warnaAksen = Color(0xFF475569); // Slate Grey
  static const Color warnaLatar = Color(0xFFF8FAFC); // Neutral Grey

  @override
  Widget build(BuildContext context) {
    final pengajuanModel = context.watch<PengajuanModel>();
    final daftarPengajuan = pengajuanModel.daftarPengajuan;

    return Scaffold(
      backgroundColor: warnaLatar,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Kartu Identitas Digital Warga (Solid Flat)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: warnaUtama,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.person, color: Colors.white, size: 32),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Falih Afnan Fauzi',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'NIM: 707012400017 • Kelas 48-03',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: warnaUtama),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'D4 Sistem Informasi Kota Cerdas',
                        style: TextStyle(fontSize: 11, color: warnaAksen),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Menu Cepat Akses Layanan Baru Modul 4
          Row(
            children: [
              _buildMenuAksesCepat(
                context,
                judul: 'Tanya Petugas',
                icon: Icons.chat_bubble_outline,
                rute: AppRoutes.tanyaPetugas,
              ),
              const SizedBox(width: 8),
              _buildMenuAksesCepat(
                context,
                judul: 'Lokasi Kantor',
                icon: Icons.map_outlined,
                rute: AppRoutes.lokasiKantor,
              ),
              const SizedBox(width: 8),
              _buildMenuAksesCepat(
                context,
                judul: 'Statistik',
                icon: Icons.bar_chart_outlined,
                rute: AppRoutes.statistikLayanan,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Judul Seksi Riwayat Pengajuan
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Riwayat Pengajuan Layanan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0F172A)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: warnaUtama,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${pengajuanModel.totalPengajuan} Berkas',
                  style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Petunjuk: Ketuk (tap) untuk rincian, tekan lama (long-press) untuk tandai selesai.',
            style: TextStyle(fontSize: 11, color: warnaAksen),
          ),
          const SizedBox(height: 10),

          // Daftar Kartu Riwayat Pengajuan dengan GestureDetector
          if (daftarPengajuan.isEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              alignment: Alignment.center,
              child: const Text('Belum ada riwayat permohonan layanan.'),
            )
          else
            ...daftarPengajuan.map((item) => _buildKartuPengajuan(context, item)),
          const SizedBox(height: 60), // Ruang untuk FAB
        ],
      ),
      // FloatingActionButton membuka formulir pengajuan baru menggunakan named route
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.detailLayanan,
            arguments: {
              'namaLayanan': 'Pendaftaran Layanan Terpadu Cerdas',
              'dinas': 'Dinas Komunikasi, Informatika & Tata Ruang Kota',
              'jamOperasional': '08:00 - 15:30 WITA',
              'keterangan': 'Formulir terpadu pengajuan perizinan dan administrasi warga secara mandiri.',
            },
          );
        },
        backgroundColor: warnaUtama,
        foregroundColor: Colors.white,
        elevation: 2,
        icon: const Icon(Icons.add),
        label: const Text(
          'Ajukan Layanan Baru',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildMenuAksesCepat(BuildContext context, {required String judul, required IconData icon, required String rute}) {
    return Expanded(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, rute),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
          ),
          child: Column(
            children: [
              Icon(icon, color: warnaUtama, size: 22),
              const SizedBox(height: 4),
              Text(
                judul,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKartuPengajuan(BuildContext context, ItemPengajuan item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        // onTap: Membuka dialog rincian pengajuan
        onTap: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: Row(
                children: [
                  const Icon(Icons.info_outline, color: warnaUtama, size: 22),
                  const SizedBox(width: 8),
                  const Text('Rincian Pengajuan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDialogBaris('ID Berkas', item.id),
                  _buildDialogBaris('Nama Pemohon', item.namaLengkap),
                  _buildDialogBaris('Email', item.email),
                  _buildDialogBaris('Layanan', item.jenisLayanan),
                  _buildDialogBaris('Bidang', item.bidang),
                  _buildDialogBaris('Sesi Kunjungan', item.sesiKunjungan),
                  _buildDialogBaris('Status', item.isSelesai ? 'Selesai Ditindaklanjuti' : 'Sedang Diproses'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Tutup', style: TextStyle(color: warnaUtama, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          );
        },
        // onLongPress: Menandai pengajuan selesai ditindaklanjuti
        onLongPress: () {
          if (!item.isSelesai) {
            context.read<PengajuanModel>().tandaiSelesai(item.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: warnaUtama,
                content: Text('Berkas [${item.id}] berhasil ditandai selesai ditindaklanjuti.'),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: item.isSelesai ? warnaUtama : const Color(0xFFCBD5E1),
              width: item.isSelesai ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.id,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: warnaUtama),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: item.isSelesai ? warnaUtama : const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.isSelesai ? Icons.check_circle : Icons.hourglass_top,
                          size: 12,
                          color: item.isSelesai ? Colors.white : warnaAksen,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.isSelesai ? 'Selesai' : 'Diproses',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: item.isSelesai ? Colors.white : warnaAksen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                item.jenisLayanan,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)),
              ),
              const SizedBox(height: 3),
              Text(
                'Pemohon: ${item.namaLengkap} • Sesi: ${item.sesiKunjungan}',
                style: const TextStyle(fontSize: 11, color: warnaAksen),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDialogBaris(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(label, style: const TextStyle(fontSize: 11, color: warnaAksen)),
          ),
          const Text(': ', style: TextStyle(fontSize: 11, color: warnaAksen)),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
          ),
        ],
      ),
    );
  }
}
