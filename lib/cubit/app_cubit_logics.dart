import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/cubit/app_cubit_states.dart';
import 'package:travel_app/cubit/app_cubits.dart';
import 'package:travel_app/screens/screens.dart';

class AppCubitLogics extends StatefulWidget {
  const AppCubitLogics({Key? key}) : super(key: key);

  @override
  _AppCubitLogicsState createState() => _AppCubitLogicsState();
}

class _AppCubitLogicsState extends State<AppCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state) {
          if (state is WelcomeState) {
            return const BoardingScreen();
          }if (state is DetailState) {
            return const DetailsScreen();
          }
          if (state is LoadedState){
            return const Layout();
          }
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator(),);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
