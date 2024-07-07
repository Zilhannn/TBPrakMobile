import 'package:flutter/material.dart';
import 'package:aplikasi_ewallet/Screen/tambah_uang.dart';
import 'package:aplikasi_ewallet/Screen/kirim_uang.dart';
import 'package:aplikasi_ewallet/Screen/riwayat_transaksi.dart';
import 'package:aplikasi_ewallet/Screen/informasi_pengguna.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    UserInfoScreen(),
    AddMoneyScreen(),
    SendMoneyScreen(),
    TransactionHistoryScreen(userId: '66730cbc8b6aebab6c5a0dd2'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PESAK - KU'),
        centerTitle: true,
        actions: <Widget>[
      ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Informasi Pengguna',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Tambah Saldo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send),
            label: 'Kirim Uang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat Transaksi',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
        elevation: 5.0, // Mengangkat BottomNavigationBar di atas latar belakang
        type: BottomNavigationBarType.fixed, // Mengatur tipe agar item tetap terlihat
      ),
    );
  }
}
