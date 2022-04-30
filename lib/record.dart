import 'package:flutter/material.dart';

class RecordButton extends StatefulWidget {
  const RecordButton({Key? key, required this.recordingFinishedCallback})
      : super(key: key);

  final RecordCallback recordingFinishedCallback;

  @override
  State<RecordButton> createState() => _RecordButtonState();
}

class RecordCallback {
}

class _RecordButtonState extends State<RecordButton> {
  bool _isRecording = false;



  @override
  Widget build(BuildContext context) {
    final IconData icon;
    if (_isRecording) {
      icon = Icons.stop;
    } else {
      icon = Icons.mic;
    }
    return GestureDetector(
      onTap: () {},
      child: Icon(
        icon,
        color: Colors.green,
      ),
    );
  }
}

class Record {
  stop() {}

  isRecording() {}

  start() {}

  hasPermission() {}
}

class StreamChatThema {
  static of(BuildContext context) {}
}
