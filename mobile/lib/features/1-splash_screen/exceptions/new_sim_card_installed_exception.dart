class NewSimCardInstalledException implements Exception {
  String cause;
  NewSimCardInstalledException(this.cause);
    @override
  String toString() {
    return cause;
  }
}

void main() {
  try {
    throwException();
  } on NewSimCardInstalledException {
    print("custom exception has been obtained");
  }
}

throwException() {
  throw NewSimCardInstalledException('NoInternet');
}
