import 'dart:async';

class Validator {
  final nameValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      if (name.length > 0) {
        sink.add(name);
      } else {
        sink.addError('enter Full name');
      }
    },
  );
  final emailValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (email.contains('@')) {
        sink.add(email);
      } else {
        sink.addError('enter a valid email address');
      }
    },
  );

  final passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 5)
      
      sink.add(password);
    else
      sink.addError('minimum characters is 6');
  });
  final phoneValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (phone, sink) {
      if (phone.startsWith('0') && phone.length == 10) {
        sink.add(phone);
      } else {
        sink.addError('enter a valid phone number');
      }
    },
  );
  final usernameValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
    if (username.length > 0)
      sink.add(username);
    else
      sink.addError('enter username');
  });

}