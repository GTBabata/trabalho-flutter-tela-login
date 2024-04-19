import 'package:flutter/material.dart';
import 'package:tela_login/registrationpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

class AppColors {
  static const Color primary = Color(0xFF526B28); // Dark green color
  static const Color secondary = Color(0xFFD99609); // Gold color
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  // Email validation using regex
  bool isValidEmail(String? email) {
    final RegExp regex = RegExp(r'^\S+@\S+\.\S+$');
    return email != null && regex.hasMatch(email);
  }

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      _formKey.currentState?.save();
      // Use the email and password to login
      print('Email: $_email');
      print('Password: $_password');
      // Here you would usually send the request to your backend or authentication service
    }
  }

  @override
  Widget build(BuildContext context) {
    final double circleDiameter = MediaQuery.of(context).size.width * 2;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Background large circle and other widgets...
          // Background large circle
          Positioned(
            top: -(circleDiameter *
                0.7), // Adjust the position to move the circle upwards
            child: Container(
              width: circleDiameter,
              height: circleDiameter,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Logo image
          Positioned(
            top: MediaQuery.of(context).size.height *
                0.1, // Adjust the position as needed
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 80.0, // Radius for the white circle background
              child: Container(
                width:
                    90.0, // Define a fixed width for the logo, making it smaller than the CircleAvatar
                height: 90.0, // Define a fixed height for the logo
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                        '../assets/images/logo.png'), // Replace with your actual logo path
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            // Other Positioned code...
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, top: 100),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (!isValidEmail(value)) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                      onSaved: (value) => _email = value ?? '',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Senha',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password cannot be empty.';
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value ?? '',
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, bottom: 7),
                    child: ElevatedButton(
                      onPressed: _trySubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size.fromHeight(60),
                      ),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrationPage()),
                      );
                    },
                    child: Text(
                      'Não possui cadastro? Criar conta',
                      style: TextStyle(color: AppColors.secondary),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Login form and buttons
        ],
      ),
    );
  }
}
