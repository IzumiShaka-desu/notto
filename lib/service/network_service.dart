import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:notto/model/note_model.dart';
import 'package:notto/service/sharepref_service.dart';

class NetworkService {
  var client = http.Client();

  String path = "http://192.168.43.150/notto/";
  Future<List<Notes>> getListNotes() async {
    String email =await SFService().getEmail() ?? '';
    List<Notes> notes = [];
    String url = path + "servicenote.php?email=$email";
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body) as Map;
      if (result['result'] == 1) {
        var list = result['notes'] as List;
        notes = list.map((e) => Notes.fromJson(e)).toList();
      }
    }
    return notes;
  }

  Future<bool> deleteNotes(int id) async {
    String url = path + "servicenote.php";
    var response = await client.delete(url, headers: {'id': '$id'});
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return (result['result'] == 1);
    }
    return false;
  }

  Future<bool> addNotes(String title, String notes) async {
    String email=await SFService().getEmail()??'';
    String url = path + "servicenote.php";
    var response = await client
        .post(url, body: {'title': title, 'email': email, 'notes': notes});
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return (result['result'] == 1);
    }
    return false;
  }

  Future<bool> editNotes(String title, String notes, int id) async {
    String email =await SFService().getEmail() ?? '';
    String url = path + "servicenote.php";
    var response = await client.post(url,
        body: {'title': title, 'email': email, 'notes': notes, 'id': id.toString()});
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return (result['result'] == 1);
    }
    return false;
  }

  Future registerUser(String fullname, String _email, String password) async {
    String url = path + "serviceregister.php";
    var response = await client.post(url,
        body: {'email': _email, 'fullname': fullname, 'password': password});
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body) as Map;
      return result;
    }
    return {'message': "register gagal", 'result': false};
  }

  Future loginUser(String _email, String password) async {
    String url = path + "servicelogin.php";
    var response =
        await client.post(url, body: {'email': _email, 'password': password});
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body) as Map;
      (result['result'] == 1)
          ? result['result'] = true
          : result['result'] = false;
      return result;
    }
    return {'message': "login gagal", 'result': false};
  }
}
