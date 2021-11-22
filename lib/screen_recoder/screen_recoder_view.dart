import 'package:flutter/material.dart';
import 'package:odeon/screen_recoder/screen_recoder_controller.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:sized_context/sized_context.dart';

class ScreenRecoderView extends StatefulWidget {
  const ScreenRecoderView({Key? key}) : super(key: key);

  @override
  State<ScreenRecoderView> createState() => _ScreenRecoderViewState();
}

class _ScreenRecoderViewState extends State<ScreenRecoderView> {
  final ScreenRecoderController _screenRecoderController =
      ScreenRecoderController();
  late final Stream<String> _ffmpegStream;

  @override
  void initState() {
    super.initState();
    _ffmpegStream = _screenRecoderController.ffmpegStream;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
            height: context.heightPct(.25),
            child: const Text('Odeon')
                .fontSize(16)
                .bold()
                .italic()
                .textColor(Colors.pinkAccent)
                .scale(all: 2)
                .center()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                _screenRecoderController.startStream();
              },
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('Start').padding(horizontal: 8),
            ).padding(all: 8).flexible(),
            ElevatedButton.icon(
              onPressed: () {
                _screenRecoderController.stopStream();
              },
              icon: const Icon(Icons.stop_rounded),
              label: const Text('Stop').padding(horizontal: 8),
            ).padding(all: 8).flexible(),
          ],
        ).constrained(width: context.widthPct(.5)),
        SizedBox(
          height: context.heightPct(.25),
        ),
        Expanded(
          child: !_screenRecoderController.isRecorded
              ? Card(
                  child: StreamBuilder(
                    stream: _ffmpegStream,
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: _screenRecoderController.isRecorded
                            ? const Text('Finished')
                            : snapshot.hasData
                                ? Text(_screenRecoderController.buffer
                                        .toString())
                                    .scrollable()
                                : const Text('Waiting for input'),
                      );

                      // const Text('sd')
                      //     // .alignment(Alignment.topCenter)
                      //     .scrollable()
                      //     .card()
                      //     .padding(all: 8);
                      // .expanded();
                    },
                  ),
                )
              : const Text('Starting')
                  // .alignment(Alignment.topCenter)
                  .scrollable()
                  .card()
                  .padding(all: 8),
        ),
      ],
    );
  }
}
