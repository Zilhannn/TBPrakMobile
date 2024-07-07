import 'package:flutter/material.dart';
import 'package:aplikasi_ewallet/Screen/halaman_utama.dart';

void main() {
  runApp(EWalletApp());
}

class EWalletApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Wallet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
