import 'package:eventsync/theme.dart';
import 'package:eventsync/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterUser extends StatelessWidget {
  const RegisterUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgWhiteColor,
      body: SingleChildScrollView(
        child: Container(
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
              const SizedBox(
                height: 10,
              ),
              Text(
                "Welcome to EventSync",
                style: GoogleFonts.inter(
                    letterSpacing: 0.1,
                    color: textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    decorationThickness: 10),
              ),
              Text(
                "Manage your events seamlessly",
                style: GoogleFonts.inter(
                    letterSpacing: 0.1,
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    decorationThickness: 10),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 2),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Create Account",
                      style: GoogleFonts.inter(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 2),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Please fill in the form to continue",
                      style: GoogleFonts.inter(
                          color: textColor,
                          fontSize: 13,
                          fontWeight: FontWeight.normal)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 2),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Full Name",
                      style: GoogleFonts.inter(
                          letterSpacing: 0.1,
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.normal)),
                ),
              ),
              CustomTextField(
                hintText: "John Doe",
                onChanged: (value) {
                  print("Email entered: $value");
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 2),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Email Address",
                      style: GoogleFonts.inter(
                          letterSpacing: 0.1,
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.normal)),
                ),
              ),
              CustomTextField(
                hintText: "example@gmail.com",
                onChanged: (value) {
                  print("Email entered: $value");
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 2),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Password",
                      style: GoogleFonts.inter(
                          letterSpacing: 0.1,
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.normal)),
                ),
              ),
              CustomTextField(
                suffixIcon: Icons.visibility_outlined,
                hintText: "Enter your password",
                onChanged: (value) {
                  print("Email entered: $value");
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: () {},
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
                    onPressed: () {},
                    child: Text("Login",
                        style: GoogleFonts.inter(
                            letterSpacing: 0.1,
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
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
