class DeniedPhonePermissionException implements Exception {
  String cause;
  DeniedPhonePermissionException(this.cause);
    @override
  String toString() {
    return cause;
  }
}

void main() {
  try {
    throwException();
  } on DeniedPhonePermissionException {
    print("custom exception has been obtained");
  }
}

throwException() {
  throw DeniedPhonePermissionException('NoInternet');
}
