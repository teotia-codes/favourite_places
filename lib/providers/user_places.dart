import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favourite_places/models/place.dart';
import 'package:path/path.dart'as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class UserPlaceNotifier extends StateNotifier<List<Place>> {
  UserPlaceNotifier() : super(const []);

  void addPlace(String title,File image) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
   final copiesImage = await image.copy('${appDir.path}/$fileName');
  
    final newPlace = Place(title: title,image: copiesImage);
final dbPath= await  sql.getDatabasesPath();
 final db = await sql.openDatabase(path.join(dbPath,'places.db'),onCreate: (db, version) {
   return db.execute('CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT)');
   },version: 1);
   db.insert('user_places', {'id':newPlace.id,
   'title': newPlace.title,
   'image':newPlace.image.path});
    state = [newPlace, ...state];
  }
}

final userPlaceProvider = StateNotifierProvider<UserPlaceNotifier,List<Place>>((ref) => UserPlaceNotifier());
