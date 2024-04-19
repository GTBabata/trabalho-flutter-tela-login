import 'package:flutter/material.dart';
import 'package:tela_login/main.dart'; // Make sure AppColors is defined here.

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _raController = TextEditingController();
  final TextEditingController _turmaController = TextEditingController();
  String? selectedCourse;

  final List<String> courses = [
    'Engenharia de Software',
    'ADS',
    'Ciência da Computação',
    'Sistemas de Informação',
  ];

  @override
  void initState() {
    super.initState();
    selectedCourse = courses.first;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _raController.dispose();
    _turmaController.dispose();
    super.dispose();
  }

  void _trySubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
      print('Full Name: ${_fullNameController.text}');
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      print('RA: ${_raController.text}');
      print('Curso: $selectedCourse');
      print('Turma: ${_turmaController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double circleDiameter =
        MediaQuery.of(context).size.width * 2; // Adjusted to be more responsive

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
          //Form
          Positioned(
              child: Padding(
                  padding: EdgeInsets.only(top: 320),
                  child: Form(
                      child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: _fullNameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Nome completo',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) => value!.isEmpty
                                      ? 'Por favor insira seu nome completo.'
                                      : null,
                                ),
                                SizedBox(height: 16.0),
                                TextFormField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email cannot be empty'; // Check if the email is empty
                                    } else if (!RegExp(r'^\S+@\S+\.\S+$')
                                        .hasMatch(value)) {
                                      return 'Please enter a valid email address.'; // Check if the email is correctly formatted
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16.0),
                                TextFormField(
                                  controller: _passwordController,
                                  decoration: const InputDecoration(
                                    labelText: 'Senha',
                                    border: OutlineInputBorder(),
                                  ),
                                  obscureText: true,
                                  validator: (value) => value!.isEmpty
                                      ? 'Por favor, insira uma senha.'
                                      : null,
                                ),
                                SizedBox(height: 16.0),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: TextFormField(
                                        controller: _raController,
                                        decoration: const InputDecoration(
                                          labelText: 'RA',
                                          border: OutlineInputBorder(),
                                        ),
                                        validator: (value) => value!.isEmpty
                                            ? 'Por favor, insira o RA.'
                                            : null,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      flex: 2,
                                      child: DropdownButtonFormField<String>(
                                        value: selectedCourse,
                                        decoration: const InputDecoration(
                                          labelText: 'Curso',
                                          border: OutlineInputBorder(),
                                        ),
                                        onChanged: (newValue) => setState(
                                            () => selectedCourse = newValue),
                                        items: courses
                                            .map<DropdownMenuItem<String>>(
                                                (course) => DropdownMenuItem(
                                                      value: course,
                                                      child: Text(course),
                                                    ))
                                            .toList(),
                                        validator: (value) => value == null
                                            ? 'Por favor, selecione um curso.'
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.0),
                                TextFormField(
                                  controller: _turmaController,
                                  decoration: const InputDecoration(
                                    labelText: 'Turma',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) => value!.isEmpty
                                      ? 'Por favor, insira a turma.'
                                      : null,
                                ),
                                SizedBox(height: 24.0),
                                ElevatedButton(
                                  onPressed: _trySubmit,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.secondary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    minimumSize: Size.fromHeight(54),
                                  ),
                                  child: Text('Cadastrar',
                                      style: TextStyle(color: Colors.white)),
                                ),
                                SizedBox(height: 16.0),
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Já possuo cadastro, Entrar',
                                      style: TextStyle(
                                          color: AppColors.secondary)),
                                ),
                              ],
                            ),
                          ))
                    ],
                  )))
              // Login form and buttons
              )
        ],
      ),
    );
  }
}
