import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class ScreenRecoderController extends ChangeNotifier {
  bool _isRecorded = false;
  StringBuffer _buffer = StringBuffer();
  late Process? _process;
  final _controller = StreamController<String>();
  late int _pid;

  bool get isRecorded => _isRecorded;
  get buffer => _buffer;
  Stream<String> get ffmpegStream => _controller.stream;

  set isRecorded(bool value) {
    isRecorded = value;
    notifyListeners();
  }

  // Stream<String>
  void startStream() {
    const filepath = '/home/naveen/Desktop/dev/flutterDev/odeon/screencast.sh';
    final filename =
        '/home/naveen/odeon/output_${DateTime.now().toString()}.mkv';
    // if (_isRecorded == false) {
    Process.start('ffmpeg', [
      '-y',
      '-f',
      'x11grab',
      '-s',
      '1366x768',
      '-i',
      ':0.0',
      '-f',
      'alsa',
      '-i',
      'default',
      '-c:v',
      'libx264',
      '-r',
      '30',
      '-c:a',
      'flac',
      filename
    ]).then((process) {
      process.stderr
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .forEach((line) {
        _controller.add(line);
        _buffer.write(line + '\n');
      });
      process.stdout
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .forEach((line) {
        _controller.add(line);
        _buffer.write(line + '\n');
      });
      process.exitCode.then((value) {
        _controller.close();
        _isRecorded = true;
        notifyListeners();
      });

      _process = process;
      _pid = process.pid;
      notifyListeners();
    });
    // }
    // return _controller.stream;

    // Future.delayed(const Duration(seconds: 20), _buffer.clear);
  }

  stopStream() {
    // _process!.kill();
    print(_pid);
    Process.killPid(_pid);
    // _controller.close();
    _isRecorded = true;
    notifyListeners();
  }
}
