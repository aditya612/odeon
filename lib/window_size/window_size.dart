import 'dart:io';
import 'dart:ui';
import 'package:window_size/window_size.dart';

void setWindowProperties() {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle(
        'Odeon: a flutter frontend for wrapper of ffmpeg for screencast');
    // setWindowMinSize(const Size(700, 500));
    setWindowMaxSize(const Size(692, 580));
    // setWindowMaxSize(Size.infinite);
  }
}
