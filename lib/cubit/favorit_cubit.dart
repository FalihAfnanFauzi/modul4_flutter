import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritCubit extends Cubit<Set<String>> {
  FavoritCubit() : super(<String>{'Pendaftaran Izin Mendirikan Usaha (IMU)'});

  void tandai(String namaLayanan) {
    final updated = Set<String>.from(state)..add(namaLayanan);
    emit(updated);
  }

  void batalTandai(String namaLayanan) {
    final updated = Set<String>.from(state)..remove(namaLayanan);
    emit(updated);
  }

  void alihkan(String namaLayanan) {
    if (state.contains(namaLayanan)) {
      batalTandai(namaLayanan);
    } else {
      tandai(namaLayanan);
    }
  }

  bool isFavorit(String namaLayanan) => state.contains(namaLayanan);
}
