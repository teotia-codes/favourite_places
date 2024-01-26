import 'dart:io';

import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/widgets/image_input.dart';
import 'package:favourite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});
  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  void _savePlace(BuildContext context) {
    final enteredTitle = _titleController.text;
    if (enteredTitle == null || enteredTitle.isEmpty) {
      showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              title: Text('Please Add a Place',
                  style:
                      GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold)),
              content: Text(
                'Fill the text in the given section',
                style: GoogleFonts.ubuntuCondensed(),
              ),
            );
          }));
      return;
    }
    if (enteredTitle.isEmpty || _selectedImage == null) {
      return;
    }
    ref
        .read(userPlaceProvider.notifier)
        .addPlace(enteredTitle, _selectedImage!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color.fromARGB(255, 146, 247, 227),
                  Color.fromARGB(255, 204, 235, 227)
                ])),
          ),
          title: Text(
            'Add a New Place',
            style: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleController),
              const SizedBox(
                height: 16,
              ),
              ImageInput(
                onPickedImage: (image) {
                  _selectedImage = image;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              LocationInput(),
              const SizedBox(height: 12,),
              ElevatedButton.icon(
                onPressed: () {
                  _savePlace(context);
                },
                label: const Text('Add Place'),
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ));
  }
}
