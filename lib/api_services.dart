import 'dart:convert';
import 'package:aplikasi_ewallet/Model/transaksi.dart';
import 'package:http/http.dart' as http;
import 'package:aplikasi_ewallet/Model/pengguna.dart';

class ApiService {
  final String baseUrl = 'https://prakmobileuas-bhcdbn33mq-et.a.run.app'; // Sesuaikan dengan URL server Express.js Anda

  // Fungsi untuk mendapatkan data pengguna berdasarkan ID
  Future<User> getUserById(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/$userId'), // Sesuaikan endpoint jika berbeda
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User(
        id: data['_id'], // Sesuaikan dengan struktur JSON yang diterima
        name: data['name'],
        balance: data['balance'].toDouble(),
      );
    } else {
      throw Exception('Failed to fetch user');
    }
  }
  Future<void> addBalance(String userId, double amountToAdd) async {
    final String url = '$baseUrl/addBalance';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'userId': userId,
          'amountToAdd': amountToAdd,
        }),
      );

      if (response.statusCode == 200) {
        print('Balance updated successfully');
      } else {
        throw Exception('Failed to update balance');
      }
    } catch (error) {
      throw Exception('Failed to connect to server');
    }
  }

   Future<void> transferBalance(String fromUserName, String toUserName, double amount) async {
    final String url = '$baseUrl/transferBalance';

     try {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'fromUserName': fromUserName,  // Pastikan ini sesuai dengan yang diharapkan server
        'toUserName': toUserName,
        'amount': amount.toString(),
      }),
    );

    if (response.statusCode == 200) {
      print('Transfer successful');
    } else {
      throw Exception('Failed to transfer balance: ${response.statusCode} ${response.body}');
    }
  } catch (error) {
    throw Exception('Failed to connect to server: ${error.toString()}');
  }
}

  sendMoney(String recipient, double amount) {}


 Future<List<Transaction>> getHistory(String userId) async {
    if (userId.isEmpty) {
      throw Exception('Missing userId');
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/history/$userId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Transaction.fromJson(item)).toList();
      } else {
        var responseData = jsonDecode(response.body);
        throw Exception(responseData['message'] ?? 'Error fetching data');
      }
    } catch (e) {
      throw Exception('Internal server error: ${e.toString()}');
    }
  }
}

  


