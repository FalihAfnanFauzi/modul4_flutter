import '../cubit/pengajuan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/pengajuan_model.dart';

class HalamanDetailLayanan extends StatefulWidget {
  const HalamanDetailLayanan({
    super.key,
    required this.namaLayanan,
    required this.dinas,
    required this.jamOperasional,
    required this.keterangan,
  });

  final String namaLayanan;
  final String dinas;
  final String jamOperasional;
  final String keterangan;

  @override
  State<HalamanDetailLayanan> createState() => _HalamanDetailLayananState();
}

class _HalamanDetailLayananState extends State<HalamanDetailLayanan> {
  // Palet 2-3 warna solid sederhana tanpa gradasi
  static const Color warnaUtama = Color(0xFF1E3A8A); // Deep Solid Navy
  static const Color warnaAksen = Color(0xFF475569); // Slate Grey
  static const Color warnaLatar = Color(0xFFF8FAFC); // Neutral Crisp White/Grey

  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController(text: 'Falih Afnan Fauzi');
  final _emailController = TextEditingController(text: 'falih@student.telkomuniversity.ac.id');

  String _sesiTerpilih = 'Pagi (08:00 - 11:00)';
  bool _setujuDataPribadi = false;
  bool _sedangMengirim = false;

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  bool get _isTombolAktif {
    final nama = _namaController.text.trim();
    final email = _emailController.text.trim();
    return nama.isNotEmpty && email.contains('@') && _setujuDataPribadi && !_sedangMengirim;
  }

  String _tentukanBidang(String namaLayanan) {
    final lower = namaLayanan.toLowerCase();
    if (lower.contains('kesehatan') || lower.contains('bpjs') || lower.contains('puskesmas') || lower.contains('vaksin')) {
      return 'Kesehatan';
    } else if (lower.contains('transportasi') || lower.contains('parkir') || lower.contains('rute') || lower.contains('kendaraan')) {
      return 'Transportasi';
    }
    return 'Perizinan';
  }

  Future<void> _prosesPengajuan() async {
    if (!_isTombolAktif) return;

    setState(() {
      _sedangMengirim = true;
    });

    // Simulasi pengiriman data ke server instansi publik selama 1.5 detik
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    final bidangLayanan = _tentukanBidang(widget.namaLayanan);
    final idBaru = 'REQ-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

    final pengajuanBaru = ItemPengajuan(
      id: idBaru,
      namaLengkap: _namaController.text.trim(),
      email: _emailController.text.trim(),
      jenisLayanan: widget.namaLayanan,
      bidang: bidangLayanan,
      sesiKunjungan: _sesiTerpilih,
      tanggalPengajuan: DateTime.now(),
      isSelesai: false,
    );

    context.read<PengajuanModel>().tambahPengajuan(pengajuanBaru);
    context.read<PengajuanCubit>().tambahPengajuan(pengajuanBaru);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: warnaUtama,
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Permohonan "${widget.namaLayanan}" berhasil diajukan!',
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );

    Navigator.pop(context, 'Pengajuan "${widget.namaLayanan}" berhasil diproses.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warnaLatar,
      appBar: AppBar(
        title: const Text(
          'Formulir Pengajuan Layanan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: warnaUtama,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          onChanged: () => setState(() {}),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kartu Informasi Header Layanan
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: warnaUtama,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.description, color: Colors.white, size: 26),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.namaLayanan,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0F172A)),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.dinas,
                            style: const TextStyle(fontSize: 12, color: warnaAksen),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Jam Layanan: ${widget.jamOperasional}',
                            style: const TextStyle(fontSize: 11, color: warnaUtama, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Bagian 1: Data Identitas Pemohon (TextField)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '1. Identitas Pemohon',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: warnaUtama),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Nama Lengkap Pemohon *',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _namaController,
                      style: const TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'Masukkan nama sesuai KTP',
                        prefixIcon: const Icon(Icons.person, color: warnaAksen, size: 20),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: warnaUtama, width: 1.5),
                        ),
                      ),
                      validator: (value) =>
                          (value == null || value.trim().isEmpty) ? 'Nama tidak boleh kosong' : null,
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Alamat Email Aktif *',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'contoh: nama@domain.com',
                        prefixIcon: const Icon(Icons.email, color: warnaAksen, size: 20),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: warnaUtama, width: 1.5),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || !value.contains('@')) {
                          return 'Format email harus mengandung karakter "@"';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Bagian 2: Pilihan Sesi Kunjungan (RadioListTile)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '2. Pilih Sesi Kunjungan Balai Kota',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: warnaUtama),
                    ),
                    const SizedBox(height: 8),
                    _buildRadioSesi('Pagi (08:00 - 11:00)', 'Sesi pagi untuk verifikasi dokumen fisik'),
                    _buildRadioSesi('Siang (11:00 - 14:00)', 'Sesi siang untuk konsultasi teknis'),
                    _buildRadioSesi('Sore (14:00 - 16:00)', 'Sesi sore untuk pengambilan berkas resmi'),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Bagian 3: Persetujuan Data Pribadi (Checkbox)
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
                ),
                child: CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: warnaUtama,
                  value: _setujuDataPribadi,
                  onChanged: (val) {
                    setState(() {
                      _setujuDataPribadi = val ?? false;
                    });
                  },
                  title: const Text(
                    'Pernyataan Persetujuan Data Pribadi *',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                  ),
                  subtitle: const Text(
                    'Saya menyatakan bahwa data yang diisi adalah benar dan menyetujui pemrosesan data untuk keperluan verifikasi layanan publik Kota Cerdas.',
                    style: TextStyle(fontSize: 11, color: warnaAksen),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              const SizedBox(height: 24),

              // Tombol Kirim Pengajuan (ElevatedButton dengan status loading)
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isTombolAktif ? _prosesPengajuan : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: warnaUtama,
                    disabledBackgroundColor: const Color(0xFF94A3B8),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _sedangMengirim
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Mengirim Permohonan ke Dinas...',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.send_rounded, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'Kirim Pengajuan Layanan',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioSesi(String judul, String deskripsi) {
    return RadioListTile<String>(
      contentPadding: EdgeInsets.zero,
      dense: true,
      activeColor: warnaUtama,
      title: Text(
        judul,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
      ),
      subtitle: Text(
        deskripsi,
        style: const TextStyle(fontSize: 11, color: warnaAksen),
      ),
      value: judul,
      // ignore: deprecated_member_use
      groupValue: _sesiTerpilih,
      // ignore: deprecated_member_use
      onChanged: (val) {
        if (val != null) {
          setState(() {
            _sesiTerpilih = val;
          });
        }
      },
    );
  }
}
