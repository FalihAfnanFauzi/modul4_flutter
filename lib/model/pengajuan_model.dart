import 'package:flutter/foundation.dart';

class ItemPengajuan {
  final String id;
  final String namaLengkap;
  final String email;
  final String jenisLayanan;
  final String bidang;
  final String sesiKunjungan;
  final DateTime tanggalPengajuan;
  bool isSelesai;

  ItemPengajuan({
    required this.id,
    required this.namaLengkap,
    required this.email,
    required this.jenisLayanan,
    required this.bidang,
    required this.sesiKunjungan,
    required this.tanggalPengajuan,
    this.isSelesai = false,
  });
}

class PengajuanModel extends ChangeNotifier {
  final List<ItemPengajuan> _daftarPengajuan = [
    ItemPengajuan(
      id: 'REQ-2026-001',
      namaLengkap: 'Falih Afnan Fauzi',
      email: 'falih@student.telkomuniversity.ac.id',
      jenisLayanan: 'Surat Keterangan Domisili Usaha',
      bidang: 'Perizinan',
      sesiKunjungan: 'Pagi (08:00 - 11:00)',
      tanggalPengajuan: DateTime.now().subtract(const Duration(days: 2)),
      isSelesai: true,
    ),
    ItemPengajuan(
      id: 'REQ-2026-002',
      namaLengkap: 'Budi Santoso',
      email: 'budi.santoso@gmail.com',
      jenisLayanan: 'Pendaftaran Fasilitas Kesehatan BPJS',
      bidang: 'Kesehatan',
      sesiKunjungan: 'Siang (11:00 - 14:00)',
      tanggalPengajuan: DateTime.now().subtract(const Duration(days: 1)),
      isSelesai: false,
    ),
    ItemPengajuan(
      id: 'REQ-2026-003',
      namaLengkap: 'Siti Rahmawati',
      email: 'siti.rahma@gmail.com',
      jenisLayanan: 'Kartu Parkir Langganan Cerdas',
      bidang: 'Transportasi',
      sesiKunjungan: 'Sore (14:00 - 16:00)',
      tanggalPengajuan: DateTime.now().subtract(const Duration(hours: 4)),
      isSelesai: false,
    ),
    ItemPengajuan(
      id: 'REQ-2026-004',
      namaLengkap: 'Ahmad Fauzan',
      email: 'ahmad.f@gmail.com',
      jenisLayanan: 'Izin Reklame & Usaha Mikro',
      bidang: 'Perizinan',
      sesiKunjungan: 'Pagi (08:00 - 11:00)',
      tanggalPengajuan: DateTime.now().subtract(const Duration(hours: 2)),
      isSelesai: true,
    ),
  ];

  List<ItemPengajuan> get daftarPengajuan => List.unmodifiable(_daftarPengajuan);

  int get totalPengajuan => _daftarPengajuan.length;

  int get totalSelesai => _daftarPengajuan.where((p) => p.isSelesai).length;

  int get totalDiproses => _daftarPengajuan.where((p) => !p.isSelesai).length;

  int jumlahPerBidang(String bidang) =>
      _daftarPengajuan.where((p) => p.bidang.toLowerCase() == bidang.toLowerCase()).length;

  void tambahPengajuan(ItemPengajuan pengajuan) {
    _daftarPengajuan.insert(0, pengajuan);
    notifyListeners();
  }

  void tandaiSelesai(String id) {
    final index = _daftarPengajuan.indexWhere((p) => p.id == id);
    if (index != -1) {
      _daftarPengajuan[index].isSelesai = true;
      notifyListeners();
    }
  }

  void hapusPengajuan(String id) {
    _daftarPengajuan.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
