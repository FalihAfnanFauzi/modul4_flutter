import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'cubit/favorit_cubit.dart';
import 'cubit/pengajuan_cubit.dart';
import 'cubit/theme_cubit.dart';
import 'model/pengajuan_model.dart';
import 'model/pesan_chat_model.dart';
import 'navigation/app_routes.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PengajuanModel()),
        ChangeNotifierProvider(create: (_) => PesanChatModel()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => FavoritCubit()),
          BlocProvider(create: (_) => PengajuanCubit()),
          BlocProvider(create: (_) => ThemeCubit()),
        ],
        child: const NusantaraCerdasApp(),
      ),
    ),
  );
}

class NusantaraCerdasApp extends StatelessWidget {
  const NusantaraCerdasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          title: 'Nusantara Cerdas Mobile',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          initialRoute: AppRoutes.beranda,
          routes: AppRoutes.daftarRoute(),
          onGenerateRoute: AppRoutes.bentukRoute,
          onUnknownRoute: AppRoutes.routeTidakDikenal,
        );
      },
    );
  }
}
