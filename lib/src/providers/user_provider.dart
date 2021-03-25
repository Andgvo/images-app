import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:images_app/src/preferences/user_preferences.dart';

class UserProvider {
  
  final String _api = 'identitytoolkit.googleapis.com';
  final String _apiLevel = 'v1';
  final String _fbToken = 'AIzaSyBGBPyPYxirXlTGD1CU2s8cOfhGV9iO4bs';
  final _prefs = new UserPreferences();

  Future<Map<String, dynamic>> login(String email, String password) async{
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken' : true
    };
    final url = Uri.https(_api, '$_apiLevel/accounts:signInWithPassword', { 'key': _fbToken });
    final resp = await http.post(url, body: json.encode( authData ));
    Map<String, dynamic> decodeResp = json.decode(resp.body);

    if(decodeResp.containsKey('idToken')){
      _prefs.token = decodeResp['idToken'];
      return { 'ok': true, 'token': decodeResp['idToken'] };
    } else {
      return { 'ok': false, 'message': decodeResp['error']['message'] };
    }
  }

  Future<Map<String, dynamic>> signUp(String email, String password) async{
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken' : true
    };
    final url = Uri.https(_api, '$_apiLevel/accounts:signUp', { 'key': _fbToken });
    final resp = await http.post(url, body: json.encode( authData ));
    Map<String, dynamic> decodeResp = json.decode(resp.body);

    if(decodeResp.containsKey('idToken')){
      _prefs.token = decodeResp['idToken'];
      return { 'ok': true, 'token': decodeResp['idToken'] };
    } else {
      return { 'ok': false, 'message': decodeResp['error']['message'] };
    }

  }

}