import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String get apiVapiKey => dotenv.env['Vapi_Api_Key'] ?? '';
  static String get assistantKey => dotenv.env['Assistant_Key'] ?? '';
}
