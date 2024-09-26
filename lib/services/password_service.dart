class PasswordService {
  static bool isStrongPassword(String password) {
    // Verifica se a senha tem pelo menos 8 caracteres
    if (password.length < 8) return false;

    // Verifica se contém pelo menos 1 número
    bool hasNumber = password.contains(RegExp(r'\d'));

    // Verifica se contém pelo menos 1 caractere especial
    bool hasSpecialCharacter = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    // Verifica se contém pelo menos 1 letra
    bool hasLetter = password.contains(RegExp(r'[a-zA-Z]'));

    // Retorna true se todos os critérios forem atendidos
    return hasNumber && hasSpecialCharacter && hasLetter;
  }
}
