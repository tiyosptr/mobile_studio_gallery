import 'package:flutter/material.dart';

final List<String> studioImages = [
  'images/studio1.png',
  'images/studio2.png',
  'images/studio3.png',
  'images/studio4.png',
];

class DetailHargaPage extends StatefulWidget {
  final Map<String, dynamic> paket;

  DetailHargaPage({required this.paket});

  @override
  _DetailHargaPageState createState() => _DetailHargaPageState();
}

class _DetailHargaPageState extends State<DetailHargaPage> {
  int _selectedStudioIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                widget.paket['imagePath'],
                fit: BoxFit.cover,
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF101717), // Warna latar belakang #101717
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        widget.paket['title'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      SizedBox(height: 20),
                      Text(
                        widget.paket['description'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        '30 Menit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.layers,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      SizedBox(height: 20),
                      Text(
                        '2x Ganti Pakaian',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Dapat',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.folder,
                        color: Colors.white, // Ubah warna ikon menjadi putih
                      ),
                      SizedBox(width: 10),
                      SizedBox(height: 50),
                      Text(
                        'Semua Data Foto',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.picture_in_picture_sharp,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        '1 pcs 10R & Bingkai',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Text('Pilih Studio',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Daftar studio dengan opsi pemilihan
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: studioImages.asMap().entries.map((entry) {
                      final int index = entry.key;
                      final String imagePath = entry.value;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedStudioIndex = index;
                          });
                        },
                        child: Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(imagePath),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: _selectedStudioIndex == index
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  // Tampilkan teks terpilih
                  Text(
                    'Studio Terpilih: ${_selectedStudioIndex + 1}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: ElevatedButton(
          onPressed: () {
            // Tambahkan logika pemesanan di sini
            // Misalnya, Anda dapat menavigasi ke halaman pemesanan atau menampilkan dialog pemesanan.
          },
          style: ElevatedButton.styleFrom(
            primary: Color(
                0xFF445256), // Ganti warna latar belakang tombol dengan kode 445256
          ),
          child: Padding(
            padding: EdgeInsets.all(5.0),
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
    );
  }
}
