import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_studio_gallery/kesimpulan/tampilan_pembayaran_depan.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SelectStudio extends StatefulWidget {
  final Map<String, dynamic> paket;
  final int selectedStudioIndex;
  final String selectedDate;
  final String selectedTime;
  final String docId;
  // Constructor with named parameters

  const SelectStudio(
      {Key? key,
      required this.paket,
      required this.selectedStudioIndex,
      required this.selectedDate,
      required this.selectedTime,
      required this.docId})
      : super(key: key);
  @override
  _SelectStudioState createState() => _SelectStudioState();
}

class _SelectStudioState extends State<SelectStudio> {
  bool isPaymentUpfront = true;
  bool isMandiriSelected = true;
  bool isBCASelected = false;
  String selectedBank = 'Mandiri\n10900********';

  @override
  void initState() {
    super.initState();
    // Set the initial value for the radio button
    selectedBank = 'Mandiri\n10900********';
  }

  void _showWarning(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _saveBookingToFirestore() async {
    // Get a reference to the Firestore collection
    CollectionReference pemesananCollection =
        FirebaseFirestore.instance.collection('Pemesanan');

    // Get the current date and time for a unique document ID
    DateTime now = DateTime.now();
    String documentId =
        '${widget.docId}_${DateFormat('yyyyMMdd_HHmmss').format(now)}';

    // Prepare data to be added to Firestore
    Map<String, dynamic> bookingData = {
      'nama_paket': widget.paket['nama_paket'],
      'jam': widget.selectedTime,
      'tanggal': widget.selectedDate,
      'studio_dipilih': 'Studio ${widget.selectedStudioIndex + 1}',
      'metode_pembayaran': isPaymentUpfront
          ? 'Pembayaran didepan/lunas'
          : 'Transfer bank', // You can customize this logic
      'status_pembayaran': isPaymentUpfront ? 'Belum lunas' : 'Lunas',
      'harga':
          isPaymentUpfront ? widget.paket['harga'] ~/ 2 : widget.paket['harga']
      // Add other attributes as needed
    };

    // Add the booking data to Firestore with a custom document ID
    await pemesananCollection.doc(documentId).set(bookingData);

    // Show an alert after successfully booking
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sukses'),
          content: Text('Berhasil Dipesan'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert
                // Navigate to the payment screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PembayaranScreen(
                      paket: widget.paket,
                      selectedStudioIndex: widget.selectedStudioIndex,
                      selectedDate: widget.selectedDate,
                      selectedTime: widget.selectedTime,
                      upfrontPaymentSelected: isPaymentUpfront,
                      totalHarga: isPaymentUpfront
                          ? widget.paket['harga'] / 2
                          : widget.paket['harga'].toDouble(),
                      selectedBank: selectedBank,
                      paketData: {},
                      pemesananData: {},
                      docId: '',
                    ),
                  ),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black87),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Text(
                    'Kesimpulan',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      widget
                          .paket['nama_paket'], // Display the selected package
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Studio yang dipilih: Studio ${widget.selectedStudioIndex + 1}', // Display the selected studio
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 400,
                    height: 200,
                    child: Image.asset(
                      'images/studio${widget.selectedStudioIndex + 1}.png', // Assuming images are named studio1.png, studio2.png, etc.
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Jadwal',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${DateFormat('dd MMMM yyyy').format(DateFormat('dd-MM-yyyy').parse(widget.selectedDate))} - ${widget.selectedTime}',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Pembayaran Didepan\n ${isPaymentUpfront ? 'Rp.${widget.paket['harga'] ~/ 2}' : 'Rp.${widget.paket['harga']}'}',
                              style: TextStyle(
                                color: isPaymentUpfront
                                    ? Colors.black
                                    : Colors.black54,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            width:
                                50.0, // Sesuaikan lebar Container sesuai kebutuhan
                            height:
                                15.0, // Sesuaikan tinggi Container sesuai kebutuhan
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              border:
                                  Border.all(color: Colors.white, width: 2.0),
                            ),
                            child: Checkbox(
                              value: isPaymentUpfront,
                              onChanged: (value) {
                                setState(() {
                                  isPaymentUpfront = value!;
                                  // Uncheck both Mandiri and BCA when Pembayaran Didepan is selected
                                });
                              },
                              checkColor: Colors.white,
                              activeColor: Colors.blue,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Transfer ke bank',
                        style: GoogleFonts.roboto(
                            textStyle:
                                TextStyle(color: Colors.black, fontSize: 19.0),
                            fontWeight: FontWeight.w700),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Mandiri\n10900********',
                              style: TextStyle(
                                color: selectedBank == 'Mandiri\n10900********'
                                    ? Colors.black
                                    : Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Radio<String>(
                            value: 'Mandiri\n10900********',
                            groupValue:
                                selectedBank, // Set the initial value here
                            onChanged: (value) {
                              setState(() {
                                selectedBank = value!;
                                // Uncheck Pembayaran Didepan when Mandiri is selected
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'BCA\n21*********',
                              style: TextStyle(
                                color: selectedBank == 'BCA\n21*********'
                                    ? Colors.black
                                    : Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Radio<String>(
                            value: 'BCA\n21*********',
                            groupValue: selectedBank,
                            onChanged: (value) {
                              setState(() {
                                selectedBank = value!;
                                // Uncheck Pembayaran Didepan when BCA is selected
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Builder(
            builder: (context) => Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  if (selectedBank.isEmpty && !isPaymentUpfront) {
                    _showWarning(
                      context,
                      'Pilih metode pembayaran terlebih dahulu.',
                    );
                  } else {
                    // Save booking details to Firestore
                    //_saveBookingToFirestore();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PembayaranScreen(
                          paket: widget.paket,
                          docId: widget.docId,
                          selectedStudioIndex: widget.selectedStudioIndex,
                          selectedDate: widget.selectedDate,
                          selectedTime: widget.selectedTime,
                          upfrontPaymentSelected: isPaymentUpfront,
                          totalHarga: isPaymentUpfront
                              ? widget.paket['harga'] / 2
                              : widget.paket['harga'].toDouble(),
                          selectedBank: selectedBank,
                          paketData: {},
                          pemesananData: {},
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF445256),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pesan Sekarang',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(
                            width: 100.0,
                          ),
                          Text(
                            '${isPaymentUpfront ? 'Rp.${widget.paket['harga'] ~/ 2}' : 'Rp.${widget.paket['harga']}'}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
