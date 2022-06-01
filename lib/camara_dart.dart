import 'package:amochat/constants.dart';
import 'package:flutter/material.dart';

class Camara extends StatefulWidget {
  const Camara({Key? key}) : super(key: key);

  @override
  _CamaraState createState() => _CamaraState();
}

class _CamaraState extends State<Camara> {



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kMessageContainerDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20.0,
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.image),
            label: Text('Add Image'),
          ),
          TextButton(
            onPressed: () {},
            child: Icon(Icons.image),
          ),
          TextButton(
            onPressed: () {},
            child: Icon(
              Icons.location_on,
            ),
          ),
        ],
      ),
    );
  }
}

