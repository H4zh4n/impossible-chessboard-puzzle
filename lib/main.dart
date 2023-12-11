import 'package:chessboard_problem/pages/page_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chessboard puzzle',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SafeArea(child: MainPage()),
    ),
  );
}
