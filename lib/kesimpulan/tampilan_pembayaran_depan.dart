import 'package:flutter/material.dart';
import 'dart:core';

class PembayaranScreen extends StatelessWidget {
  final Map<String, dynamic> paket;
  final int selectedStudioIndex;
  final String selectedDate;
  final String selectedTime;
  final bool upfrontPaymentSelected;
  final double totalHarga;
  final String selectedBank;

  PembayaranScreen({
    required this.paket,
    required this.selectedStudioIndex,
    required this.selectedDate,
    required this.selectedTime,
    required this.upfrontPaymentSelected,
    required this.totalHarga,
    required this.selectedBank,
  });

  String generateOrderCode() {
    // Mendapatkan timestamp saat ini
    DateTime now = DateTime.now();
    // Format timestamp ke dalam bentuk string untuk digunakan dalam kode pemesanan
    String timestamp = now.millisecondsSinceEpoch.toString();

    // Membuat bagian acak untuk kode pemesanan
    String randomPart = '';
    for (int i = 0; i < 4; i++) {
      // ASCII code untuk angka 0 hingga 9 adalah 48 hingga 57
      int randomDigit = (48 + (now.microsecondsSinceEpoch % 10)).clamp(48, 57);
      randomPart += String.fromCharCode(randomDigit);
    }

    // Menggabungkan bagian timestamp dan bagian acak untuk membentuk kode pemesanan
    String orderCode = 'K${timestamp.substring(8)}$randomPart';

    return orderCode;
  }

  void main() {
    print(generateOrderCode());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kode Pemesanan',
                  style: TextStyle(color: Colors.black, fontSize: 22.0),
                ),
                Text(
                  generateOrderCode(),
                  style: TextStyle(color: Colors.black, fontSize: 24.0),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Dimohon untuk menuliskan kode ini pada keterangan transfer',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(height: 10),
            buildContainer('$selectedBank', 'Tiyo Saputra'),
            SizedBox(height: 10),
            buildContainer('$selectedBank', 'Mollery'),
            SizedBox(height: 30),
            buildRow('Total Pembayaran', 'Rp ${totalHarga.toString()}'),
            SizedBox(height: 30),
            buildRowWithIcon(Icons.timer, 'Batas Waktu Pembayaran 30 menit'),
            SizedBox(height: 30),
            buildText('Dimohon setelah melakukan pembayaran,'),
            buildText('dapat menambahkan screenshoot layar untuk verifikasi'),
            SizedBox(height: 15),
            buildTextButton('Pilih File', Icons.file_upload, Colors.white),
            SizedBox(height: 60),
            buildElevatedButton('Selesai', Color(0xFF445256)),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(String title, String subtitle) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(175, 78, 81, 81),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.house_siding_outlined, color: Colors.black),
              Text(
                title,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
          Text(
            subtitle,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget buildRow(String title, String subtitle) {
    String displayedSubtitle = subtitle;

    if (title == 'Total Pembayaran') {
      // Check if upfront payment is selected, apply 50% discount
      if (upfrontPaymentSelected) {
        displayedSubtitle = 'Rp ${(paket['harga'] / 2).toStringAsFixed(2)}';
      } else {
        displayedSubtitle = 'Rp ${paket['harga']}';
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            semanticsLabel:
                'Pembayaran Didepan\n ${upfrontPaymentSelected ? 'Rp.${(paket['harga'] / 2).toStringAsFixed(2)}' : 'Rp.${paket['harga']}'}',
            style: TextStyle(
              color: upfrontPaymentSelected ? Colors.black : Colors.black54,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Text(
          displayedSubtitle,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ],
    );
  }

  Widget buildRowWithIcon(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.black),
        Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ],
    );
  }

  Widget buildText(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.black, fontSize: 16),
    );
  }

  Widget buildTextButton(String label, IconData icon, Color iconColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: Colors.white, width: 0.2),
      ),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor),
            SizedBox(width: 10.0),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildElevatedButton(String label, Color buttonColor) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
