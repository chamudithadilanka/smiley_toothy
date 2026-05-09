import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiley_toothy/screens/loading_screen/bloc_loading_screen/loading_bloc.dart';
import 'package:smiley_toothy/screens/splash_screen/dart/splash_screen.dart';
import 'package:smiley_toothy/service/hive_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ← required for Hive
  await HivService.init();                  // ← init Hive before app starts

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoadingBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Smiley Toothy",
      theme: ThemeData(
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(fontFamily: 'Poppins'),
          bodyMedium: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      // SplashScreen stays as entry point — it will navigate based on
      // HiveService.isRegistered() after splash finishes
      home: BlocProvider(
        create: (_) => LoadingBloc(),
        child: const SplashScreen(),
      ),
    );
  }
}