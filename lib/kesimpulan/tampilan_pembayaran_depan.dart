import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:core';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_studio_gallery/pesanan/tampilan_pesanan_new.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PembayaranScreen extends StatefulWidget {
  final Map<String, dynamic> paket;
  final Map<String, dynamic> paketData;
  final Map<String, dynamic> pemesananData;
  final int selectedStudioIndex;
  final String selectedDate;
  final String selectedTime;
  final bool upfrontPaymentSelected;
  final double totalHarga;
  final String selectedBank;
  final String docId;

  PembayaranScreen({
    Key? key,
    required this.paket,
    required this.selectedStudioIndex,
    required this.selectedDate,
    required this.selectedTime,
    required this.upfrontPaymentSelected,
    required this.totalHarga,
    required this.selectedBank,
    required this.paketData,
    required this.pemesananData,
    required this.docId,
  }) : super(key: key);

  @override
  _PembayaranScreenState createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State<PembayaranScreen> {
  File? _gambar;
  String _kodePemesanan = '';

  @override
  void initState() {
    super.initState();
    // Tetapkan nilai kode pemesanan saat widget diinisialisasi
    _kodePemesanan = generateOrderCode();
    // Simpan nilai kode pemesanan di dalam widget.pemesananData
    widget.pemesananData['kodePemesanan'] = _kodePemesanan;
  }

  Future<void> _tambahDataKeFirestore() async {
    try {
      // Inisialisasi Firebase Firestore dan Firebase Storage
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      FirebaseStorage storage = FirebaseStorage.instance;

      // Menambahkan kode pemesanan
      String kodePemesanan = _kodePemesanan;
      String imageUrl = '';

      // Menyesuaikan nilai 'Metode Pembayaran' berdasarkan upfrontPaymentSelected
      String metodePembayaran =
          widget.upfrontPaymentSelected ? 'Pembayaran DP' : 'Pembayaran Lunas';

      String statusPembayaran =
          widget.upfrontPaymentSelected ? 'Belum lunas' : 'Lunas';

      // Mendapatkan timestamp saat ini
      DateTime now = DateTime.now();

      // Membuat nama dokumen berdasarkan timestamp dan widget.docId
      String documentId =
          '${DateFormat('yyyyMMdd_HHmmss').format(now)}_${widget.docId}';

      // Membuat objek untuk data pemesanan
      Map<String, dynamic> dataPemesanan = {
        'documentId': documentId,
        'kode_pemesanan': kodePemesanan,
        'nama_paket': widget.paket['nama_paket'],
        'jam': widget.selectedTime,
        'tanggal': widget.selectedDate,
        'metode_pembayaran': metodePembayaran,
        'status_pembayaran': statusPembayaran,
        'studio_dipilih': widget.selectedStudioIndex + 1,
        'harga': widget.totalHarga.toInt(),
        'rekening_pelanggan': widget.selectedBank,
        'rekening_tujuan': widget.selectedBank,
        'bukti_pembayaran': imageUrl,
        // Tambahkan data lain sesuai kebutuhan
      };

      // Tambahkan data ke Firestore
      await firestore
          .collection('Pemesanan')
          .doc(documentId)
          .set(dataPemesanan);

      // Jika ada gambar yang dipilih, unggah ke Firebase Storage
      if (_gambar != null) {
        String namaFile =
            '${widget.paket['nama_paket']}_${DateFormat('yyyyMMdd_HHmmss').format(now)}.png';

        Reference ref = storage.ref().child('/').child(namaFile);
        UploadTask uploadTask = ref.putFile(
          _gambar!,
          SettableMetadata(contentType: 'image/png'), // Set tipe file
        );

        // Menunggu hingga proses unggah selesai
        await uploadTask.whenComplete(() async {
          // Dapatkan URL gambar setelah unggah selesai
          imageUrl = await ref.getDownloadURL();
          print('ImageUrl: $imageUrl');

          // Update data di Firestore dengan URL gambar
          await firestore.collection('Pemesanan').doc(documentId).update({
            'bukti_pembayaran': imageUrl,
          });
        });
      }

      // Uncomment the following line to navigate to the next screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PesananPage2(),
        ),
      );
    } catch (error) {
      print('Error: $error');
    }
  }

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

  void _hapusGambar() {
    setState(() {
      // Set _gambar to null to remove the selected image
      _gambar = null;
    });
  }

  _pilihGambar() async {
    final picker = ImagePicker();

    // Check if another image picking process is active
    if (_gambar == null) {
      final XFile? gambar = await picker.pickImage(source: ImageSource.gallery);

      if (gambar != null) {
        setState(() {
          _gambar = File(gambar.path);
        });
        // Lakukan sesuatu dengan file gambar yang dipilih
      } else {
        // User tidak memilih gambar
      }
    } else {
      print('Another image picking process is already active.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
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
                    _kodePemesanan,
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
              buildContainer('Dari\nTiyo Saputra', '${widget.selectedBank}'),
              SizedBox(height: 10),
              buildContainer('Dari\nMollery', '${widget.selectedBank}'),
              SizedBox(height: 30),
              buildRow(
                  'Total Pembayaran', 'Rp ${widget.totalHarga.toString()}'),
              SizedBox(height: 30),
              buildText('Dimohon setelah melakukan pembayaran,'),
              buildText('dapat menambahkan screenshoot layar untuk verifikasi'),
              SizedBox(height: 15),
              _gambar == null
                  ? buildTextButton(
                      'Pilih File', Icons.file_upload, Colors.white)
                  : Container(),

              // Display selected image
              _gambar != null
                  ? Stack(
                      alignment: Alignment.topRight,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Open a dialog or navigate to a new page to show the full image
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Image.file(
                                    _gambar!,
                                    // Set the width and height based on your requirements
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    fit: BoxFit.contain,
                                  ),
                                );
                              },
                            );
                          },
                          child: Image.file(
                            _gambar!,
                            width:
                                200, // Set the width based on your requirements
                            height:
                                200, // Set the height based on your requirements
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: Icon(Icons.close, color: Colors.black),
                              onPressed: () {
                                // Call the method to remove the selected image
                                _hapusGambar();
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),

              // Tombol untuk melihat gambar
              SizedBox(height: 60),
              buildElevatedButton('Selesai', Color(0xFF445256), context),
            ],
          ),
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
      if (widget.upfrontPaymentSelected) {
        displayedSubtitle =
            'Rp ${(widget.paket['harga'] / 2).toStringAsFixed(2)}';
      } else {
        displayedSubtitle = 'Rp ${widget.paket['harga']}';
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            semanticsLabel:
                'Pembayaran Didepan\n ${widget.upfrontPaymentSelected ? 'Rp.${(widget.paket['harga'] / 2).toStringAsFixed(2)}' : 'Rp.${widget.paket['harga']}'}',
            style: TextStyle(
              color:
                  widget.upfrontPaymentSelected ? Colors.black : Colors.black54,
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
        onPressed: () {
          _pilihGambar();
        },
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

  Widget buildElevatedButton(
      String label, Color buttonColor, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to the PembayaranDP page with the required data
        _tambahDataKeFirestore(); // Panggil metode dengan tanda kurung
      },
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
