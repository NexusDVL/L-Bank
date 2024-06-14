import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  // Método para salvar os dados do usuário
  Future<void> salvarUsuario(String nome, String email, String senha) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome', nome);
    await prefs.setString('email', email);
    await prefs.setString('senha', senha);
  }

  // Método para verificar se o usuário já está cadastrado
  Future<bool> verificarUsuarioCadastrado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email') != null;
  }

  // Método para verificar se o email e senha estão corretos
  Future<bool> autenticarUsuario(String email, String senha) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? emailSalvo = prefs.getString('email');
    String? senhaSalva = prefs.getString('senha');

    return email == emailSalvo && senha == senhaSalva;
  }
}
