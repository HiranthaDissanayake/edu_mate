import 'package:edu_mate/Admin/AdminHomePage.dart';
import 'package:edu_mate/Student/Student_main_page.dart';
import 'package:edu_mate/Teacher/SelectClass.dart';
import 'package:edu_mate/Teacher/TeacherDashboard.dart';
import 'package:edu_mate/service/auth_service.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  final String role;
  const Loginscreen({required this.role, super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  bool isObscure = true;

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2C2C88), Color(0xFF0B0B22)],
                stops: [0.17, 0.4],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/AppLogo.png',
                    height: 70,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'EduMate',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    height: 500,
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: Color(0xFF28313F).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 50),
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email ';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFF28313F),
                            hintText: '${widget.role} email',
                            hintStyle: TextStyle(color: Colors.white70),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 50),
                        TextFormField(
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                          obscureText: isObscure,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                              icon: Icon(isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              color: Colors.white70,
                            ),
                            filled: isObscure,
                            fillColor: Color(0xFF28313F),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.white70),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                        const SizedBox(height: 80),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                String email = _emailController.text;
                                String password = _passwordController.text;
                                login(email, password);
                              }
                              _emailController.clear();
                              _passwordController.clear();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF3A2AE0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void login(String email, String password) async {
    AuthService authService = AuthService();

    bool? valiedUser = await authService.loginUser(email, password);
    print("valiedUser: $valiedUser");
    String? userData;
    if (valiedUser) {
      userData = await authService.getUserRole(email);
    } else {
      print("User not found");
    }
    print(userData);
    print("User Role: ${widget.role}");
    // Redirect Based on Role
    if (userData == widget.role && widget.role == "student") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => StudentMainPage()));
    } else if (userData == widget.role && widget.role == "teacher") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Selectclass(
            teacherID: password,
          ),
          ));
    } else if (userData == widget.role && widget.role == "admin") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Adminhomepage()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid Credentials")));
    }
  }
}
