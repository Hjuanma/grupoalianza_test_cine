import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environmet {
  static String theMovieDbKey =
      dotenv.env["THE_MOVIEDB_KEY"] ?? "No se tiene API Key";
}
