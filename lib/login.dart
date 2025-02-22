import 'package:eventsync/main.dart';
import 'package:eventsync/theme.dart';
import 'package:eventsync/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  bool isLoading = false;

  void login() async {
    setState(() {
      isLoading = true;
    });

    // Simulate a delay for authentication (e.g., API call)
    await Future.delayed(Duration(seconds: 3));

    setState(() {
      isLoading = false;
    });

    // Navigate to dashboard and remove the back button
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
      (route) => false, // This removes all previous routes from the stack
    );
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
                onChanged: (value) {
                  print("Email entered: $value");
                },
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
                onChanged: (value) {
                  print("Password entered: $value");
                },
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Add your forgot password logic here
                  },
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
                    onPressed: () {},
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
