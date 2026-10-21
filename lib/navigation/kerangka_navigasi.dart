import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/pengajuan_cubit.dart';
import '../model/pengajuan_model.dart';
import 'package:flutter/material.dart';
import '../pages/halaman_beranda.dart';
import '../pages/halaman_layanan.dart';
import '../pages/halaman_warga.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _indeksTerpilih = 0;

  final List<Widget> _halaman = const [
    HalamanBeranda(),
    HalamanLayanan(),
    HalamanWarga(),
  ];

  final List<String> _judul = const [
    'Nusantara Cerdas',
    'Layanan Publik',
    'Identitas Warga',
  ];

  void _pilihTujuan(int indeks) {
    setState(() {
      _indeksTerpilih = indeks;
    });
  }

  void _konfirmasiKeluar() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.logout_rounded, color: Colors.red),
            SizedBox(width: 10),
            Text('Keluar Akun'),
          ],
        ),
        content: const Text(
          'Apakah Anda yakin ingin keluar dari sesi aplikasi Nusantara Cerdas Mobile?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sesi pengguna telah diakhiri.'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Membaca lebar layar untuk tata letak adaptif (ambang 600 piksel)
    final double lebar = MediaQuery.of(context).size.width;
    final bool layarLebar = lebar >= 600;

    // PopScope mencegah aplikasi tertutup mendadak jika pengguna menekan tombol kembali saat di tab lain
    return PopScope(
      canPop: _indeksTerpilih == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _indeksTerpilih != 0) {
          setState(() {
            _indeksTerpilih = 0;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_judul[_indeksTerpilih]),
          centerTitle: false,
        ),
        drawer: _buatDrawer(),
        // Tata letak adaptif: NavigationRail untuk layar lebar dan konten biasa untuk layar sempit
        body: layarLebar ? _tataLetakLebar() : _halaman[_indeksTerpilih],
        // NavigationBar disembunyikan jika pada layar lebar
        bottomNavigationBar: layarLebar ? null : _buatBilahBawah(),
      ),
    );
  }

  // Bilah Navigasi Bawah (Material 3) untuk layar sempit (< 600px)
  Widget _buatBilahBawah() {
    return NavigationBar(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: _pilihTujuan,
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: 'Beranda',
        ),
        NavigationDestination(
          icon: Icon(Icons.dashboard_outlined),
          selectedIcon: Icon(Icons.dashboard_rounded),
          label: 'Layanan',
        ),
        NavigationDestination(
          icon: BlocSelector<PengajuanCubit, List<ItemPengajuan>, int>(
            selector: (state) => state.length,
            builder: (context, count) {
              return Badge(
                label: Text('$count'),
                isLabelVisible: count > 0,
                child: const Icon(Icons.person_outline),
              );
            },
          ),
          selectedIcon: BlocSelector<PengajuanCubit, List<ItemPengajuan>, int>(
            selector: (state) => state.length,
            builder: (context, count) {
              return Badge(
                label: Text('$count'),
                isLabelVisible: count > 0,
                child: const Icon(Icons.person_rounded),
              );
            },
          ),
          label: 'Warga',
        ),
      ],
    );
  }

  // Tata letak layar lebar (>= 600px): NavigationRail di kiri + konten di kanan
  Widget _tataLetakLebar() {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: _indeksTerpilih,
          onDestinationSelected: _pilihTujuan,
          extended: true,
          leading: const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: CircleAvatar(
              radius: 24,
              child: Icon(Icons.location_city_rounded),
            ),
          ),
          destinations: [
            NavigationRailDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded),
              label: Text('Beranda'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard_rounded),
              label: Text('Layanan'),
            ),
            NavigationRailDestination(
              icon: BlocSelector<PengajuanCubit, List<ItemPengajuan>, int>(
                selector: (state) => state.length,
                builder: (context, count) {
                  return Badge(
                    label: Text('$count'),
                    isLabelVisible: count > 0,
                    child: const Icon(Icons.person_outline),
                  );
                },
              ),
              selectedIcon: BlocSelector<PengajuanCubit, List<ItemPengajuan>, int>(
                selector: (state) => state.length,
                builder: (context, count) {
                  return Badge(
                    label: Text('$count'),
                    isLabelVisible: count > 0,
                    child: const Icon(Icons.person_rounded),
                  );
                },
              ),
              label: const Text('Warga'),
            ),
          ],
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(child: _halaman[_indeksTerpilih]),
      ],
    );
  }

  // Panel Samping (NavigationDrawer)
  Widget _buatDrawer() {
    return NavigationDrawer(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: (indeks) {
        _pilihTujuan(indeks);
        Navigator.pop(context); // Tutup drawer terlebih dahulu
      },
      children: [
        const UserAccountsDrawerHeader(
          accountName: Text(
            'Falih Afnan F',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          accountEmail: Text('NIM: 707012400017 • Warga IKN'),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Colors.teal, size: 40),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 12, 16, 8),
          child: Text(
            'Layanan Utama',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: Text('Beranda'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.dashboard_outlined),
          selectedIcon: Icon(Icons.dashboard_rounded),
          label: Text('Layanan'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person_rounded),
          label: Text('Warga'),
        ),
        const Divider(indent: 28, endIndent: 28),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 8, 16, 8),
          child: Text(
            'Layanan Interaktif & Info Kota',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF475569),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.chat_bubble_outline, color: Color(0xFF1E3A8A)),
          title: const Text('Tanya Petugas (Chat)'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AppRoutes.tanyaPetugas);
          },
        ),
        ListTile(
          leading: const Icon(Icons.map_outlined, color: Color(0xFF1E3A8A)),
          title: const Text('Lokasi Kantor Layanan (Peta)'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AppRoutes.lokasiKantor);
          },
        ),
        ListTile(
          leading: const Icon(Icons.bar_chart_outlined, color: Color(0xFF1E3A8A)),
          title: const Text('Statistik Permohonan (Chart)'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AppRoutes.statistikLayanan);
          },
        ),
        const Divider(indent: 28, endIndent: 28),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 8, 16, 8),
          child: Text(
            'Pengaturan & Bantuan',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF475569),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Pengaturan Kota'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AppRoutes.pengaturanKota);
          },
        ),
        ListTile(
          leading: const Icon(Icons.info_outline_rounded),
          title: const Text('Tentang Aplikasi'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AppRoutes.tentangAplikasi);
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout_rounded, color: Colors.red),
          title: const Text('Keluar', style: TextStyle(color: Colors.red)),
          onTap: () {
            Navigator.pop(context);
            _konfirmasiKeluar();
          },
        ),
      ],
    );
  }
}
