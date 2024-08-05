import 'package:flutter/material.dart';
import 'package:mascotas/global/data/repository/pet_repository.dart';
import 'package:mascotas/global/presentation/cubit/pet_cubit.dart';
import 'package:mascotas/global/presentation/screen/get_pets_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => PetRepository(
            apiUrl: 'https://9u4y1lisne.execute-api.us-east-1.amazonaws.com/Prod', // Reemplaza con tu URL
            //accessToken: 'your-access-token', // Reemplaza con tu token
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PetCubit>(
            create: (context) => PetCubit(
              petRepository: RepositoryProvider.of<PetRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const PetListView(), // Cambia esto para mostrar tu vista
        ),
      ),
    );
  }
}

