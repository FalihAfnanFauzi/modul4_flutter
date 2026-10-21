import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/pengajuan_model.dart';

class PengajuanCubit extends Cubit<List<ItemPengajuan>> {
  PengajuanCubit()
      : super([
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
        ]);

  void tambahPengajuan(ItemPengajuan pengajuan) {
    emit([...state, pengajuan]);
  }

  int get totalPengajuan => state.length;
}
