import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'Provider/add_task_provider.dart';
import 'Provider/home_provider.dart';
import 'UI/Home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => home_provider(),
        ),
        ChangeNotifierProvider(
          create: (context) => add_task_provider(),
        ),
      ],
      child: Builder(builder: (BuildContext context) {
        return ResponsiveSizer(builder: (context, orientation, screenType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: home_screen(),
          );
        });
      }),
    );
  }
}
