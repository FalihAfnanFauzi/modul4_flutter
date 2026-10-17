import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HalamanLokasiKantor extends StatefulWidget {
  const HalamanLokasiKantor({super.key});

  @override
  State<HalamanLokasiKantor> createState() => _HalamanLokasiKantorState();
}

class _HalamanLokasiKantorState extends State<HalamanLokasiKantor> {
  // Warna solid sesuai instruksi: maksimal 2-3 warna tanpa gradasi
  static const Color warnaUtama = Color(0xFF1E3A8A); // Deep Solid Navy
  static const Color warnaAksen = Color(0xFF475569); // Slate Grey
  static const Color warnaLatar = Color(0xFFF8FAFC); // Neutral Crisp Grey

  static const LatLng posisiAwal = LatLng(-6.914744, 107.609810);

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('kantor_pusat'),
      position: LatLng(-6.914744, 107.609810),
      infoWindow: InfoWindow(
        title: 'Kantor Balai Kota Nusantara Cerdas',
        snippet: 'Jl. Merdeka No. 1 - Pusat Layanan Terpadu',
      ),
    ),
    const Marker(
      markerId: MarkerId('kantor_barat'),
      position: LatLng(-6.90389, 107.57321),
      infoWindow: InfoWindow(
        title: 'Kantor Pelayanan Terpadu Barat',
        snippet: 'Jl. Surya No. 45 - Layanan Perizinan & KTP',
      ),
    ),
    const Marker(
      markerId: MarkerId('kantor_timur'),
      position: LatLng(-6.92150, 107.63580),
      infoWindow: InfoWindow(
        title: 'Kantor Layanan Inovasi Timur',
        snippet: 'Jl. Khatulistiwa No. 12 - Transportasi & Kesehatan',
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warnaLatar,
      appBar: AppBar(
        title: const Text(
          'Lokasi Kantor Layanan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: warnaUtama,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Banner Informasi Solid Sederhana (Tanpa Gradasi)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Row(
              children: [
                const Icon(Icons.location_on, color: warnaUtama, size: 24),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Peta Sebaran 3 Kantor Pelayanan Publik',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)),
                      ),
                      Text(
                        'Ketuk penanda (marker) untuk melihat informasi alamat kantor.',
                        style: TextStyle(fontSize: 12, color: warnaAksen),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          // Area Google Map
          Expanded(
            flex: 3,
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: posisiAwal,
                zoom: 13.5,
              ),
              markers: _markers,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
            ),
          ),

          // Daftar Kartu Informasi 3 Kantor Layanan
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  const Text(
                    'Daftar Lokasi Kantor',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: warnaUtama),
                  ),
                  const SizedBox(height: 8),
                  _buildKantorTile(
                    'Kantor Balai Kota Cerdas',
                    'Jl. Merdeka No. 1 - Jam Layanan: 08:00 - 16:00',
                    Icons.account_balance,
                  ),
                  _buildKantorTile(
                    'Kantor Pelayanan Terpadu Barat',
                    'Jl. Surya No. 45 - Jam Layanan: 08:30 - 15:30',
                    Icons.business,
                  ),
                  _buildKantorTile(
                    'Kantor Layanan Inovasi Timur',
                    'Jl. Khatulistiwa No. 12 - Jam Layanan: 08:00 - 16:00',
                    Icons.local_shipping,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKantorTile(String nama, String alamat, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: warnaLatar,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: warnaUtama,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0F172A)),
                ),
                const SizedBox(height: 2),
                Text(
                  alamat,
                  style: const TextStyle(fontSize: 11, color: warnaAksen),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
