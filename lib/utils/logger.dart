import 'package:logger/logger.dart';

var loggerLevel = Level.debug;
Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    errorMethodCount: 5,
    lineLength: 90,
    colors: false,
    printEmojis: true,
  ),
  level: loggerLevel,
);
