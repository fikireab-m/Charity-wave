import 'package:charitywave/screens/mapview/mapview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const CharityWaveApp());
}

class CharityWaveApp extends StatelessWidget {
  const CharityWaveApp({super.key});
  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: Size(s.width, s.height),
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CharityWave',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF2F67F1)),
            useMaterial3: true,
          ),
          home: child,
        );
      },
      child: const MapViewScreen(),
    );
  }
}
