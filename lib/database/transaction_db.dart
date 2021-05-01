import 'dart:io';
import 'package:flutter_database/models/Transactions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB {
  //บริการเกี่ยวกับฐานข้อมูล
  String dbName;
  //ถ้ายังไม่ถูกสร้าง ให้สร้าง
  //ถ้าสร้างแล้ว ให้เปิดที่สร้างไว้
  TransactionDB({this.dbName});

  //user
  Future<Database> openDatabase() async {
    //หาตำแหน่งที่จัดเก็บข้อมูล
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);
    //สร้าง database
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  //บันทึกข้อมูล
  Future<int> InsertData(Transactions statement) async {
    //ฐานข้อมูล ส่งเข้า store
    //transaction.db มี store ข้างในชื่อ expend
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expend");

    // json
    var keyID = store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "date": statement.date.toIso8601String()
    });
    db.close();
    return keyID;
  }

  //ดึงข้อมูล
  Future<List<Transactions>> loadAllData() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expend");
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [
          SortOrder(Field.key, false) //false = เรียงใหม่ไปเก่า
        ]));
    List transactionList = <Transactions>[];
    //ดึงมาทีละแถว
    for (var record in snapshot) {
      transactionList.add(Transactions(
          title: record["title"],
          amount: record["amount"],
          date: DateTime.parse(record["date"])));
    }
    return transactionList;
  }
}
