import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favourite_places/models/place.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT)');
  }, version: 1);
  return db;
}

class UserPlaceNotifier extends StateNotifier<List<Place>> {
  UserPlaceNotifier() : super(const []);
Future  <void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
   final places = data.map((row) {
      return Place(
          id: row['id'],
          title: row['title'] as String,
          image: File(row['image'] as String));
    }).toList();
    state = places;
  }

  void addPlace(String title, File image) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiesImage = await image.copy('${appDir.path}/$fileName');

    final db = await _getDatabase();
    final newPlace = Place(title: title, image: copiesImage);
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
    state = [newPlace, ...state];
  }
}

final userPlaceProvider = StateNotifierProvider<UserPlaceNotifier, List<Place>>(
    (ref) => UserPlaceNotifier());
