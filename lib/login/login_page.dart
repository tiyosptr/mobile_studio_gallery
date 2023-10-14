import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_studio_gallery/login/tampilan_awal.dart';
import 'package:mobile_studio_gallery/login/tampilan_pendaftaran2.dart';
import 'package:mobile_studio_gallery/menu/tampilan_utama.dart';
import 'package:mobile_studio_gallery/utils/showSnackbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
  'email',
  'https://www.googleapis.com/auth/contacs.readonly'
]);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MasukPage());
}

class MasukPage extends StatelessWidget {
  const MasukPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late GoogleSignInAccount currentUser;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //signUplogic start
  Future<void> signUp() async {
    final auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }
  //signUplogic eend

  Future<void> signInWithEmailAndPassword() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      // Jika email atau kata sandi kosong, tampilkan pesan kesalahan.
      setState(() {
        _showError = true;
      });
      return;
    }

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        // Jika berhasil login, Anda dapat mengarahkan pengguna ke halaman berikutnya atau melakukan tindakan lainnya.
        print('User berhasil login');
        showSnackBar(context, "Login berhasil");
        // Arahkan pengguna ke halaman utama.
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
        // Membersihkan pesan kesalahan jika ada.
        setState(() {
          _showError = false;
        });
      } else {
        // Jika userCredential.user null, maka login gagal.
        setState(() {
          _showError = true;
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _showError = true;
      });
      print(e.message);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  bool _showError = false;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return Awal(); // Gantilah dengan halaman kedua yang ingin Anda tampilkan
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = Offset(
                                    7.0, 0.0); // Mulai dari kanan ke kiri
                                const end =
                                    Offset.zero; // Berakhir di posisi awal
                                const curve =
                                    Curves.easeOutCubic; // Kurva animasi
                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child, // Halaman yang akan ditampilkan
                                );
                              },
                            ),
                          );
                        })
                  ],
                ),
                Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                      const SizedBox(
                        height: 5.0,
                      ),
                      const Text(
                        'Masuk',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 50.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Nama Pengguna',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30.0), // Tambahkan jarak di sini
                          SizedBox(
                            width: 356.0,
                            height: 45.0,
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Masukkan Nama Pengguna',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0), // Tambahkan jarak di sini
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Kata Sandi',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ), // Tambahkan jarak di sini
                          SizedBox(
                            width: 356.0,
                            height: 45.0,
                            child: TextField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Masukkan Kata Sandi',
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              obscureText: !_isPasswordVisible,
                            ),
                          ),
                        ],
                      ),
                      // Tambahkan jarak vertikal antara input Kata Sandi dan tombol "Sign In with Google"
                      // Pesan error jika user salah dalam melakukan input data start
                      if (_showError)
                        const Text(
                          'Email dan kata sandi harus diisi atau salah.',
                          style: TextStyle(
                            color: Colors.red, // Warna teks kesalahan.
                          ),
                        ),
                      // Pesan error jika user salah dalam melakukan input data start end
                      Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 30.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              await signInWithGoogle();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(200.0),
                                ),
                              ),
                            ),
                            child: SizedBox(
                              height: 45.0,
                              width: double.infinity,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'images/google.jpg',
                                      height: 24,
                                      width: 24,
                                    ),
                                    SizedBox(width: 10.0),
                                    Text(
                                      'Sign In with Google',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                    ])),
                     Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50.0), // Tambahkan spasi di sini
                  Text(
                    "Belum punya akun? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return RegistrationPage2(); // Gantilah dengan halaman yang ingin Anda tampilkan saat daftar
                          },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin =
                                Offset(7.0, 0.0); // Mulai dari kanan ke kiri
                            const end = Offset.zero; // Berakhir di posisi awal
                            const curve = Curves.easeOutCubic; // Kurva animasi
                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);
                            return SlideTransition(
                              position: offsetAnimation,
                              child:
                                  child, // Halaman yang akan ditampilkan saat daftar
                            );
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Daftar",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15.0,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
                // logout start
                ElevatedButton(
                  onPressed: () async {
                    await signOutFromGoogle();
                    // Panggil fungsi logout saat tombol keluar ditekan
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200.0),
                      ),
                    ),
                  ),
                  child: const SizedBox(
                    height: 45.0,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ), //logout end
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 25.0, vertical: 20.0), // Mengangkat tombol sedikit
            child: ElevatedButton(
              onPressed: () async {
                await signInWithEmailAndPassword();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(200.0), // Radius sudut 8
                  ),
                ),
              ),
              child: const SizedBox(
                height: 45.0,
                width: double.infinity, // Menyusuaikan lebar layar
                child: Center(
                  child: Text(
                    'Masuk',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
