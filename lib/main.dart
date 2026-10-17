import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/pengajuan_model.dart';
import 'model/pesan_chat_model.dart';
import 'navigation/app_routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PengajuanModel()),
        ChangeNotifierProvider(create: (_) => PesanChatModel()),
      ],
      child: const NusantaraCerdasApp(),
    ),
  );
}

class NusantaraCerdasApp extends StatelessWidget {
  const NusantaraCerdasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nusantara Cerdas Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Palet 2-3 warna solid: Navy, Slate, dan Putih Bersih (Tanpa Gradasi)
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A),
          primary: const Color(0xFF1E3A8A),
          secondary: const Color(0xFF475569),
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E3A8A),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      initialRoute: AppRoutes.beranda,
      routes: AppRoutes.daftarRoute(),
      onGenerateRoute: AppRoutes.bentukRoute,
      onUnknownRoute: AppRoutes.routeTidakDikenal,
    );
  }
}
