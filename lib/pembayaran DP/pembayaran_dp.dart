import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PembayaranDP extends StatelessWidget {
  final Map<String, dynamic> dataPemesanan;
  final Map<String, dynamic> dataPaket;
  final String namaPaket;
  final String gambar;
  final String tanggal;
  final String status_pembayaran;
  final String jam;
  final String waktu;
  final String orang;
  final int harga;
  final String ganti_pakaian;
  final String documentId; // Add this line

  PembayaranDP({
    required this.dataPemesanan,
    required this.dataPaket,
    required this.namaPaket,
    required this.gambar,
    required this.tanggal,
    required this.jam,
    required this.ganti_pakaian,
    required this.documentId,
    required this.status_pembayaran,
    required this.waktu,
    required this.orang,
    required this.harga, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Detail Pembayaran'),
        ),
        body: Stack(
          children: [
            MyStepper(
              namaPaket: namaPaket,
              gambar: gambar,
              jam: jam,
              ganti_pakaian: ganti_pakaian,
              tanggal: tanggal,
              documentId: documentId,
              status_pembayaran: status_pembayaran,
              orang: orang,
              waktu: waktu,
              harga: harga,
            ), // Pass namaPaket here
            Positioned(
              top: 0,
              left: 0,
              height: 80.0,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyStepper extends StatefulWidget {
  final String namaPaket;
  final String gambar;
  final String tanggal;
  final String jam;
  final String orang;
  final String waktu;
  final int harga;
  final String ganti_pakaian;
  final String documentId;
  final String status_pembayaran;

  MyStepper(
      {required this.namaPaket,
      required this.gambar,
      required this.tanggal,
      required this.jam,
      required this.ganti_pakaian,
      required this.documentId,
      required this.status_pembayaran,
      required this.orang,
      required this.waktu,
      required this.harga});

  @override
  _MyStepperState createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStepIndicator(1),
            _buildStepIndicator(2),
            _buildStepIndicator(3),
          ],
        ),
        SizedBox(height: 20),
        _buildStepContent(_currentStep + 1),
      ],
    );
  }

  Widget _buildStepIndicator(int step) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentStep = step - 1;
        });
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: step <= _currentStep + 1 ? Color(0xFF101717) : Colors.grey,
        ),
        child: Center(
          child: Text(
            '$step',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent(int step) {
    String _formatDateString(String dateString) {
      DateTime date = DateFormat('dd-MM-yyyy').parse(dateString);
      return DateFormat('dd MMMM yyyy').format(date);
    }

    switch (step) {
      case 1:
        return Column(
          children: [
            Text(
              'Keterangan Jadwal Pemotretan',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Jadwal Pemotretan',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              '${_formatDateString(widget.tanggal)} ${widget.jam} ',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Kamu sudah bisa melakukan pemotretan. Diharapkan untuk datang ke studio 10 menit sebelum pemotretan.',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      case 2:
        return Column(
          children: [
            Card(
              color: Color(0xFF101717),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.network(
                    widget.gambar,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.namaPaket,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              widget.status_pembayaran,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.people,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            Text(
                              widget.orang,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.timer,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            Text(
                              widget.waktu,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.local_laundry_service,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            Text(
                              widget.ganti_pakaian,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Status: ${widget.status_pembayaran}',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    )),
                Text('Rp.${widget.harga}',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            SizedBox(height: 8),
            Container(
              height: 1,
              color: Colors.black,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.status_pembayaran == 'Belum lunas'
                      ? 'Dimohon untuk melakukan pelunasan'
                      : 'Diharapkan untuk menunggu editan foto',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 150),
            ElevatedButton(
              onPressed: () {
                // Check payment status
                if (widget.status_pembayaran == 'Belum lunas') {
                  // Show alert if payment is not completed
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Peringatan'),
                        content: Text('Harap segera melakukan pelunasan.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the alert
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Proceed to the next step if payment is completed
                  setState(() {
                    _currentStep = step;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF445256),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                side: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              child: Text(
                'Status Pembayaran                      ${widget.status_pembayaran}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      case 3:
        return Column(
          children: [
            Text(
              'Selesai',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                'Data Foto Kamu',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Tambahkan logika untuk menangani tombol
                    print('Google Drive Button Pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 223, 241, 252),
                    // Warna teks tombol saat tombol tidak dalam keadaan ditekan
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          5.0), // Atur border radius sesuai keinginan
                    ),
                    fixedSize: Size(
                        350, 30), // Sesuaikan lebar dan tinggi sesuai kebutuhan
                    minimumSize: Size(0, 30), // Set minimum width and height
                  ),
                  icon: Icon(
                    CupertinoIcons.paperplane_fill,
                    color: Colors.blueAccent,
                  ),
                  label: Text(
                    'Google Drive',
                    style: GoogleFonts.roboto(
                      textStyle:
                          TextStyle(color: Colors.blueAccent, fontSize: 17.0),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Untuk mendapatkan print foto dan bingkai,\nharap hubungi admin ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        );

      default:
        return Container();
    }
  }
}
