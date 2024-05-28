class DeniedLocationPermissionException implements Exception {
  String cause;
  DeniedLocationPermissionException(this.cause);
  @override
  String toString() {
    return cause;
  }
}

void main() {
  try {
    throwException();
  } on DeniedLocationPermissionException {
    print("custom exception has been obtained");
  }
}

throwException() {
  throw DeniedLocationPermissionException('NoInternet');
}
