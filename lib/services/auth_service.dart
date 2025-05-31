import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<AuthResponse> signUp(String email, String password) async {
  final response = await _client.auth.signUp(email: email, password: password);

  final userId = response.user?.id;
  if (userId != null) {
    await _client.from('profiles').insert({
      'id': userId,
      'email': email,
      'username': email.split('@')[0],
    });
  }

  return response;
}


  Future<AuthResponse> signIn(String email, String password) {
    return _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Session? get currentSession => _client.auth.currentSession;
}
