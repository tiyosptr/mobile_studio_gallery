import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:mobile_studio_gallery/login/tampilan_pendaftaran1.dart';
import 'package:mobile_studio_gallery/login/tampilan_pendaftaran3.dart';
import 'package:mobile_studio_gallery/utils/privacyPolicyPage.dart';
import 'package:mobile_studio_gallery/utils/showSnackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:crypto/crypto.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Pendaftaran2());
}

class Pendaftaran2 extends StatelessWidget {
  const Pendaftaran2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegistrationPage2(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegistrationPage2 extends StatefulWidget {
  const RegistrationPage2({super.key});

  @override
  State<RegistrationPage2> createState() => _RegistrationPage();
}

class _RegistrationPage extends State<RegistrationPage2> {
  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _namaPenggunaController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ulangiPasswordController =
      TextEditingController();

  bool _isChecked = false;
  bool _isError = false;
  bool _isSuccess = false;

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            _isError ? Colors.red : (_isSuccess ? Colors.green : null),
      ),
    );
  }

  bool validateFields() {
    if (_namaLengkapController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _namaPenggunaController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _ulangiPasswordController.text.isEmpty) {
      _isError = true;
      _showSnackBar(context, "Semua kolom harus diisi");
      return false;
    } else if (!isValidEmail(_emailController.text)) {
      _isError = true;
      _showSnackBar(context, "Masukkan alamat email yang valid");
      return false;
    } else if (_passwordController.text.length < 8) {
      _isError = true;
      _showSnackBar(context, "Kata sandi harus minimal 8 karakter");
      return false;
    } else if (!passwordConfirmed()) {
      _isError = true;
      _showSnackBar(context, "Kata sandi tidak sesuai");
      return false;
    }
    return true;
  }

  bool isValidEmail(String email) {
    // General email regex pattern
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }

  @override
  void dispose() {
    _namaLengkapController.dispose();
    _emailController.dispose();
    _namaPenggunaController.dispose();
    _passwordController.dispose();
    _ulangiPasswordController.dispose();
    super.dispose();
  }

  //signUp

  Future signUp() async {
    if (passwordConfirmed()) {
      final auth = FirebaseAuth.instance;
      try {
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        String uid = userCredential.user?.uid ?? "";
        print("UID from Authentication: $uid");

        String hashedPassword = hashPassword(_passwordController.text);

        addUser(
          _namaLengkapController.text,
          _emailController.text,
          _namaPenggunaController.text,
          hashedPassword,
          uid,
        );
        _isSuccess = true;
        _showSnackBar(
          context,
          "Pendaftaran berhasil!",
        );
      } on FirebaseAuthException catch (e) {
        print("Error: $e");
        _isError = true;
        _showSnackBar(
          context,
          "Pendaftaran gagal. ${e.message}",
        );
      }
    } else {
      _showSnackBar(
        context,
        "Pastikan Anda telah menyetujui Kebijakan Privasi dan Persyaratan Layanan.",
      );
    }
  }

  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  //nyimpan userdetail
  Future addUser(String namaLengkap, String email, String namaPengguna,
      String password, String uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'nama_lengkap': namaLengkap,
      'email': email,
      'nama_pengguna': namaPengguna,
      'password': password,
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text == _ulangiPasswordController.text) {
      return true;
    } else {
      return false;
    }
  }

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

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
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegistrationPage1()));
                      },
                    ),
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
                        'Daftar',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 50.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Nama Lengkap',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          SizedBox(
                            width: 356.0,
                            height: 45.0,
                            child: TextField(
                              controller: _namaLengkapController,
                              decoration: InputDecoration(
                                labelText: 'Masukkan Nama lengkap',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
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
                          SizedBox(height: 30.0),
                          SizedBox(
                            width: 356.0,
                            height: 45.0,
                            child: TextField(
                              controller: _namaPenggunaController,
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
                      const SizedBox(height: 30.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'email',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          SizedBox(
                            width: 356.0,
                            height: 45.0,
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Masukkan email',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
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
                          const SizedBox(height: 30.0),
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
                      const SizedBox(height: 30.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Ulangi Kata Sandi',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          SizedBox(
                            width: 356.0,
                            height: 45.0,
                            child: TextField(
                              controller: _ulangiPasswordController,
                              decoration: InputDecoration(
                                labelText: 'Ulangi Kata Sandi',
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isConfirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isConfirmPasswordVisible =
                                          !_isConfirmPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              obscureText: !_isConfirmPasswordVisible,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          Checkbox(
                            value: _isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            },
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PrivacyPolicyPage()),
                              );
                            },
                            child: Text(
                              'Baca Kebijakan privasi dan persyaratan layanan',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
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
          const SizedBox(height: 10.0),
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
            child: ElevatedButton(
              onPressed: () async {
                if (_isChecked) {
                  if (validateFields()) {
                    await signUp();
                    _isError = false;
                    _isSuccess = false;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationPage3()),
                    );
                  }
                } else {
                  showSnackBar(
                    context,
                    "Anda harus menyetujui Kebijakan Privasi dan Persyaratan Layanan.",
                  );
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
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
                    'Daftar Sekarang',
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
