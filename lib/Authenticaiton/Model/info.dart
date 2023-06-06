import 'package:formz/formz.dart';

enum UsernameValidateError { empty }

enum PasswordValidateError { empty }

class Username extends FormzInput<String, UsernameValidateError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidateError? validator(String? value) {
    return value?.isNotEmpty == true ? null : UsernameValidateError.empty;
  }
}

class Password extends FormzInput<String, PasswordValidateError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidateError? validator(String? value) {
    return value?.isNotEmpty == true ? null : PasswordValidateError.empty;
  }
}
