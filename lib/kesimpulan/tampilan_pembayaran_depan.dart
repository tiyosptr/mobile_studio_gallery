import 'package:flutter/material.dart';

void main() {
  runApp(Pembayaran());
}

class Pembayaran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PembayaranScreen(),
    );
  }
}

class PembayaranScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
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
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
                Text(
                  'K219239',
                  style: TextStyle(color: Colors.white, fontSize: 24.0),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Dimohon untuk menuliskan kode ini pada keterangan transfer',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 10),
            buildContainer('Tiyo Saputra', 'Mandiri\n10900******'),
            SizedBox(height: 10),
            buildContainer('Mollery', 'Mandiri\n10900******'),
            SizedBox(height: 10),
            buildRow('Total Pembayaran', 'Rp 100.000'),
            SizedBox(height: 10),
            buildRowWithIcon(Icons.timer, 'Batas Waktu Pembayaran 30 menit'),
            SizedBox(height: 20),
            buildText('Dimohon setelah melakukan pembayaran,'),
            buildText('dapat menambahkan screenshoot layar untuk verifikasi'),
            SizedBox(height: 5),
            buildTextButton('Pilih File', Icons.file_upload, Colors.black),
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
        color: Color(0xFF101717),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.house_siding_outlined, color: Colors.white),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          Text(
            subtitle,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget buildRow(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        Text(
          subtitle,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }

  Widget buildRowWithIcon(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }

  Widget buildText(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 16),
    );
  }

  Widget buildTextButton(String label, IconData icon, Color iconColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: Colors.black, width: 0.2),
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
                color: Colors.black,
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
