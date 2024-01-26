import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/screens/add_place.dart';
import 'package:favourite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class PlacesListScreen extends ConsumerStatefulWidget {
  const PlacesListScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
  return _PlaceListScreen();
  }
}
class _PlaceListScreen extends ConsumerState<PlacesListScreen>{
  
late   Future <void> _placesFuture;
  @override
  void initState() {
   
    super.initState();

    _placesFuture = ref.read(userPlaceProvider.notifier).loadPlaces();
  }
  @override
  Widget build(BuildContext contex) {
    final userPlaces = ref.watch(userPlaceProvider);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color.fromARGB(255, 5, 255, 180),
                Color.fromARGB(255, 250, 111, 158)
              ])),
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
      body: Padding(
          padding: EdgeInsets.all(6), child: FutureBuilder(future: _placesFuture,builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting? const Center(child: CircularProgressIndicator(),): PlacesList(places: userPlaces),),),
    );
  }
}
