import 'package:esports_workout/Home/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/data/User.dart';

class SignUp extends StatefulWidget {
  static const String routename = 'SignUp';
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _isSignUpButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateSignUpButtonEnabled() {
    setState(() {
      _isSignUpButtonEnabled = _nameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  Future<void> _saveUserData() async {
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;

    User user = User(name, email, password);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', user.name);
    await prefs.setString('email', user.email);
    await prefs.setString('password', user.password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(248, 38, 12, 56),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              onChanged: (_) => _updateSignUpButtonEnabled(),
              decoration: const InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              onChanged: (_) => _updateSignUpButtonEnabled(),
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              onChanged: (_) => _updateSignUpButtonEnabled(),
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: _isSignUpButtonEnabled
                      ? const Color.fromARGB(248, 38, 12, 56)
                      : Colors
                          .grey, // Cambia el color del botón según la habilitación
                ),
                onPressed: _isSignUpButtonEnabled
                    ? () {
                        _saveUserData();
                        Navigator.pushNamed(context, Homepage.routename);
                      }
                    : null, // Deshabilita el botón si no todos los campos están llenos
                icon: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 30,
                ),
                label: const Text(
                  'Sign up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
