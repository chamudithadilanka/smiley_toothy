import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiley_toothy/screens/loading_screen/bloc_loading_screen/loading_bloc.dart';
import 'package:smiley_toothy/screens/splash_screen/dart/splash_screen.dart';

void main() {

  return runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => LoadingBloc()),
            // Add other blocs here if needed
          ],
          child: const MyApp(),));
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
      home: BlocProvider(create: (_) => LoadingBloc(), child: SplashScreen()),
    );
  }
}
