import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialseed/app/cubits/auth/auth_cubit.dart';
import 'package:socialseed/app/cubits/credential/credential_cubit.dart';

class HomeScreen extends StatefulWidget {
  final String uid;
  const HomeScreen({super.key, required this.uid});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(widget.uid)),
          ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).logout();
              },
              child: Text('Logout'))
        ],
      ),
    );
  }
}
