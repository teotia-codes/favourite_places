import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/screens/add_place.dart';
import 'package:favourite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class PlacesListScreen extends ConsumerWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(userPlaceProvider);
    return Scaffold(

      appBar: AppBar(
        
        flexibleSpace: Container(
          decoration: const BoxDecoration(
           
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromARGB(255, 5, 255, 180), Color.fromARGB(255, 250, 111, 158)])),
        ),
        title: Text(
          'Your Favourite Places',
          style: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => AddPlaceScreen()));
            },
            icon: Icon(Icons.add_sharp),
          ),
        ],
      ),
      body: Padding(padding: EdgeInsets.all(6),child: PlacesList(places: userPlaces)),
    );
  }
}
