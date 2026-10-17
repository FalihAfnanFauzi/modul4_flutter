import 'package:flutter/material.dart';

class HalamanPengaturanKota extends StatefulWidget {
  const HalamanPengaturanKota({super.key});

  @override
  State<HalamanPengaturanKota> createState() => _HalamanPengaturanKotaState();
}

class _HalamanPengaturanKotaState extends State<HalamanPengaturanKota> {
  bool _notifikasiDarurat = true;
  bool _sensorPolusiOtomatis = true;
  bool _hematEnergi = false;
  String _distrikTerpilih = 'Kawasan Inti Pusat Pemerintahan (KIPP)';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Kota'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Preferensi Layanan & Notifikasi Kota',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.notifications_active_outlined),
                  title: const Text('Peringatan Dini Bencana & Cuaca'),
                  subtitle: const Text('Notifikasi sensor cuaca dan kualitas udara IKN'),
                  value: _notifikasiDarurat,
                  onChanged: (val) => setState(() => _notifikasiDarurat = val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.air_rounded),
                  title: const Text('Deteksi Sensor Polusi Real-time'),
                  subtitle: const Text('Pembaruan data indeks standar pencemar udara harian'),
                  value: _sensorPolusiOtomatis,
                  onChanged: (val) => setState(() => _sensorPolusiOtomatis = val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.energy_savings_leaf_outlined),
                  title: const Text('Mode Hemat Energi Smart Home'),
                  subtitle: const Text('Integrasikan dengan jaringan cerdas PLN IKN'),
                  value: _hematEnergi,
                  onChanged: (val) => setState(() => _hematEnergi = val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Wilayah & Domisili',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.location_on_outlined),
              title: const Text('Distrik Wilayah Tempat Tinggal'),
              subtitle: Text(_distrikTerpilih),
              trailing: const Icon(Icons.arrow_drop_down),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (ctx) => SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Pilih Distrik Ibu Kota',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ...[
                          'Kawasan Inti Pusat Pemerintahan (KIPP)',
                          'Kawasan Sepaku Sub-Pusat A',
                          'Kawasan Penyangga Samboja',
                          'Kawasan Riset & Teknologi',
                        ].map(
                          (distrik) => ListTile(
                            title: Text(distrik),
                            trailing: _distrikTerpilih == distrik
                                ? const Icon(Icons.check, color: Colors.teal)
                                : null,
                            onTap: () {
                              setState(() => _distrikTerpilih = distrik);
                              Navigator.pop(ctx);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
