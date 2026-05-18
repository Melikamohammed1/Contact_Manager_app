import 'package:dio/dio.dart';
import '../models/contact_model.dart';

class ContactRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));

  // READ
  Future<List<Contact>> getContacts() async {
    try {
      final response = await _dio.get('/users');
      final List<dynamic> data = response.data;
      return data.map((json) => Contact.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load contacts');
    }
  }

  
  Future<Contact> createContact(Contact contact) async {
    try {
      final response = await _dio.post('/users', data: contact.toJson());
      return Contact.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create contact');
    }
  }

  
  Future<Contact> updateContact(Contact contact) async {
    try {
      final response = await _dio.put('/users/${contact.id}', data: contact.toJson());
      return Contact.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update contact');
    }
  }

  
  Future<void> deleteContact(int id) async {
    try {
      await _dio.delete('/users/$id');
    } catch (e) {
      throw Exception('Failed to delete contact');
    }
  }
}