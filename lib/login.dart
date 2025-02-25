import 'package:eventsync/main.dart';
import 'package:eventsync/signup.dart';
import 'package:eventsync/theme.dart';
import 'package:eventsync/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  bool isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    setState(() {
      isLoading = true;
      _errorMessage = null;
    });

    try {
      // Firebase authentication
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      
      // Navigate to dashboard and remove the back button
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
          (route) => false, // This removes all previous routes from the stack
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'user-not-found') {
          _errorMessage = 'No user found with this email.';
        } else if (e.code == 'wrong-password') {
          _errorMessage = 'Incorrect password.';
        } else if (e.code == 'invalid-email') {
          _errorMessage = 'Invalid email address.';
        } else {
          _errorMessage = 'Login failed: ${e.message}';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void forgotPassword() async {
    if (_emailController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter your email first.';
      });
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email sent!')),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = 'Password reset failed: ${e.message}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgWhiteColor,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                    color: btnColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              const SizedBox(height: 10),
              Text(
                "EventSync",
                style: GoogleFonts.inter(
                    letterSpacing: 0.1,
                    color: textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    decorationThickness: 10),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Login to your account",
                    style: GoogleFonts.inter(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Please fill in the form to continue",
                    style: GoogleFonts.inter(
                        color: textColor,
                        fontSize: 13,
                        fontWeight: FontWeight.normal)),
              ),
              const SizedBox(height: 20),
              
              // Error message display
              if (_errorMessage != null)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: GoogleFonts.inter(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
              
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Email",
                    style: GoogleFonts.inter(
                        letterSpacing: 0.1,
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal)),
              ),
              CustomTextField(
                hintText: "example@gmail.com",
                controller: _emailController,
                onChanged: (value) {
                  // Optional: clear error message on change
                  if (_errorMessage != null) {
                    setState(() {
                      _errorMessage = null;
                    });
                  }
                },
                obscureText: false,
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Password",
                    style: GoogleFonts.inter(
                        letterSpacing: 0.1,
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal)),
              ),
              CustomTextField(
                suffixIcon: Icons.visibility_outlined,
                hintText: "******",
                controller: _passwordController,
                onChanged: (value) {
                  // Optional: clear error message on change
                  if (_errorMessage != null) {
                    setState(() {
                      _errorMessage = null;
                    });
                  }
                },
                obscureText: true,
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: forgotPassword,
                  child: Text("Forgot Password?",
                      style: GoogleFonts.inter(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.normal)),
                ),
              ),
              const SizedBox(height: 15),
              isLoading
                  ? SpinKitFadingCircle(
                      color: btnColor,
                      size: 50.0,
                    )
                  : Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: btnColor,
                          padding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text("Login",
                            style: GoogleFonts.inter(
                                letterSpacing: 0.1,
                                color: bgWhiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.normal)),
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",
                      style: GoogleFonts.inter(
                          letterSpacing: 0.1,
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.normal)),
                  TextButton(
                    onPressed: () {
                      // Navigate to registration screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserRegister()),
                      );
                    },
                    child: Text("Register",
                        style: GoogleFonts.inter(
                            letterSpacing: 0.1,
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                  textAlign: TextAlign.center,
                  "By continuing, you agree to our Terms of Service and Privacy Policy",
                  style: GoogleFonts.inter(
                      letterSpacing: 0.1,
                      color: subTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }
}

// This class is referenced but not shown in original code
// Create a basic placeholder