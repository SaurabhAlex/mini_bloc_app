import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_bloc_app/cubit/auth_cubit.dart';
import 'package:mini_bloc_app/cubit/auth_state.dart';
import 'login_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Screen",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state){
                if(state is AuthLogOutState){
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }
              },
            builder: (context, state){
                return  IconButton(
                    onPressed: () {
                     BlocProvider.of<AuthCubit>(context).logOut();
                    },
                    icon: Icon(Icons.logout));
            }, ),

        ],
      ),
      body: Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
