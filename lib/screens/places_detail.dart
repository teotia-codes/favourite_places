import 'package:favourite_places/models/place.dart';
import 'package:flutter/material.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key,required this.place});
  final Place place;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 146, 247, 227),
      appBar: AppBar(
       flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromARGB(255, 146, 247, 227), Color.fromARGB(255, 204, 235, 227)])),
        ),
       
        title:Text(place.title) ,
      ),
      body: Stack(
          children: [
            Image.file(place.image,fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,)
          ],
        ),
      );
}}