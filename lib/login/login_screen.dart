import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_bloc_app/cubit/auth_cubit.dart';
import 'package:mini_bloc_app/cubit/auth_state.dart';
import 'package:mini_bloc_app/login/verify_otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(spacing: 12, children: [
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              hintText: "Phone No",
            ),
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthCodeSendState) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VerifyOtpScreen()));
              } else if (state is AuthErrorState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
                print(
                    "Error find in Login Screen::::>>>>>${state.error.toString()}");
              }
            },
            builder: (context, state) {
              if (state is AuthLoadingState) {
                Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    String phoneNumber = _phoneController.text.trim();
                    if (phoneNumber.isNotEmpty && phoneNumber.length >= 10) {
                      // Ensure the phone number includes the country code and a `+` sign
                      String formattedPhoneNumber =
                          "+91$phoneNumber"; // Update for other countries dynamically
                      BlocProvider.of<AuthCubit>(context)
                          .sendOtp(formattedPhoneNumber);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text("Please enter a valid phone number.")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text(
                    "Send Otp",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
