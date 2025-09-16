import 'package:barista_notes/core/constants/images.dart';
import 'package:barista_notes/features/pos/presentation/pages/pos_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final images = [
      AppImages.tea,
      AppImages.coffee,
      AppImages.omelette,
      AppImages.latte,
      AppImages.iceLatte,
      AppImages.cake,
      AppImages.masalla,
      AppImages.matcha,
      AppImages.shake,
    ];

    for (final assetPath in images) {
      precacheImage(AssetImage(assetPath), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          supportedLocales: const [Locale('fa', 'IR')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: const Locale('fa', 'IR'),
          builder: (context, widget) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: widget!,
            );
          },
          title: 'POS App',
          theme: ThemeData(
            fontFamily: PersianFonts.Yekan.fontFamily,
            textTheme: PersianFonts.vazirTextTheme,

            useMaterial3: true,
          ),
          home: child,
        );
      },
      child: const PosPage(),
    );
  }
}
