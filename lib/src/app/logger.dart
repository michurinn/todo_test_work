// ignore_for_file: public_member_api_docs

import 'dart:developer' as devlog;

class Logger {
  void log(String message) {
    devlog.log('LOG SPEAKING: ---  $message');
  }
}
