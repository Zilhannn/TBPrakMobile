import 'package:flutter/material.dart';
import 'package:aplikasi_ewallet/api_services.dart';

class AddMoneyScreen extends StatefulWidget {
  @override
  _AddMoneyScreenState createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _addMoney() async {
    if (_formKey.currentState!.validate()) {
      double amount = double.parse(_amountController.text);
      try {
        await ApiService().addBalance('66730cbc8b6aebab6c5a0dd2', amount); // Ganti dengan userId yang sesuai

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Saldo Sebesar Rp.${amount.toStringAsFixed(2)} Telah Masuk ke Pesakmu! :)')),
        );

        // Reset form
        _amountController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menambah saldo: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Saldo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Ingin Tambah Saldo Berapa? :',
                style: TextStyle(fontSize: 18),
              ),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Jumlah (Contoh : 10000)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Belum Diisi Nih! Isi yang benar ya!';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Tidak Dimengerti, Masukin hanya angka ya!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addMoney,
                child: Text('Tambahin!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
