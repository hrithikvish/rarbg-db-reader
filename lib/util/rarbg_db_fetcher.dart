import '../rarbg_db_reader.dart';

class RarbgDbFetcher {

  static Future<List<Map<String, String>>> getMoviesList(String? searchQuery) async {
    final db = await openReadOnlyDatabase();

    var sqlQuery = 'SELECT title, hash FROM items WHERE cat = "movies_x265"';
    if(searchQuery != null) {
      final searchWords = searchQuery.trim().split(RegExp(r'\s+'));
      final likeClauses = searchWords
          .map((word) => 'title LIKE "%${word.toLowerCase()}%"')
          .join(' AND ');

      sqlQuery = 'SELECT title, hash FROM items WHERE $likeClauses AND cat like "%movies%"';
    }
    final List<Map<String, Object?>> result = await db.rawQuery(sqlQuery);
    await db.close();

    return result.map((e) => {
      'title' : e['title'] as String,
      'magnet' : "magnet:?xt=urn:btih:${e['hash'] as String}",
    }).toList();
  }

  static Future<List<Map<String, String>>> getMoviesListByCategory(String category) async {
    final db = await openReadOnlyDatabase();

    var sqlQuery = 'SELECT title, hash FROM items WHERE cat = "$category"';
    final List<Map<String, Object?>> result = await db.rawQuery(sqlQuery);
    await db.close();

    return result.map((e) => {
      'title' : e['title'] as String,
      'magnet' : "magnet:?xt=urn:btih:${e['hash'] as String}",
    }).toList();
  }

  static Future<List<String>> getCategories() async {
    final db = await openReadOnlyDatabase();
    var sqlQuery = 'SELECT DISTINCT cat FROM items where cat like "%movies%"';

    final List<Map<String, Object?>> result = await db.rawQuery(sqlQuery);
    await db.close();

    return result.map((e) => e['cat'] as String).toList();
  }

}
