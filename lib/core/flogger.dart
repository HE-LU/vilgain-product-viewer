import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Wrapper over the Talker package.
/// - Supports custom log levels and colors.
/// - Supports long log messages.
/// Note: Copy paste from my template project. Just bit cleaned up.
class Flogger {
  static final talker = TalkerFlutter.init(
    logger: TalkerLogger(formatter: _LoggerFormatter()),
    settings: TalkerSettings(enabled: kDebugMode),
  );

  static final colors = {
    'httpRequest': AnsiPen()..xterm(50),
    'httpResponse': AnsiPen()..xterm(42),
    'httpError': AnsiPen()..xterm(196),
    'navigation': AnsiPen()..xterm(136),
    'verbose': AnsiPen()..xterm(242),
    'debug': AnsiPen()..xterm(46),
    'info': AnsiPen()..xterm(6),
    'warning': AnsiPen()..xterm(3),
    'error': AnsiPen()..xterm(9),
  };

  static void v(dynamic message, {Object? exception, StackTrace? stackTrace, DateTime? time}) {
    talker.logCustom(_CustomLog(
      message.toString(),
      exception: exception,
      stackTrace: stackTrace,
      pen: colors['verbose'],
      key: TalkerLogType.verbose.key,
    ));
  }

  static void d(dynamic message, {Object? exception, StackTrace? stackTrace, DateTime? time}) {
    talker.logCustom(_CustomLog(
      message.toString(),
      exception: exception,
      stackTrace: stackTrace,
      pen: colors['debug'],
      key: TalkerLogType.debug.key,
    ));
  }

  static void i(dynamic message, {Object? exception, StackTrace? stackTrace, DateTime? time}) {
    talker.logCustom(_CustomLog(
      message.toString(),
      exception: exception,
      stackTrace: stackTrace,
      pen: colors['info'],
      key: TalkerLogType.info.key,
    ));
  }

  static void w(dynamic message, {Object? exception, StackTrace? stackTrace, DateTime? time}) {
    talker.logCustom(_CustomLog(
      message.toString(),
      exception: exception,
      stackTrace: stackTrace,
      pen: colors['warning'],
      key: TalkerLogType.warning.key,
    ));
  }

  static void e(dynamic message, {Object? exception, StackTrace? stackTrace, DateTime? time}) {
    talker.logCustom(_CustomLog(
      message.toString(),
      exception: exception,
      stackTrace: stackTrace,
      pen: colors['error'],
      key: TalkerLogType.error.key,
    ));
  }

  static void navigation(dynamic message) => talker.logCustom(_CustomLog(
        message.toString(),
        pen: colors['navigation'],
        key: TalkerLogType.route.key,
      ));
}

class _CustomLog extends TalkerLog {
  _CustomLog(String super.message, {super.key, super.exception, super.stackTrace, super.pen});

  @override
  String generateTextMessage({TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return '$displayMessage$displayException$displayStackTrace';
  }
}

class _LoggerFormatter implements LoggerFormatter {
  final _maxOutputThreshold = 880;
  final _borderPens = [
    Flogger.colors['warning']?.fcolor,
    Flogger.colors['error']?.fcolor,
    Flogger.colors['httpError']?.fcolor,
    Flogger.colors['httpRequest']?.fcolor,
    Flogger.colors['httpResponse']?.fcolor,
  ];

  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    final showBorder = _borderPens.contains(details.pen.fcolor);
    final underline = ConsoleUtils.getUnderline(
      settings.maxLineWidth,
      lineSymbol: settings.lineSymbol,
      withCorner: true,
    );
    final topline = ConsoleUtils.getTopline(
      settings.maxLineWidth,
      lineSymbol: settings.lineSymbol,
      withCorner: true,
    );
    final msg = details.message?.toString() ?? '';
    final msgBorderedLines = _splitLongLines(msg, _maxOutputThreshold).split('\n').map((e) => '│ $e');
    if (!settings.enableColors) {
      return (showBorder) ? '$topline\n${msgBorderedLines.join('\n')}\n$underline' : msgBorderedLines.join('\n');
    }
    var lines = [if (showBorder) topline, ...msgBorderedLines, if (showBorder) underline];
    lines = lines.map((e) => details.pen.write(e)).toList();
    final coloredMsg = lines.join('\n');
    return coloredMsg;
  }

  static String _splitLongLines(String input, int maxLineLength) {
    List<String> lines = input.split('\n');
    List<String> outputLines = [];

    for (String line in lines) {
      if (line.length > maxLineLength) {
        // Split the line into chunks of maxLineLength
        for (int i = 0; i < line.length; i += maxLineLength) {
          int end = (i + maxLineLength < line.length) ? i + maxLineLength : line.length;
          outputLines.add(line.substring(i, end));
        }
      } else {
        outputLines.add(line);
      }
    }

    return outputLines.join('\n');
  }
}
