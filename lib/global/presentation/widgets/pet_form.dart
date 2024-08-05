import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/global/data/model/pet_model.dart';
import 'package:mascotas/global/presentation/cubit/pet_cubit.dart';

class PetsForm extends StatelessWidget {
  final String action;
  final PetModel? pet;

  PetsForm({super.key, required this.action, this.pet}) {
    if (pet != null) {
      _nombreController.text = pet!.nombre;
      _tipoController.text = pet!.tipo;
      _vacunadoController.text = pet!.vacunado.toString();
      _edadController.text = pet!.edad.toString();
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _tipoController = TextEditingController();
  final _vacunadoController = TextEditingController();
  final _edadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.pets),
          Text('$action mascota'),
        ],
      ),
      content: SizedBox(
        width: 450,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nombreController,
                      decoration: const InputDecoration(labelText: 'Nombre de la mascota'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingresa el nombre de la mascota';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _tipoController,
                            decoration: const InputDecoration(labelText: 'Tipo de mascota'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Ingresa el tipo de mascota';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _vacunadoController,
                            decoration: const InputDecoration(labelText: 'Vacunado (1: Sí, 0: No)'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Ingresa el estado de vacunación';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Ingresa un valor válido (1 o 0)';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: _edadController,
                      decoration: const InputDecoration(labelText: 'Edad de la mascota'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingresa la edad de la mascota';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Ingresa una edad válida';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(
                            'Cancelar',
                            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                          ),
                          child: Text(
                            'Guardar',
                            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              _savePet(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _savePet(BuildContext context) async {
    final nombre = _nombreController.text;
    final tipo = _tipoController.text;
    final vacunado = int.parse(_vacunadoController.text);
    final edad = int.parse(_edadController.text);

    Navigator.of(context).pop();

    if (pet == null) {
      await BlocProvider.of<PetCubit>(context).createPet(
        PetModel(// Assuming id is generated this way
          id:0,
          nombre: nombre,
          tipo: tipo,
          vacunado: vacunado,
          edad: edad,
        ),
      );
    } else {
      await BlocProvider.of<PetCubit>(context).updatePet(
        PetModel(
          id: pet!.id,
          nombre: nombre,
          tipo: tipo,
          vacunado: vacunado,
          edad: edad,
        ),
      );
    }
  }
}
