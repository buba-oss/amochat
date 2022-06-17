
import 'dart:core';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as jsAudio;

import 'duration.dart';



/// This is the main widget.
///
// ignore: must_be_immutable
class VoiceMessage extends StatefulWidget {
  VoiceMessage({
    Key? key,
    required this.audioSrc,
    required this.me,
    this.noiseCount = 27,
    this.meBgColor = Colors.pink,
    this.contactBgColor = const Color(0xffffffff),
    this.contactFgColor = Colors.pink,
    this.mePlayIconColor = Colors.black,
    this.contactPlayIconColor = Colors.black26,
    this.meFgColor = const Color(0xffffffff),
    this.played = false,
    this.onPlay,
  }) : super(key: key);

  final String audioSrc;
  final int noiseCount;
  final Color meBgColor,
      meFgColor,
      contactBgColor,
      contactFgColor,
      mePlayIconColor,
      contactPlayIconColor;
  final bool played, me;
  Function()? onPlay;

  get contactFgColorColor => null;

  @override
  _VoiceMessageState createState() => _VoiceMessageState();

  circle(BuildContext context, int i, param2) {}
}

class _VoiceMessageState extends State<VoiceMessage>
    with SingleTickerProviderStateMixin {
  final AudioPlayer _player = AudioPlayer();
   final  maxNoiseHeight = 6, noiseWidth = 26.5;
  Duration? _audioDuration;
  bool _isPlaying = false, x2 = false, _audioConfigurationDone = false;
  int _playingStatus = 0, duration = 00;
  String _remainingTime = '';
  AnimationController? _controller;

  @override
  void initState() {
    _setDuration();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _sizerChild(context);

  Container _sizerChild(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: .8,),
      constraints: BoxConstraints(maxWidth: 100 * .7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          bottomLeft:
          widget.me ? Radius.circular(6) : Radius.circular(2),
          bottomRight:
          !widget.me ? Radius.circular(6) : Radius.circular(1.2),
          topRight: Radius.circular(6),
        ),
        color: widget.me ? widget.meBgColor : widget.contactBgColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2.8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _playButton(context),
            SizedBox(width: 3),
            _durationWithNoise(context),
            SizedBox(width: 2.2),

            TextButton(
              onPressed: () {},
              child: Icon(
                Icons.keyboard_voice_rounded,
              ),
            ),

            /// x2 button will be added here.
            // _speed(context),
          ],
        ),
      ),
    );
  }

  _playButton(BuildContext context) => InkWell(
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.me ? widget.meFgColor : widget.contactFgColor,
      ),
      width: 8,
      height: 8,
      child: InkWell(
        onTap: () =>
        !_audioConfigurationDone ? null : _changePlayingStatus(),
        child: !_audioConfigurationDone
            ? Container(
          padding: const EdgeInsets.all(8),
          width: 10,
          height: 0,
          child: CircularProgressIndicator(
            strokeWidth: 1,
            color:
            widget.me ? widget.meFgColor : widget.contactFgColor,
          ),
        )
            : Icon(
          _isPlaying ? Icons.pause : Icons.play_arrow,
          color: widget.me
              ? widget.mePlayIconColor
              : widget.contactPlayIconColor,
          size: 5,
        ),
      ),
    ),
  );

  _durationWithNoise(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _noise(context),
      SizedBox(height: .3),
      Row(
        children: [
          if (!widget.played)
            widget.circle(context, 1,
                widget.me ? widget.meFgColor : widget.contactFgColorColor),
          SizedBox(width: 1.2),
          Text(
            _remainingTime,
            style: TextStyle(
              fontSize: 10,
              color: widget.me ? widget.meFgColor : widget.contactFgColor,
            ),
          )
        ],
      ),
    ],
  );

  /// Noise widget of audio.
  _noise(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final newTHeme = theme.copyWith(
      sliderTheme: SliderThemeData(
        trackShape: CustomTrackShape(),
        thumbShape: SliderComponentShape.noThumb,
        minThumbSeparation: 0,
      ),
    );

    /// document will be added
    return Theme(
      data: newTHeme,
      child: SizedBox(
        height: 6.5,
        width: noiseWidth,
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            if (_audioConfigurationDone)
              AnimatedBuilder(
                animation:
                CurvedAnimation(parent: _controller!, curve: Curves.ease),
                builder: (context, child) {
                  return Positioned(
                    left: _controller!.value,
                    child: Container(
                      width: noiseWidth,
                      height: 6,
                      color: widget.me
                          ? widget.meBgColor.withOpacity(.4)
                          : widget.contactBgColor.withOpacity(.35),
                    ),
                  );
                },
              ),
            Opacity(
              opacity: .0,
              child: Container(
                width: noiseWidth,
                color: Colors.amber.withOpacity(1),
                child: Slider(
                  min: 0.0,
                  onChangeStart: (__) => _stopPlaying(),
                  onChanged: (_) => _onChangeSlider(_),
                  value: duration + .0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  _setPlayingStatus() => _isPlaying = _playingStatus == 1;

  _startPlaying() async {
    _setPlayingStatus();
    _controller!.forward();
  }

  _stopPlaying() async {
    _controller!.stop();
  }

  void _setDuration() async {
    _audioDuration = await jsAudio.AudioPlayer().setUrl(widget.audioSrc);
    duration = _audioDuration!.inSeconds;


    /// document will be added
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: noiseWidth,
      duration: _audioDuration,
    );

    /// document will be added
    _controller!.addListener(() {
      if (_controller!.isCompleted) {
        _controller!.reset();
        _isPlaying = false;
        x2 = false;
        setState(() {});
      }
    });
    _setAnimationCunfiguration(_audioDuration);
  }

  void _setAnimationCunfiguration(Duration? audioDuration) async {
    _listenToRemaningTime();
    _remainingTime = VoiceDuration.getDuration(duration);
    _completeAnimationConfiguration();
  }

  void _completeAnimationConfiguration() =>
      setState(() => _audioConfigurationDone = true);


  void _changePlayingStatus() async {
    if (widget.onPlay != null) widget.onPlay!();
    _isPlaying ? _stopPlaying() : _startPlaying();
    setState(() => _isPlaying = !_isPlaying);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _listenToRemaningTime() {



    _player.onPositionChanged.listen((Duration p) {
      final _newRemaingTime1 = p.toString().split('.')[0];
      final _newRemaingTime2 =
      _newRemaingTime1.substring(_newRemaingTime1.length - 5);
      if (_newRemaingTime2 != _remainingTime) {
        setState(() => _remainingTime = _newRemaingTime2);
      }
    });
  }

  /// document will be added
  _onChangeSlider(double ) async {
    if (_isPlaying) _changePlayingStatus();
    duration =widget.meFgColor as int;  widget.contactFgColor ;
    _controller?.value = (noiseWidth) * duration / maxNoiseHeight;
    _remainingTime = VoiceDuration.getDuration(duration);
    await _player.seek(Duration(seconds: duration));
    setState(() {});
  }
}






/// document will be added
class CustomTrackShape extends RoundedRectSliderTrackShape {
  /// document will be added
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    const  trackHeight = 10;
    final  trackLeft = offset.dx;
    final  trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final  trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth,trackWidth);
  }
}
