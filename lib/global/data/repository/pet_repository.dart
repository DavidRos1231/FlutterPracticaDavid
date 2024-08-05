import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/pet_model.dart';

class PetRepository{
  final String apiUrl;
  
  PetRepository({required this.apiUrl});
  
  Future<void> createPet(PetModel pet) async{
    final response = await http.post(
      Uri.parse('$apiUrl/add_pets'),
      headers:{
        'Content-Type': 'application/json',
      },
      body: json.encode(pet.toJson()
        ..remove('id')),
    );
    if(response.statusCode != 200){
      throw Exception('Error al crear al perro');
    }
  }

  Future<List<PetModel>> getPets() async {
    final response = await http.get(
      Uri.parse('$apiUrl/getPets'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      }
    );
    if(response.statusCode != 200){
      throw Exception('Error al crear al perro');
    }else{

      print(response.body);
      final responseJson=json.decode(response.body);
      
      if(responseJson is Map && responseJson.containsKey('pets')){
        final petJson = responseJson['pets'] as List;
        return petJson.map((pet)=> PetModel.fromJson(pet)).toList();
      }else{
        throw Exception('Formato inadecuado');
      }
    }
  }
  
  Future<void> updatePet(PetModel pet) async{
    final response = await http.put(
      Uri.parse('$apiUrl/update_pets'),
      headers: {
        'Content-Type': 'application/json',
      },
      body:json.encode(pet.toJson())
    );
    if(response.statusCode != 200){
      throw Exception('Mascota no actualizada');
    }
  }
  Future<void> deletePet(int id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/delete_pets'),
      headers: {
        'Content-Type': 'application/json',
      },
      body:json.encode({'id':id})
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el carro');
    }
  }
  
}