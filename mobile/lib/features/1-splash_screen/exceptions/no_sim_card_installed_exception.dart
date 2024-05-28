class NoSimCardInstalledException implements Exception {
  String cause;
  NoSimCardInstalledException(this.cause);

  @override
  String toString() {
    return cause;
  }
}

void main() {
  try {
    throwException();
  } on NoSimCardInstalledException {
    print("custom exception has been obtained");
  }
}

throwException() {
  throw NoSimCardInstalledException('NoInternet');
}