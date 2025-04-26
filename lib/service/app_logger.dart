import 'package:logger/logger.dart';

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  final Logger _logger;

  factory AppLogger() {
    return _instance;
  }

  AppLogger._internal()
      : _logger = Logger(
          printer: PrettyPrinter(
            methodCount: 2,
            errorMethodCount: 8,
            lineLength: 120,
            colors: true,
            printEmojis: true,
            printTime: true,
          ),
        );

  void d(dynamic message) => _logger.d(message);
  void i(dynamic message) => _logger.i(message);
  void w(dynamic message) => _logger.w(message);
  void e(dynamic message) => _logger.e(message);
  void v(dynamic message) => _logger.v(message);
}
