import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../cubit/theme_cubit.dart';
import '../model/pengajuan_model.dart';
import '../navigation/app_routes.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  // Palet 2-3 warna solid sederhana tanpa gradasi
  static const Color warnaUtama = Color(0xFF1E3A8A); // Deep Solid Navy
  static const Color warnaAksen = Color(0xFF475569); // Slate Grey

  @override
  Widget build(BuildContext context) {
    final pengajuanModel = context.watch<PengajuanModel>();
    final daftarPengajuan = pengajuanModel.daftarPengajuan;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Kartu Identitas Digital Warga (Solid Flat)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF2563EB) : warnaUtama,
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
                    children: [
                      Text(
                        'Falih Afnan Fauzi',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'NIM: 707012400017 • Kelas 48-03',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isDark ? const Color(0xFF60A5FA) : warnaUtama,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'D4 Sistem Informasi Kota Cerdas',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? const Color(0xFF94A3B8) : warnaAksen,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Sakelar Pengaturan Mode Gelap (ThemeCubit)
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              final isThemeDark = themeMode == ThemeMode.dark;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          isThemeDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                          color: isThemeDark ? const Color(0xFF60A5FA) : warnaUtama,
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mode Tampilan Gelap (Dark Theme)',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              isThemeDark ? 'ThemeCubit: ThemeMode.dark aktif' : 'ThemeCubit: ThemeMode.light aktif',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark ? const Color(0xFF94A3B8) : warnaAksen,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Switch(
                      value: isThemeDark,
                      activeThumbColor: const Color(0xFF2563EB),
                      onChanged: (val) {
                        context.read<ThemeCubit>().toggleTheme();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 14),

          // Menu Cepat Akses Layanan Baru Modul 4
          Row(
            children: [
              _buildMenuAksesCepat(
                context,
                isDark: isDark,
                judul: 'Tanya Petugas',
                icon: Icons.chat_bubble_outline,
                rute: AppRoutes.tanyaPetugas,
              ),
              const SizedBox(width: 8),
              _buildMenuAksesCepat(
                context,
                isDark: isDark,
                judul: 'Lokasi Kantor',
                icon: Icons.map_outlined,
                rute: AppRoutes.lokasiKantor,
              ),
              const SizedBox(width: 8),
              _buildMenuAksesCepat(
                context,
                isDark: isDark,
                judul: 'Statistik',
                icon: Icons.bar_chart_outlined,
                rute: AppRoutes.statistikLayanan,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Seksi Layanan Favorit Warga (FavoritCubit - Reaktif)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Layanan Favorit Warga',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              BlocBuilder<FavoritCubit, Set<String>>(
                builder: (context, favs) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAB308),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${favs.length} Favorit',
                      style: const TextStyle(color: Color(0xFF0F172A), fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Layanan yang Anda tandai bintang di tab Layanan (dikelola via FavoritCubit).',
            style: TextStyle(fontSize: 11, color: isDark ? const Color(0xFF94A3B8) : warnaAksen),
          ),
          const SizedBox(height: 10),

          BlocBuilder<FavoritCubit, Set<String>>(
            builder: (context, favs) {
              if (favs.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E293B) : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Belum ada layanan favorit. Ketuk ikon bintang pada tab Layanan.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                );
              }
              return Column(
                children: favs.map((namaLayanan) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
                      ),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 16,
                          backgroundColor: Color(0xFFFEF3C7),
                          child: Icon(Icons.star_rounded, color: Color(0xFFEAB308), size: 20),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            namaLayanan,
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                          tooltip: 'Hapus Favorit',
                          onPressed: () {
                            context.read<FavoritCubit>().batalTandai(namaLayanan);
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 20),

          // Judul Seksi Riwayat Pengajuan Layanan
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Riwayat Pengajuan Layanan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              BlocSelector<PengajuanCubit, List<ItemPengajuan>, int>(
                selector: (state) => state.length,
                builder: (context, total) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2563EB) : warnaUtama,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$total Berkas',
                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Petunjuk: Ketuk (tap) untuk rincian, tekan lama (long-press) untuk tandai selesai.',
            style: TextStyle(fontSize: 11, color: isDark ? const Color(0xFF94A3B8) : warnaAksen),
          ),
          const SizedBox(height: 10),

          // Daftar Kartu Riwayat Pengajuan
          if (daftarPengajuan.isEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              alignment: Alignment.center,
              child: const Text('Belum ada riwayat permohonan layanan.'),
            )
          else
            ...daftarPengajuan.map((item) => _buildKartuPengajuan(context, item, isDark)),
          const SizedBox(height: 60), // Ruang untuk FAB
        ],
      ),
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
        backgroundColor: isDark ? const Color(0xFF2563EB) : warnaUtama,
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

  Widget _buildMenuAksesCepat(
    BuildContext context, {
    required bool isDark,
    required String judul,
    required IconData icon,
    required String rute,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, rute),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: isDark ? const Color(0xFF60A5FA) : warnaUtama, size: 22),
              const SizedBox(height: 4),
              Text(
                judul,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKartuPengajuan(BuildContext context, ItemPengajuan item, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: Row(
                children: [
                  Icon(Icons.info_outline, color: isDark ? const Color(0xFF60A5FA) : warnaUtama, size: 22),
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
                  child: Text('Tutup', style: TextStyle(color: isDark ? const Color(0xFF60A5FA) : warnaUtama, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          );
        },
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
            color: isDark ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
              width: 1,
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
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isDark ? const Color(0xFF94A3B8) : warnaAksen,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: item.isSelesai ? const Color(0xFFDCFCE7) : const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      item.isSelesai ? 'Selesai' : 'Sedang Diproses',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: item.isSelesai ? const Color(0xFF166534) : const Color(0xFF92400E),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                item.jenisLayanan,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 12, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    '${item.bidang} • ${item.sesiKunjungan}',
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? const Color(0xFF94A3B8) : warnaAksen,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDialogBaris(String label, String nilai) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ),
          const Text(': ', style: TextStyle(fontSize: 12, color: Colors.grey)),
          Expanded(
            child: Text(
              nilai,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
