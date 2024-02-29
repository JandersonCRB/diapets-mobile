class FormValidator {
  List<String? Function(String?)> fnList = [];

  String? Function(String?)? build() {
    return (String? value) => fnList
        .map((fn) => fn(value))
        .firstWhere((element) => element != null, orElse: () => null);
  }

  FormValidator email() {
    fnList.add((String? value) {
      if (value == null || value.isEmpty) {
        return 'Este campo é obrigatório';
      }
      if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
          .hasMatch(value)) {
        return 'Email inválido';
      }
      return null;
    });
    return this;
  }

  FormValidator required() {
    fnList.add((String? value) {
      if (value == null || value.isEmpty) {
        return 'Este campo é obrigatório';
      }
      return null;
    });
    return this;
  }

  FormValidator minLength(int length) {
    fnList.add((String? value) {
      if (value == null || value.isEmpty) {
        return 'Este campo é obrigatório';
      }
      if (value.length < length) {
        return 'Mínimo de $length caracteres';
      }
      return null;
    });
    return this;
  }

  FormValidator maxLength(int length) {
    fnList.add((String? value) {
      if (value == null || value.isEmpty) {
        return 'Este campo é obrigatório';
      }
      if (value.length > length) {
        return 'Máximo de $length caracteres';
      }
      return null;
    });
    return this;
  }

  FormValidator password() {
    fnList.add((String? value) {
      if (value == null || value.isEmpty) {
        return 'Este campo é obrigatório';
      }
      if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$')
          .hasMatch(value)) {
        return 'Senha inválida';
      }
      return null;
    });
    return this;
  }
}
