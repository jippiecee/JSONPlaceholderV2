
import 'dart:convert';
import 'package:http/http.dart' as http;

// Import semua model
import 'package:jsonplaceholder/models/albums.dart';
import 'package:jsonplaceholder/models/comments.dart';
import 'package:jsonplaceholder/models/photos.dart';
import 'package:jsonplaceholder/models/post.dart';
import 'package:jsonplaceholder/models/todos.dart';
import 'package:jsonplaceholder/models/users.dart';

class ApiService {
  static const String baseURL =
      'https://jsonplaceholder.typicode.com/';

  // 1. Endpoint Albums
  static Future<List<Albums>> fetchAlbums() async {
    final response = await http.get(
      Uri.parse('${baseURL}albums'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Albums.fromJson(e)).toList();
    } else {
      throw Exception(
        'Gagal memuat albums (HTTP ${response.statusCode})',
      );
    }
  }

  // 2. Endpoint Comments
  static Future<List<Comments>> fetchComments() async {
    final response = await http.get(
      Uri.parse('${baseURL}comments'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Comments.fromJson(e)).toList();
    } else {
      throw Exception(
        'Gagal memuat comments (HTTP ${response.statusCode})',
      );
    }
  }

  // 3. Endpoint Photos
  static Future<List<Photos>> fetchPhotos() async {
    final response = await http.get(
      Uri.parse('${baseURL}photos'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Photos.fromJson(e)).toList();
    } else {
      throw Exception(
        'Gagal memuat photos (HTTP ${response.statusCode})',
      );
    }
  }

  // 4. Endpoint Posts
  static Future<List<Post>> fetchPosts() async {
    final response = await http.get(
      Uri.parse('${baseURL}posts'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception(
        'Gagal memuat posts (HTTP ${response.statusCode})',
      );
    }
  }

  // 5. Endpoint Todos
  static Future<List<Todos>> fetchTodos() async {
    final response = await http.get(
      Uri.parse('${baseURL}todos'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Todos.fromJson(e)).toList();
    } else {
      throw Exception(
        'Gagal memuat todos (HTTP ${response.statusCode})',
      );
    }
  }

  // 6. Endpoint Users
  static Future<List<Users>> fetchUsers() async {
    final response = await http.get(
      Uri.parse('${baseURL}users'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Users.fromJson(e)).toList();
    } else {
      throw Exception(
        'Gagal memuat users (HTTP ${response.statusCode})',
      );
    }
  }
}
