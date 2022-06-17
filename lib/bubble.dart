import 'dart:math';
import 'package:amochat/voice_message.dart';
import 'package:flutter/material.dart';

/// document will be added
// ignore: must_be_immutable
class Bubble extends StatelessWidget {
  Bubble(this.me, this.index, {Key? key, this.voice = false}) : super(key: key);
  bool me, voice;
  int index;

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(horizontal: 5.2, vertical: 2),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          textDirection: me ? TextDirection.rtl : TextDirection.ltr,
          children: [
            _bubble(context),
            SizedBox(width: 2),
            _seenWithTime(context),
          ],
        ),
      );

  Widget _bubble(BuildContext context) => voice
      ? VoiceMessage(
          audioSrc: 'https://sounds-mp3.com/mp3/0012660.mp3',
          me: index == 5 ? false : true,
        )
      : Container(
          constraints: BoxConstraints(maxWidth: 100 * .7),
          padding: EdgeInsets.symmetric(
            horizontal: 4,
            vertical: voice ? 2.8 : 2.5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomLeft: me ? Radius.circular(6) : Radius.circular(2),
              bottomRight: !me ? Radius.circular(6) : Radius.circular(1.2),
              topRight: Radius.circular(6),
            ),
          ),

          child: Text(
            me ?
               'Hello, How are u?'
                : Random().nextBool()
                    ? 'It\'s Rainy!'
                    : Random().nextBool()
                 ? 'Ok! got it.'
                        : 'How was going bro ?',
            style: TextStyle(
                fontSize: 13.2, color: me ? Colors.white : Colors.black),
          ),
        );

  Widget _seenWithTime(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (me)
            Icon(
              Icons.done_all_outlined,
              color: Colors.red,
              size: 3.4,
            ),
          Text(
            '1:' '${index + 30}' ' PM',
            style: const TextStyle(fontSize: 11.8),
          ),
          SizedBox(height: .2)
        ],
      );


}
