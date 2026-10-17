import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  // Palet 2-3 warna solid: Navy, Slate, dan Putih (Tanpa Gradasi)
  static const Color warnaUtama = Color(0xFF1E3A8A); // Deep Solid Navy
  static const Color warnaAksen = Color(0xFF475569); // Slate Grey
  static const Color warnaLatar = Color(0xFFF8FAFC); // Neutral Crisp White/Grey

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> pilarSmartCity = [
      {
        'judul': 'Smart Governance',
        'sub': 'Tata Kelola Digital',
        'deskripsi':
            'Pelayanan birokrasi digital terpadu, transparansi data publik, dan percepatan perizinan satu pintu.',
        'ikon': Icons.gavel_rounded,
      },
      {
        'judul': 'Smart Economy',
        'sub': 'Ekonomi & Usaha',
        'deskripsi':
            'Pemberdayaan UMKM digital, ekosistem transaksi nir-tunai, dan pusat inkubasi inovasi ekonomi kreatif.',
        'ikon': Icons.trending_up_rounded,
      },
      {
        'judul': 'Smart Living',
        'sub': 'Kenyamanan Warga',
        'deskripsi':
            'Fasilitas kesehatan modern, kualitas lingkungan hunian prima, serta jaminan keselamatan warga 24 jam.',
        'ikon': Icons.health_and_safety_rounded,
      },
      {
        'judul': 'Smart Society',
        'sub': 'Masyarakat Berdaya',
        'deskripsi':
            'Peningkatan literasi digital, pendidikan inklusif, dan partisipasi aktif warga dalam pembangunan.',
        'ikon': Icons.people_alt_rounded,
      },
      {
        'judul': 'Smart Environment',
        'sub': 'Lingkungan Hijau',
        'deskripsi':
            'Pemanfaatan energi terbarukan ramah lingkungan, pemantauan kualitas udara, dan daur ulang pintar.',
        'ikon': Icons.eco_rounded,
      },
      {
        'judul': 'Smart Mobility',
        'sub': 'Transportasi Cerdas',
        'deskripsi':
            'Armada bus listrik terpadu, sistem manajemen lalu lintas cerdas, serta jalur sepeda terintegrasi.',
        'ikon': Icons.electric_car_rounded,
      },
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Banner Sambutan Solid (Tanpa Gradasi)
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: warnaUtama,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0x26FFFFFF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.location_city_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Portal Warga Nusantara Cerdas',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Selamat datang di pusat layanan terpadu Kota Nusantara. Akses kemudahan perizinan, kesehatan, transportasi, dan pemantauan 6 pilar smart city dalam satu antarmuka.',
                style: TextStyle(
                  color: Color(0xFFF1F5F9),
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Akses Cepat Fitur Baru Modul 4
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Layanan Terpadu Terintegrasi',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0F172A)),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _buildAksiButton(context, 'Tanya Petugas', Icons.chat_bubble_outline, AppRoutes.tanyaPetugas),
                  const SizedBox(width: 8),
                  _buildAksiButton(context, 'Lokasi Kantor', Icons.map_outlined, AppRoutes.lokasiKantor),
                  const SizedBox(width: 8),
                  _buildAksiButton(context, 'Statistik Layanan', Icons.bar_chart_outlined, AppRoutes.statistikLayanan),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Section Title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Enam Pilar Smart City Nusantara',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)),
            ),
            Icon(
              Icons.stars_rounded,
              color: warnaUtama,
              size: 20,
            ),
          ],
        ),
        const SizedBox(height: 10),

        // 6 Pilar Cards Solid (Tanpa Gradasi)
        ...pilarSmartCity.map((pilar) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    pilar['ikon'] as IconData,
                    color: warnaUtama,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pilar['judul'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        pilar['sub'] as String,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: warnaUtama,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        pilar['deskripsi'] as String,
                        style: const TextStyle(
                          fontSize: 12,
                          color: warnaAksen,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 16),

        // Card Pengujian Route Tidak Terdaftar (onUnknownRoute)
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.bug_report_outlined,
                color: warnaUtama,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Uji Penanganan Rute',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0F172A)),
                    ),
                    Text(
                      'Menguji rute tidak terdaftar (onUnknownRoute 404).',
                      style: TextStyle(fontSize: 11, color: warnaAksen),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/rute_tidak_terdaftar');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: warnaUtama,
                  side: const BorderSide(color: warnaUtama),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: const Text('Uji /salah', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAksiButton(BuildContext context, String label, IconData icon, String rute) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => Navigator.pushNamed(context, rute),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF0F172A),
          side: const BorderSide(color: Color(0xFFCBD5E1)),
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Column(
          children: [
            Icon(icon, color: warnaUtama, size: 20),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
