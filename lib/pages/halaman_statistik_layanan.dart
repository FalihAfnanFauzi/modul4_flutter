import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../model/pengajuan_model.dart';

class HalamanStatistikLayanan extends StatelessWidget {
  const HalamanStatistikLayanan({super.key});

  // Palet warna solid sederhana (maksimal 2-3 warna, no gradient)
  static const Color warnaUtama = Color(0xFF1E3A8A); // Deep Solid Navy
  static const Color warnaAksen = Color(0xFF475569); // Slate Grey
  static const Color warnaLatar = Color(0xFFF8FAFC); // Neutral Grey

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PengajuanModel>();

    final int jumlahPerizinan = model.jumlahPerBidang('Perizinan');
    final int jumlahKesehatan = model.jumlahPerBidang('Kesehatan');
    final int jumlahTransportasi = model.jumlahPerBidang('Transportasi');

    final double maxVal = [
      jumlahPerizinan.toDouble(),
      jumlahKesehatan.toDouble(),
      jumlahTransportasi.toDouble(),
      5.0
    ].reduce((a, b) => a > b ? a : b);

    return Scaffold(
      backgroundColor: warnaLatar,
      appBar: AppBar(
        title: const Text(
          'Statistik Layanan Publik',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: warnaUtama,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Kartu Ringkasan Metrik
          Row(
            children: [
              _buildMetrikCard('Total', model.totalPengajuan.toString(), Icons.assignment, warnaUtama),
              const SizedBox(width: 8),
              _buildMetrikCard('Diproses', model.totalDiproses.toString(), Icons.pending_actions, warnaAksen),
              const SizedBox(width: 8),
              _buildMetrikCard('Selesai', model.totalSelesai.toString(), Icons.check_circle, warnaUtama),
            ],
          ),
          const SizedBox(height: 16),

          // Kartu Grafik Batang fl_chart
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.bar_chart, color: warnaUtama, size: 22),
                    SizedBox(width: 8),
                    Text(
                      'Distribusi Permohonan per Bidang',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Data diambil secara dinamis dari PengajuanModel (ChangeNotifier)',
                  style: TextStyle(fontSize: 11, color: warnaAksen),
                ),
                const SizedBox(height: 24),

                // Area Diagram Batang BarChart
                SizedBox(
                  height: 220,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: maxVal + 1,
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            String namaBidang;
                            switch (group.x) {
                              case 0:
                                namaBidang = 'Perizinan';
                                break;
                              case 1:
                                namaBidang = 'Kesehatan';
                                break;
                              default:
                                namaBidang = 'Transportasi';
                            }
                            return BarTooltipItem(
                              '$namaBidang\n${rod.toY.toInt()} Berkas',
                              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 28,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(fontSize: 10, color: warnaAksen),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              String label = '';
                              switch (value.toInt()) {
                                case 0:
                                  label = 'Perizinan';
                                  break;
                                case 1:
                                  label = 'Kesehatan';
                                  break;
                                case 2:
                                  label = 'Transportasi';
                                  break;
                              }
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  label,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 1,
                        getDrawingHorizontalLine: (value) => const FlLine(
                          color: Color(0xFFE2E8F0),
                          strokeWidth: 0.8,
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: const Border(
                          bottom: BorderSide(color: Color(0xFF94A3B8), width: 1),
                          left: BorderSide(color: Color(0xFF94A3B8), width: 1),
                        ),
                      ),
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              toY: jumlahPerizinan.toDouble(),
                              color: warnaUtama, // Solid Navy
                              width: 28,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(
                              toY: jumlahKesehatan.toDouble(),
                              color: warnaAksen, // Solid Slate
                              width: 28,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(
                              toY: jumlahTransportasi.toDouble(),
                              color: warnaUtama, // Solid Navy
                              width: 28,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Rincian Tabel Komparasi
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rincian Beban Pelayanan per Sektor',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0F172A)),
                ),
                const SizedBox(height: 10),
                _buildSektorBaris('Bidang Perizinan & UMKM', jumlahPerizinan, model.totalPengajuan, warnaUtama),
                const Divider(height: 16, color: Color(0xFFF1F5F9)),
                _buildSektorBaris('Bidang Kesehatan & BPJS', jumlahKesehatan, model.totalPengajuan, warnaAksen),
                const Divider(height: 16, color: Color(0xFFF1F5F9)),
                _buildSektorBaris('Bidang Transportasi Cerdas', jumlahTransportasi, model.totalPengajuan, warnaUtama),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetrikCard(String judul, String nilai, IconData icon, Color warna) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: warna, size: 22),
            const SizedBox(height: 6),
            Text(
              nilai,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: warna),
            ),
            const SizedBox(height: 2),
            Text(
              judul,
              style: const TextStyle(fontSize: 11, color: warnaAksen, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSektorBaris(String nama, int jumlah, int total, Color warna) {
    final double persentase = total > 0 ? (jumlah / total) * 100 : 0.0;
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: warna, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            nama,
            style: const TextStyle(fontSize: 12, color: Color(0xFF0F172A)),
          ),
        ),
        Text(
          '$jumlah berkas (${persentase.toStringAsFixed(0)}%)',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
        ),
      ],
    );
  }
}
