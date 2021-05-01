import 'package:flutter/foundation.dart';
import 'package:flutter_database/database/transaction_db.dart';
import 'package:flutter_database/models/Transactions.dart';

class TransactionProvider with ChangeNotifier {
  //ตัวอย่างข้อมูล
  List<Transactions> transactions = [
    // Transaction(title: "ซื้อหนังสือ", amount: 500, date: DateTime.now()),
    // Transaction(title: "เสื้อผ้า", amount: 900, date: DateTime.now()),
    // Transaction(title: "กางเกง", amount: 400, date: DateTime.now()),
    // Transaction(title: "นาฬิกา", amount: 1400, date: DateTime.now()),
  ];
  //ดึงข้อมูล
  List<Transactions> getTransaction() {
    return transactions;
  }

  void initData() async {
    var db = TransactionDB(dbName: "transaction.db");
    //ดึงข้อมูลมาแสดง
    transactions = await db.loadAllData();
    notifyListeners();
  }

  void addTransaction(Transactions statement) async {
    var db = TransactionDB(dbName: "transaction.db");
    //บันทึกข้อมูล
    await db.InsertData(statement);
    //ดึงข้อมูลมาแสดง
    transactions = await db.loadAllData();
    //แจ้งเตือน consumer
    notifyListeners();
  }
}
