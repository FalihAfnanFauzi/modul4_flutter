import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/pesan_chat_model.dart';

class HalamanTanyaPetugas extends StatefulWidget {
  const HalamanTanyaPetugas({super.key});

  @override
  State<HalamanTanyaPetugas> createState() => _HalamanTanyaPetugasState();
}

class _HalamanTanyaPetugasState extends State<HalamanTanyaPetugas> {
  // Palet 2-3 warna solid tanpa gradasi
  static const Color warnaUtama = Color(0xFF1E3A8A); // Deep Solid Navy
  static const Color warnaAksen = Color(0xFF475569); // Slate Grey
  static const Color warnaLatar = Color(0xFFF8FAFC); // Neutral Crisp White/Grey

  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _kirimPesan() {
    final teks = _inputController.text.trim();
    if (teks.isEmpty) return;

    context.read<PesanChatModel>().kirimPesanWarga(teks);
    _inputController.clear();

    // Auto scroll ke bawah
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatModel = context.watch<PesanChatModel>();
    final daftarPesan = chatModel.daftarPesan;

    return Scaffold(
      backgroundColor: warnaLatar,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Tanya Petugas Layanan',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Text(
              'Online • Siap melayani warga',
              style: TextStyle(color: Color(0xFFE2E8F0), fontSize: 11),
            ),
          ],
        ),
        backgroundColor: warnaUtama,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Banner Status Pelayanan Sederhana
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.white,
            child: Row(
              children: const [
                Icon(Icons.support_agent, color: warnaUtama, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Layanan konsultasi resmi Dinas Kominfo & Pelayanan Terpadu',
                    style: TextStyle(fontSize: 12, color: warnaAksen, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          // Daftar Pesan Chat
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              itemCount: daftarPesan.length,
              itemBuilder: (context, index) {
                final pesan = daftarPesan[index];
                return _buildGelembungPesan(pesan);
              },
            ),
          ),

          // Area Input Teks & Tombol Kirim
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Tulis pertanyaan seputar layanan...',
                        hintStyle: const TextStyle(color: warnaAksen, fontSize: 13),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        fillColor: warnaLatar,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: warnaUtama, width: 1.5),
                        ),
                      ),
                      onSubmitted: (_) => _kirimPesan(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: const BoxDecoration(
                      color: warnaUtama,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                      onPressed: _kirimPesan,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGelembungPesan(PesanChat pesan) {
    final isWarga = pesan.isWarga;
    final alignment = isWarga ? Alignment.centerRight : Alignment.centerLeft;
    final warnaKotak = isWarga ? warnaUtama : Colors.white;
    final warnaTeks = isWarga ? Colors.white : const Color(0xFF0F172A);
    final borderKotak = isWarga
        ? null
        : Border.all(color: const Color(0xFFCBD5E1), width: 1);

    final waktuStr =
        '${pesan.waktu.hour.toString().padLeft(2, '0')}:${pesan.waktu.minute.toString().padLeft(2, '0')}';

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: warnaKotak,
          border: borderKotak,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(isWarga ? 12 : 2),
            bottomRight: Radius.circular(isWarga ? 2 : 12),
          ),
        ),
        child: Column(
          crossAxisAlignment: isWarga ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              isWarga ? 'Anda (Warga)' : 'Petugas Loket Cerdas',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isWarga ? const Color(0xFFE2E8F0) : warnaAksen,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              pesan.teks,
              style: TextStyle(fontSize: 13, color: warnaTeks, height: 1.3),
            ),
            const SizedBox(height: 4),
            Text(
              waktuStr,
              style: TextStyle(
                fontSize: 9,
                color: isWarga ? const Color(0xFFCBD5E1) : warnaAksen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
