import 'package:eventsync/theme.dart';
import 'package:eventsync/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  bool isLoading = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _errorMessage;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validateInputs() {
    if (_nameController.text.trim().isEmpty) {
      setState(() => _errorMessage = 'Please enter your name');
      return false;
    }
    
    if (_emailController.text.trim().isEmpty) {
      setState(() => _errorMessage = 'Please enter your email');
      return false;
    }
    
    if (_passwordController.text.isEmpty) {
      setState(() => _errorMessage = 'Please enter a password');
      return false;
    }
    
    if (_passwordController.text.length < 6) {
      setState(() => _errorMessage = 'Password must be at least 6 characters');
      return false;
    }
    
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() => _errorMessage = 'Passwords do not match');
      return false;
    }
    
    return true;
  }

  Future<void> register() async {
  if (!_validateInputs()) return;

  setState(() {
    isLoading = true;
    _errorMessage = null;
  });

  try {
    // Create new user with Firebase Auth
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    
    // Save additional user info in Firestore
    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Update user profile
    await userCredential.user!.updateDisplayName(_nameController.text.trim());
    
    if (mounted) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful! Please log in.'))
      );
      
      // Navigate back to login page
      Navigator.pop(context);
    }
  } on FirebaseAuthException catch (e) {
    setState(() {
      // More detailed error messages based on the specific Firebase error codes
      switch (e.code) {
        case 'weak-password':
          _errorMessage = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          _errorMessage = 'An account already exists for this email.';
          break;
        case 'invalid-email':
          _errorMessage = 'Please enter a valid email address.';
          break;
        case 'operation-not-allowed':
          _errorMessage = 'Email/password accounts are not enabled.';
          break;
        case 'network-request-failed':
          _errorMessage = 'Network error. Please check your connection.';
          break;
        default:
          _errorMessage = 'Registration failed: ${e.message}';
      }
      print('Firebase Auth Error: ${e.code} - ${e.message}');
    });
  } catch (e) {
    setState(() {
      _errorMessage = 'An error occurred: $e';
      print('General Error: $e');
    });
  } finally {
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
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
                child: Text("Create an account",
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
              
              // Name field
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Full Name",
                    style: GoogleFonts.inter(
                        letterSpacing: 0.1,
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal)),
              ),
              CustomTextField(
                hintText: "John Doe",
                controller: _nameController,
                onChanged: (value) {
                  if (_errorMessage != null) setState(() => _errorMessage = null);
                },
                obscureText: false,
              ),
              const SizedBox(height: 20),
              
              // Email field
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
                  if (_errorMessage != null) setState(() => _errorMessage = null);
                },
                obscureText: false,
              ),
              const SizedBox(height: 20),
              
              // Password field
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
                  if (_errorMessage != null) setState(() => _errorMessage = null);
                },
                obscureText: true,
              ),
              const SizedBox(height: 20),
              
              // Confirm Password field
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Confirm Password",
                    style: GoogleFonts.inter(
                        letterSpacing: 0.1,
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal)),
              ),
              CustomTextField(
                suffixIcon: Icons.visibility_outlined,
                hintText: "******",
                controller: _confirmPasswordController,
                onChanged: (value) {
                  if (_errorMessage != null) setState(() => _errorMessage = null);
                },
                obscureText: true,
              ),
              const SizedBox(height: 25),
              
              // Register button
              isLoading
                  ? SpinKitFadingCircle(
                      color: btnColor,
                      size: 50.0,
                    )
                  : Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        onPressed: register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: btnColor,
                          padding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text("Register",
                            style: GoogleFonts.inter(
                                letterSpacing: 0.1,
                                color: bgWhiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.normal)),
                      ),
                    ),
              
              // Already have account section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                      style: GoogleFonts.inter(
                          letterSpacing: 0.1,
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.normal)),
                  TextButton(
                    onPressed: () {
                      // Go back to login page
                      Navigator.pop(context);
                    },
                    child: Text("Login",
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
                  "By registering, you agree to our Terms of Service and Privacy Policy",
                  style: GoogleFonts.inter(
                      letterSpacing: 0.1,
                      color: subTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.normal)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}