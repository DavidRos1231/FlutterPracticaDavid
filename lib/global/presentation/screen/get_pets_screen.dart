import 'package:flutter/material.dart';
import 'package:mascotas/global/data/model/pet_model.dart';
import 'package:mascotas/global/data/repository/pet_repository.dart';
import 'package:mascotas/global/presentation/cubit/pet_cubit.dart';
import 'package:mascotas/global/presentation/cubit/pet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/global/presentation/widgets/pet_form.dart';

class PetListView extends StatelessWidget{
  const PetListView({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title: const Text('Pet List'),
      ),
      body: RepositoryProvider(
        create:(context) => PetCubit(
          petRepository: RepositoryProvider.of<PetRepository>(context),
        ),
        child: const PetListScreen(),

      )
    );
  }
}

class PetListScreen extends StatelessWidget {
  const PetListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final petCubit = BlocProvider.of<PetCubit>(context);
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            petCubit.getPets();
          },
          child: const Text('Get Pets'),
        ),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return BlocProvider.value(
                  value: context.read<PetCubit>(),
                  child: PetsForm(action: "Agregar"),
                );
              },
            );
          },
          child: const Text('Add Pet'),
        ),

        BlocBuilder<PetCubit, PetState>(
          builder: (context, state) {
            if (state is PetLoading) {
              return const CircularProgressIndicator();
            } else if (state is PetSuccess) {
              final pets = state.pet;
              return Expanded(
                child: ListView.builder(
                  itemCount: pets.length,
                  itemBuilder: (context, index) {
                    final pet = pets[index];
                    return ListTile(
                      title: Text('Nombre: ${pet.nombre}, Tipo: ${pet.tipo}'),
                      subtitle: Text('Vacunado : ${pet.vacunado==1?true:false}, - Edad: ${pet.edad}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BlocProvider.value(
                                      value: context.read<PetCubit>(),
                                      child: PetsForm(pet: pet,action: "Editar"),
                                    );
                                  },
                                );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirmar Eliminación'),
                                    content: const Text('¿Estás seguro de que quieres eliminar esta mascota?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          petCubit.deletePet(pet.id);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Eliminar'),
                                      ),
                                    ],
                                  );
                                },
                                //ds
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            } else if (state is PetError) {
              return Text(state.message);
            } else {
              return const Center(child: Text('Presiona el botón para obtener las mascotas'));
            }
          },
        ),
      ],
    );
  }
}



