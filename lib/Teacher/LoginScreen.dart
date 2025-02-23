// import 'package:flutter/material.dart';
// import 'package:edu_mate/Teacher/SelectClass.dart';
// import 'package:edu_mate/service/database.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final DatabaseMethods _databaseMethods = DatabaseMethods();
//   bool _isLoading = false;

//   void _login() async {
//     setState(() => _isLoading = true);

//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();

//     var user = await _databaseMethods.loginTeacher(email, password);

//     if (user != null) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => Selectclass()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Invalid credentials. Try again.")),
//       );
//     }

//     setState(() => _isLoading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFF2C2C88), Color(0xFF0B0B22)],
//                 stops: [0.17, 0.4],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//           Center(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Image.asset('assets/images/AppLogo.png', height: 70),
//                 const SizedBox(height: 10),
//                 const Text(
//                   'EduMate',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 50),
//                 Container(
//                   height: 480,
//                   width: MediaQuery.of(context).size.width * 0.85,
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Color(0xFF28313F).withOpacity(0.4),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Text(
//                         'Login',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 50),
//                       TextField(
//                         controller: _emailController,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Color(0xFF28313F),
//                           hintText: 'Teacher Email',
//                           hintStyle: TextStyle(color: Colors.white70),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide.none,
//                           ),
//                           contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                         ),
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       const SizedBox(height: 50),
//                       TextField(
//                         controller: _passwordController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Color(0xFF28313F),
//                           hintText: 'Password',
//                           hintStyle: TextStyle(color: Colors.white70),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide.none,
//                           ),
//                           contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                         ),
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       const SizedBox(height: 10),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: TextButton(
//                           onPressed: () {},
//                           child: const Text(
//                             'Forgot password?',
//                             style: TextStyle(color: Colors.white70),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 80),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: _isLoading ? null : _login,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xFF3A2AE0),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             padding: EdgeInsets.symmetric(vertical: 12),
//                           ),
//                           child: _isLoading
//                               ? CircularProgressIndicator(color: Colors.white)
//                               : const Text(
//                                   'Login',
//                                   style: TextStyle(color: Colors.white, fontSize: 16),
//                                 ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 90),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
