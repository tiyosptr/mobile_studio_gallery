import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_studio_gallery/kesimpulan/tampilan_pembayaran_transfer.dart';

void main() {
  runApp(SelectStudio());
}

class SelectStudio extends StatefulWidget {
  @override
  _SelectStudioState createState() => _SelectStudioState();
}

class _SelectStudioState extends State<SelectStudio> {
  bool isPaymentUpfront = false;
  bool isMandiriSelected = false;
  bool isBCASelected = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
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
                Text(
                  'Kesimpulan',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(color: Colors.white70, fontSize: 18.0),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'Paket Keluarga',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Studio yang dipilih',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(color: Colors.white70, fontSize: 18.0),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 400,
                  height: 200,
                  child: Image.asset(
                    'images/studio1.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Jadwal',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '13 Desember 17.00 - 17.30',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(color: Colors.white, fontSize: 14.0),
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
                            'Pembayaran Didepan\n  Rp.100.000',
                            style: TextStyle(
                                color: isPaymentUpfront
                                    ? Colors.white
                                    : Colors.white54,
                                fontSize: 16),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Theme(
                          data: ThemeData(
                            // unselectedWidgetColor: Colors.white,
                            checkboxTheme: CheckboxThemeData(
                              fillColor: MaterialStateProperty.resolveWith(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Colors.white;
                                  }
                                  return Colors.grey;
                                },
                              ),
                            ),
                          ),
                          child: Checkbox(
                            value: isPaymentUpfront,
                            onChanged: (value) {
                              setState(() {
                                isPaymentUpfront = value!;
                              });
                            },
                            checkColor: Colors.black,
                            activeColor: Colors.white,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Transfer ke bank',
                      style: GoogleFonts.roboto(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Mandiri 10900********',
                            style: TextStyle(
                                color: isMandiriSelected
                                    ? Colors.white
                                    : Colors.white54,
                                fontSize: 16),
                          ),
                        ),
                        Theme(
                          data: ThemeData(
                            // unselectedWidgetColor: Colors.white,
                            checkboxTheme: CheckboxThemeData(
                              fillColor: MaterialStateProperty.resolveWith(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    // return Colors.white;
                                  }
                                  return Colors.grey;
                                },
                              ),
                            ),
                          ),
                          child: Checkbox(
                            value: isMandiriSelected,
                            onChanged: (value) {
                              setState(() {
                                isMandiriSelected = value!;
                              });
                            },
                            checkColor: Colors.white,
                            activeColor: Colors.blue,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                            shape: CircleBorder(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'BCA 21*********',
                            style: TextStyle(
                                color: isBCASelected
                                    ? Colors.white
                                    : Colors.white54,
                                fontSize: 16),
                          ),
                        ),
                        Theme(
                          data: ThemeData(
                            // unselectedWidgetColor: Colors.white,
                            checkboxTheme: CheckboxThemeData(
                              fillColor: MaterialStateProperty.resolveWith(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Colors.white;
                                  }
                                  return Colors.grey;
                                },
                              ),
                            ),
                          ),
                          child: Checkbox(
                            value: isBCASelected,
                            onChanged: (value) {
                              setState(() {
                                isBCASelected = value!;
                              });
                            },
                            checkColor: Colors.white,
                            activeColor: Colors.blue,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                            shape: CircleBorder(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          bottomNavigationBar: Builder(
            builder: (context) => Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PembayaranScreen()),
                  );
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
                      Text(
                        'Pesan Sekarang',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
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
