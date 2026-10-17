import 'package:flutter/material.dart';

class HalamanTentangAplikasi extends StatelessWidget {
  const HalamanTentangAplikasi({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.hub_rounded,
                  size: 64,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Nusantara Cerdas Mobile',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Versi 2.0.26 (Edisi Balai Kota)',
                style: TextStyle(
                  fontSize: 13,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Aplikasi Layanan Warga Smart City "Nusantara Cerdas Mobile" dikembangkan oleh Dinas Komunikasi dan Informatika Kota Nusantara bekerja sama dengan tim pengembang mahasiswa PPBL untuk menghadirkan kemudahan akses layanan perizinan, kesehatan, transportasi publik cerdas, dan kanal pelaporan warga secara terpadu.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, height: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Pengembang: Falih Afnan F (NIM: 707012400017)',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
