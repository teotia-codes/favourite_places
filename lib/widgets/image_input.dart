import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key,required this.onPickedImage});
  final void Function (File image) onPickedImage;
  @override
  State<StatefulWidget> createState() {
    return _ImageInput();
  }
}

class _ImageInput extends State<ImageInput> {
  File? _selectedImage;
  void _takeImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (pickedImage == null) {
      return;
    }
    setState(() {
       _selectedImage = File(pickedImage.path);
    });
  widget.onPickedImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        onPressed: _takeImage,
        icon: Icon(Icons.photo_camera_outlined),
        label: Text(
          'Take Picture',
          style: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.w600),
    ));
        if(_selectedImage != null){
          content = GestureDetector(onTap: _takeImage,child: Image.file(_selectedImage!,fit: BoxFit.cover,width: double.infinity,));
        }
    return Container(
      height: 250,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      width: double.infinity,
      child: content
      );
  }
}
