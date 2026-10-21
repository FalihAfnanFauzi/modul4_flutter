import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/favorit_cubit.dart';
import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';

class HalamanLayanan extends StatelessWidget {
  const HalamanLayanan({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.surface,
            child: const TabBar(
              tabAlignment: TabAlignment.fill,
              tabs: [
                Tab(
                  icon: Icon(Icons.assignment_outlined),
                  text: 'Perizinan',
                ),
                Tab(
                  icon: Icon(Icons.local_hospital_outlined),
                  text: 'Kesehatan',
                ),
                Tab(
                  icon: Icon(Icons.directions_bus_outlined),
                  text: 'Transportasi',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildDaftarLayanan(context, _layananPerizinan),
                _buildDaftarLayanan(context, _layananKesehatan),
                _buildDaftarLayanan(context, _layananTransportasi),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDaftarLayanan(
    BuildContext context,
    List<Map<String, String>> dataLayanan,
  ) {
    final theme = Theme.of(context);

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: dataLayanan.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (itemContext, index) {
        final item = dataLayanan[index];
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6),
            ),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Icon(
                Icons.business_center_outlined,
                color: theme.colorScheme.primary,
                size: 20,
              ),
            ),
            title: Text(
              item['namaLayanan'] ?? '',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              item['dinas'] ?? '',
              style: TextStyle(
                fontSize: 12,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocSelector<FavoritCubit, Set<String>, bool>(
                  selector: (favoritSet) => favoritSet.contains(item['namaLayanan']),
                  builder: (context, isFav) {
                    return IconButton(
                      icon: Icon(
                        isFav ? Icons.star_rounded : Icons.star_border_rounded,
                        color: isFav ? const Color(0xFFEAB308) : Colors.grey,
                      ),
                      tooltip: isFav ? 'Hapus Favorit' : 'Tandai Favorit',
                      onPressed: () {
                        context.read<FavoritCubit>().alihkan(item['namaLayanan']!);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isFav
                                  ? 'Dihapus dari layanan favorit.'
                                  : 'Ditambahkan ke layanan favorit!',
                            ),
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    );
                  },
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
            onTap: () async {
              final hasil = await Navigator.pushNamed(
                itemContext,
                AppRoutes.detailLayanan,
                arguments: item,
              );

              if (!itemContext.mounted) return;

              if (hasil is String) {
                ScaffoldMessenger.of(itemContext).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(hasil)),
                      ],
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: theme.colorScheme.primary,
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  static const List<Map<String, String>> _layananPerizinan = [
    {
      'namaLayanan': 'Izin Usaha Mikro & Kecil (IUMK)',
      'dinas': 'Dinas Penanaman Modal & PTSP Nusantara',
      'jamOperasional': 'Senin - Jumat, 08.00 - 15.00 WITA',
      'keterangan':
          'Pelayanan penerbitan izin usaha resmi bagi pelaku usaha mikro dan kecil secara daring dan instan di kawasan Nusantara Cerdas.',
    },
    {
      'namaLayanan': 'Persetujuan Bangunan Gedung (PBG)',
      'dinas': 'Dinas Pekerjaan Umum & Tata Ruang',
      'jamOperasional': 'Senin - Jumat, 08.30 - 16.00 WITA',
      'keterangan':
          'Layanan legalitas dan verifikasi perizinan mendirikan atau merenovasi bangunan berstandar konstruksi hijau dan tahan bencana.',
    },
    {
      'namaLayanan': 'Izin Reklame & Media Promosi',
      'dinas': 'Badan Pendapatan Daerah Nusantara',
      'jamOperasional': 'Senin - Kamis, 09.00 - 14.30 WITA',
      'keterangan':
          'Permohonan penempatan media reklame dan baliho komersial pada titik ruang publik terpadu sesuai tata estetika kota.',
    },
    {
      'namaLayanan': 'Izin Penelitian & Riset Ibu Kota',
      'dinas': 'Bappeda & Riset Daerah Nusantara',
      'jamOperasional': 'Senin - Jumat, 08.00 - 16.00 WITA',
      'keterangan':
          'Rekomendasi resmi perizinan riset lapangan dan kajian akademis strategis di kawasan IKN.',
    },
  ];

  static const List<Map<String, String>> _layananKesehatan = [
    {
      'namaLayanan': 'Pendaftaran Puskesmas Online',
      'dinas': 'Dinas Kesehatan Kota Nusantara',
      'jamOperasional': 'Setiap Hari, 07.30 - 14.00 WITA',
      'keterangan':
          'Reservasi antrean periksa dokter umum, gigi, dan poli anak di seluruh Puskesmas terintegrasi tanpa perlu antre fisik.',
    },
    {
      'namaLayanan': 'Layanan Ambulans Tanggap Cepat 119',
      'dinas': 'UPTD Kedaruratan Medis Nusantara',
      'jamOperasional': '24 Jam Nonstop',
      'keterangan':
          'Panggilan gawat darurat medis dengan armada ambulans listrik berteknologi pemantau tanda vital nirkabel.',
    },
    {
      'namaLayanan': 'Cek Ketersediaan Kamar Rawat RSUD',
      'dinas': 'RSUD Pratama Sepaku Nusantara',
      'jamOperasional': '24 Jam (Pembaruan Real-time)',
      'keterangan':
          'Pengecekan ketersediaan ranjang rawat inap kelas 1, 2, 3, dan ruang isolasi terintegrasi satu data kesehatan.',
    },
    {
      'namaLayanan': 'Telemedisin Dokter Spesialis Cerdas',
      'dinas': 'Pusat Layanan Telehealth Nusantara',
      'jamOperasional': 'Senin - Sabtu, 08.00 - 20.00 WITA',
      'keterangan':
          'Konsultasi daring langsung dengan dokter spesialis bersertifikasi beserta pengantaran obat ke rumah warga.',
    },
  ];

  static const List<Map<String, String>> _layananTransportasi = [
    {
      'namaLayanan': 'Tiket Bus Rapid Transit (BRT) Nusantara',
      'dinas': 'Dinas Perhubungan Nusantara Cerdas',
      'jamOperasional': 'Setiap Hari, 05.00 - 22.00 WITA',
      'keterangan':
          'Pemesanan tiket digital armada bus listrik nir-emisi koridor utama KIPP dan koridor penghubung kawasan mitra.',
    },
    {
      'namaLayanan': 'Uji Emisi Kendaraan & Sertifikasi Hijau',
      'dinas': 'Dinas Lingkungan Hidup Nusantara',
      'jamOperasional': 'Senin - Jumat, 08.00 - 15.30 WITA',
      'keterangan':
          'Pemeriksaan kepatuhan emisi gas buang kendaraan roda dua dan empat guna mendukung target Net Zero Emission.',
    },
    {
      'namaLayanan': 'Layanan & Pengaduan Parkir Pintar',
      'dinas': 'Dishub Unit Pengelola Parkir Cerdas',
      'jamOperasional': 'Setiap Hari, 06.00 - 21.00 WITA',
      'keterangan':
          'Pelaporan pelanggaran parkir liar dan reservasi slot parkir gedung otomatis berbasis sensor sensor nirkabel.',
    },
    {
      'namaLayanan': 'Peminjaman Sepeda Listrik Publik (EcoBike)',
      'dinas': 'Otorita Transportasi Hijau',
      'jamOperasional': 'Setiap Hari, 06.00 - 19.00 WITA',
      'keterangan':
          'Aktivasi akun keanggotaan dan peminjaman armada sepeda listrik di stasiun pengisian daya ramah lingkungan.',
    },
  ];
}
