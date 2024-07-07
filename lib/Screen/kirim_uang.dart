import 'package:flutter/material.dart';
import 'package:aplikasi_ewallet/api_services.dart';

class SendMoneyScreen extends StatefulWidget {
  @override
  _SendMoneyScreenState createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _sendMoney() async {
    if (_formKey.currentState!.validate()) {
      String fromUserName = 'Bagas Dribel';  // Harus diganti dengan username pengguna yang masuk
      String toUserName = _recipientController.text;
      double amount = double.tryParse(_amountController.text) ?? 0;

      if (amount <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Masukkan jumlah yang valid')),
        );
        return;
      }

      try {
        await ApiService().transferBalance(fromUserName, toUserName, amount);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pengiriman uang sebesar Rp${amount.toStringAsFixed(2)} kepada $toUserName berhasil')),
        );
        _recipientController.clear();
        _amountController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengirim uang: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kirim Uang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _recipientController,
                decoration: InputDecoration(hintText: 'Nama Pengguna Penerima'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukan Nama Pengguna Penerima!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Jumlah yang akan dikirim'),
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null) {
                    return 'Masukkan jumlah yang valid!';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _sendMoney,
                child: Text('KIRIM!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
