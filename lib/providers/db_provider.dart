import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider{

   static late Database? _database;
   static final DBProvider db= DBProvider._();

   DBProvider._();

   Future<Database>get database async{
     //if(_database != null) return _database!;
      _database = await initDB();
      return _database!;
   }

   Future<Database> initDB() async {
      //path where save the database
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      final path= join(documentsDirectory.path, 'ScansDB.db');
      // ignore: avoid_print
      print(path);

      //Create database

      return await openDatabase(
        path,
        version: 1,
        onOpen: (db){

        },
        onCreate: (Database db, int version) async{
          await db.execute('''
           CREATE TABLE SCANS(
             id integer primary key AUTO_INCREMENT,
             tipo text,
             valor text
           )
          ''');
        }
      );
   }

   nuevoScanRaw(ScanModel nuevoScan) async{

     final int id = nuevoScan.id!;
     final String tipo = nuevoScan.tipo!;
     final String valor = nuevoScan.valor;

     final db = await database;
     final res = await db.rawInsert(''' 
      INSERT INTO SCANS (id, tipo, valor) VALUES ( $id, $tipo, $valor);

     ''');
     return res;

   }

   Future<int> nuevoScan(ScanModel nuevoScan) async {

     final db = await database;
     final res = await db.insert('SCANS',nuevoScan.toJson());
     // ignore: avoid_print
     print(res);
     return res;

   }

   Future<ScanModel> getScanById(int i)async{

     final db = await database;
     final res= await db.query('SCANS',where: 'id=?',whereArgs: [i]);
     return res.isNotEmpty? ScanModel.fromJson(res.first): ScanModel(valor: 'httpsss');

   }

    Future<List<ScanModel>> getAllScans()async{

     final db = await database;
     final res= await db.query('SCANS');
      return res.isNotEmpty? res.map((e) => ScanModel.fromJson(e)).toList(): [];
   }

    Future<List<ScanModel>> getScansForType(String tipo)async{

     final db = await database;
     final res= await db.rawQuery('''
      SELECT * FROM SCANS WHERE tipo = '$tipo'

    ''');
      return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
   }

   Future<int> updateScan(ScanModel newScan) async{
    
    final db = await database;
    final res = await db.update('SCANS',newScan.toJson(), where: 'id = ?', whereArgs: [newScan.id]);
    return res;

   }

    Future<int> deleteScan(int id)async{
      final db = await database;
      final res= await db.delete('SCANS',where: 'id=?',whereArgs: [id]);
      // ignore: avoid_print
      print('se borro la tupla');
      return res;
    }

    Future<int> deleteAllScan()async{
      final db = await database;
      final res= await db.rawDelete('''
        DELETE FROM SCANS;
      ''');
      return res;
    }

 }