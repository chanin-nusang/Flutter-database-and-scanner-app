import 'package:flutter/material.dart';
import 'package:flutter_database/providers/transaction_provider.dart';
import 'package:flutter_database/screen/form_screen.dart';
import 'package:flutter_database/screen/home_screen.dart';
import 'package:flutter_database/screen/scanner_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        })
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'แอพบัญชี'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white54,
          body: TabBarView(
            children: [HomeScreen(), FormScreen(), ScannerScreen()],
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.list),
                text: "รายการธุรกรรม",
              ),
              Tab(
                icon: Icon(Icons.add),
                text: "เพิ่มข้อมูล",
              ),
              Tab(
                icon: Icon(Icons.qr_code),
                text: "สแกน",
              ),
            ],
          ),
        ));
  }
}
