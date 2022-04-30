import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);

  final void Function(XFile pickedImage) imagePickFn;



  @override
 _UserImagePickerState  createState() => _UserImagePickerState();
}



class _UserImagePickerState extends State<UserImagePicker> {
   XFile? _pickedImage;

  void _pickImage() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    if (_pickedImage != null)
    widget.imagePickFn(_pickedImage! );
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage:
                _pickedImage != null? FileImage(File(_pickedImage!.path)) : null,
          ),
          TextButton.icon(
            onPressed: _pickImage,
            icon: Icon(Icons.image),
            label: Text('Add Image'),
          ),
        ],
      ),
    );
  }
}
