import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> openReadOnlyDatabase() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  final dbPath = join(documentsDirectory.path, 'rarbg_db.db');

  if (!File(dbPath).existsSync()) {
    // Open asset file as stream in chunks
    final byteData = await rootBundle.load('assets/db/rarbg_db.db');
    final buffer = byteData.buffer;
    final bytes = buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);

    // Write to file in chunks
    final file = File(dbPath);
    final sink = file.openWrite();

    const int chunkSize = 1024 * 1024; // 1MB chunks
    for (int i = 0; i < bytes.length; i += chunkSize) {
      final end = (i + chunkSize < bytes.length) ? i + chunkSize : bytes.length;
      sink.add(bytes.sublist(i, end));
    }

    await sink.flush();
    await sink.close();
  }

  return await openDatabase(dbPath, readOnly: true);
}
