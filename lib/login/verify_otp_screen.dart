import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_bloc_app/cubit/auth_state.dart';
import '../cubit/auth_cubit.dart';
import '../home_screen.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController _oTPController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify OTP"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(spacing: 12, children: [
          TextField(
            controller: _oTPController,
            decoration: InputDecoration(hintText: "6 digit OTP"),
          ),
          BlocConsumer(
            listener: (context, state) {
              if (state is AuthLoggedInState) {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              } else if (state is AuthErrorState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
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
                  BlocProvider.of<AuthCubit>(context).verifyOtp(_oTPController.text);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text(
                    "Verify Otp",
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
