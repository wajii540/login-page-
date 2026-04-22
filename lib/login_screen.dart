import 'package:flutter/material.dart';
import 'package:week1_task/homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obspassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void togglepassword() {
    setState(() {
      obspassword = !obspassword;
    });
  }

  void submit() {
    if (formkey.currentState!.validate()) {
      debugPrint("Email: ${emailController.text}");
      debugPrint("Password: ${passwordController.text}");

      // Navigate to home screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Homescreen()),
      );
    }
  }

  String? Function(String?)? emailvalidator = (String? value) {
    final email = value?.trim() ?? "";
    if (email.isEmpty) return "Email us requried";
    const pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[A_Za-z]{2,}$';
    if (!RegExp(pattern).hasMatch(email)) return "Enter a valid Email";
    return null;
  };

  String? Function(String?)? passwordvalidator = (String? value) {
    final password = value?.trim() ?? "";
    if (password.isEmpty) return "Password is required";
    if (password.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login ")),
      body: Form(
        key: formkey,
        child: Container(
          padding: const EdgeInsets.only(right: 10, left: 10, top: 140),
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                validator: emailvalidator,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  label: Text("Email"),
                  hintText: "john@gmail.com",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 15),

              TextFormField(
                controller: passwordController,
                validator: passwordvalidator,
                obscureText: obspassword,
                decoration: InputDecoration(
                  label: Text("Password"),
                  hintText: "••••••••",
                  prefixIcon: Icon(Icons.lock_clock_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obspassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      togglepassword();
                    },
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 410),
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Forgot password?'),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: submit,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
