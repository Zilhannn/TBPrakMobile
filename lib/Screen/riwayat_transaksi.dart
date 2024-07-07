import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aplikasi_ewallet/Model/transaksi.dart';
import 'package:aplikasi_ewallet/api_services.dart';

class TransactionHistoryScreen extends StatefulWidget {
  final String userId;

  const TransactionHistoryScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _TransactionHistoryScreenState createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  late Future<List<Transaction>> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    _transactionsFuture = ApiService().getHistory(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Transaksi'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _transactionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Tidak ada riwayat transaksi."));
          } else {
            final transactions = snapshot.data!;
            return ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return ListTile(
                  leading: Icon(
                    transaction.type == 'Keluar' ? Icons.arrow_upward : Icons.arrow_downward,
                    color: transaction.type == 'Keluar' ? Colors.red : Colors.green,
                  ),
                  title: Text('${transaction.type} Rp.${transaction.amount.toStringAsFixed(2)}'),
                  subtitle: Text(DateFormat.yMMMd().format(transaction.date)),
                  trailing: Text('No ID Transaksi: ${transaction.id}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
