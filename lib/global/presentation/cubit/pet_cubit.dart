import 'package:bloc/bloc.dart';
import 'package:mascotas/global/data/model/pet_model.dart';
import 'package:mascotas/global/data/repository/pet_repository.dart';
import 'package:mascotas/global/presentation/cubit/pet_state.dart';

class PetCubit extends Cubit<PetState>{
  final PetRepository petRepository;
  PetCubit({required this.petRepository}) : super(PetInitial());

  Future<void> createPet(PetModel pet) async {
    try {
      emit(PetLoading());
      await petRepository.createPet(pet);
     final pets = await petRepository.getPets();
      emit(PetSuccess(pet: pets));
    } catch (e) {
      emit(PetError(message: e.toString()));
    }
  }

  Future<void> getPets() async {
    try {
      emit(PetLoading());
      final pets = await petRepository.getPets();
      emit(PetSuccess(pet: pets));
    } catch (e) {
      emit(PetError(message: e.toString()));
    }
  }

  Future<void> updatePet(PetModel pet) async {
    try {
      emit(PetLoading());
      await petRepository.updatePet(pet);
      final pets = await petRepository.getPets();
      emit(PetSuccess(pet: pets));
    } catch (e) {
      emit(PetError(message: e.toString()));
    }
  }

  Future<void> deletePet(int id) async {
    try {
      emit(PetLoading());
     final response = await petRepository.deletePet(id);
      final pets = await petRepository.getPets();
      emit(PetSuccess(pet: []));
    } catch (e) {
      emit(PetError(message: e.toString()));
    }
  }



}