import 'package:dio/dio.dart';
import '../models/character.dart';

class CharacterService {
  final Dio _dio = Dio();

  Future<List<Character>> fetchCharacters() async {
    final response = await _dio.get('https://hp-api.onrender.com/api/characters');
    return (response.data as List)
        .map((json) => Character.fromJson(json))
        .toList();
  }
}
