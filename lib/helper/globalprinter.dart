import 'package:flutter/foundation.dart';

void printer(Object object) {
  if (kDebugMode) {
    print("===========================================");
    print(object);
    print("===========================================");
  }
}
