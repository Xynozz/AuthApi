import 'dart:convert';
import 'package:http/http.dart' as http;
import '/pages/models/tag_model.dart';

class TagService {
  final String _baseUrl = 'https://movieapi.smkassalaambandung.sch.id/api';

  Future<Tag?> fetchTag() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/tag'));

      if (response.statusCode == 200) {
        return Tag.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load kategori');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<bool> storeTag(String namaTag) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/tag'),
      body: {'nama_tag': namaTag},
    );

    return response.statusCode == 201;
  }

  Future<bool> updateTag(int id, String namaTag) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/tag/$id'),
      body: {'nama_tag': namaTag},
    );

    return response.statusCode == 200;
  }

  Future<bool> deleteTag(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/tag/$id'));
    return response.statusCode == 200;
  }
}