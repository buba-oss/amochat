import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker(this.imagePick);
  final void Function(XFile pickedImage) imagePick;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  late final XFile _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40,
          ),
          TextButton.icon(
            onPressed: () {
              _pickedImage;
            },
            icon: Icon(Icons.image),
            label: Text('image'),
          ),
        ],
      ),
    );
  }
}
