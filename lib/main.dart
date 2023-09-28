import 'package:e_money/pages/detail_page.dart';
import 'package:e_money/pages/login_page.dart';
import 'package:e_money/pages/main_page.dart';
import 'package:e_money/pages/pemasukan_page.dart';
import 'package:e_money/pages/pengeluaran_page.dart';
import 'package:e_money/pages/setting_page.dart';
import 'package:e_money/shared/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFff7b00),
          secondary: const Color(0xFF000000),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        Routes.routeLogin: (context) => const Login(),
        Routes.routeMain: (context) => const Main(),
        Routes.routePengeluaran: (context) => const Pengeluaran(),
        Routes.routePemasukan: (context) => const Pemasukan(),
        Routes.routeDetail: (context) => const Detail(),
        Routes.routeSetting: (context) => const Setting(),
      },
    );
  }
}
