import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);

  final void Function(XFile pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  XFile? _pickedImage;
  XFile? _image;

  void _pickImage() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    if (_pickedImage != null) widget.imagePickFn(_pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              _image != null
                  ? CircleAvatar(
                      radius: 64,
                      backgroundImage: _pickedImage != null
                          ? FileImage(File(_pickedImage!.path))
                          : null,
                    )
                  : Center(
                    child: CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                          'https://www.kindpng.com/picc/m/21-214439_free-high-quality-person-icon-default-profile-picture.png',
                        ),
                      ),
                 ),
              Positioned(
                bottom: -5,
                right: 120,
                child: IconButton(
                  onPressed: _pickImage,
                  icon: Icon(Icons.add_a_photo),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
