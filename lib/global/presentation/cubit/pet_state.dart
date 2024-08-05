import 'package:equatable/equatable.dart';
import 'package:mascotas/global/data/model/pet_model.dart';

abstract class PetState extends Equatable{
  @override
  List<Object?> get props => [];

}

class PetInitial extends PetState{}

class PetLoading extends PetState{}


class PetSuccess extends PetState{
  final List<PetModel> pet;

  PetSuccess({required this.pet});

  @override
  List<Object?> get props => [pet ];

}

class PetError extends PetState{
  final String message;
  PetError({required this.message});
  @override
  List<Object> get props => [message];

}