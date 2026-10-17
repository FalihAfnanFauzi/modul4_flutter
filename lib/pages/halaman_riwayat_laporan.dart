import 'package:flutter/material.dart';

class HalamanRiwayatLaporan extends StatefulWidget {
  const HalamanRiwayatLaporan({super.key});

  @override
  State<HalamanRiwayatLaporan> createState() => _HalamanRiwayatLaporanState();
}

class _HalamanRiwayatLaporanState extends State<HalamanRiwayatLaporan> {
  final List<Map<String, String>> _daftarLaporan = [
    {
      'id': 'LAP-001',
      'judul': 'Lampu Penerangan Padam di Sumbu Kebangsaan Barat',
      'kategori': 'Infrastruktur',
      'tanggal': '20 September 2026',
      'status': 'Selesai',
      'lokasi': 'KIPP Nusantara Zona A',
    },
    {
      'id': 'LAP-002',
      'judul': 'Genangan Air di Jalur Pedestrian Sepaku',
      'kategori': 'Drainase & Sanitasi',
      'tanggal': '21 September 2026',
      'status': 'Diproses',
      'lokasi': 'Blok D3, Kawasan Hunian ASN',
    },
    {
      'id': 'LAP-003',
      'judul': 'Sensitivitas Sensor Halte Bus Listrik Tidak Responsif',
      'kategori': 'Fasilitas Cerdas',
      'tanggal': '22 September 2026',
      'status': 'Diproses',
      'lokasi': 'Halte Plaza Nusantara',
    },
    {
      'id': 'LAP-004',
      'judul': 'Tempat Pemilahan Sampah Pintar Penuh',
      'kategori': 'Kebersihan',
      'tanggal': '23 September 2026',
      'status': 'Menunggu',
      'lokasi': 'Taman Sumbu Barat',
    },
  ];

  void _tambahLaporanBaru() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Formulir pelaporan warga baru berhasil dibuka!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _tampilkanPesanAksi(String aksi) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Aksi $aksi telah dipilih.'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Laporan Warga'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _daftarLaporan.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final laporan = _daftarLaporan[index];
          final String status = laporan['status'] ?? '';

          Color statusColor;
          if (status == 'Selesai') {
            statusColor = Colors.green;
          } else if (status == 'Diproses') {
            statusColor = Colors.orange;
          } else {
            statusColor = Colors.blueGrey;
          }

          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          laporan['id'] ?? '',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: statusColor.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    laporan['judul'] ?? '',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.place_outlined,
                        size: 14,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        laporan['lokasi'] ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        laporan['tanggal'] ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // FloatingActionButton menempel pada cekungan bilah bawah (centerDocked)
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahLaporanBaru,
        tooltip: 'Buat Laporan Baru',
        child: const Icon(Icons.add_comment_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // BottomAppBar sebagai wadah aksi halaman penuh
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.search_rounded),
              tooltip: 'Cari Laporan',
              onPressed: () => _tampilkanPesanAksi('Pencarian'),
            ),
            IconButton(
              icon: const Icon(Icons.filter_list_rounded),
              tooltip: 'Saring Status',
              onPressed: () => _tampilkanPesanAksi('Filter Status'),
            ),
            const SizedBox(width: 44), // Ruang untuk FloatingActionButton
            IconButton(
              icon: const Icon(Icons.sort_rounded),
              tooltip: 'Urutkan Waktu',
              onPressed: () => _tampilkanPesanAksi('Pengurutan'),
            ),
            IconButton(
              icon: const Icon(Icons.refresh_rounded),
              tooltip: 'Segarkan Data',
              onPressed: () => _tampilkanPesanAksi('Penyegaran Data'),
            ),
          ],
        ),
      ),
    );
  }
}
