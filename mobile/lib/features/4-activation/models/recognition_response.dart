// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mrz_parser/mrz_parser.dart';

class RecognitionResponse {
  final String imgPath;
  final String recognizedText;
  final String mrz;
  final MRZResult? mrzResult;

  RecognitionResponse({
    required this.imgPath,
    required this.recognizedText,
    required this.mrz,
    this.mrzResult,
  });

  @override
  bool operator ==(covariant RecognitionResponse other) {
    if (identical(this, other)) return true;

    return other.imgPath == imgPath && other.recognizedText == recognizedText;
  }

  @override
  int get hashCode => imgPath.hashCode ^ recognizedText.hashCode;
}
