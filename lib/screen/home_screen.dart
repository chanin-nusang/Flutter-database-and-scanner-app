import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_database/models/Transactions.dart';
import 'package:flutter_database/providers/transaction_provider.dart';
import 'package:flutter_database/screen/form_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("แอพบัญชี"),
          actions: [
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  SystemNavigator.pop();
                  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //     return FormScreen();
                  //  }));
                })
          ],
        ),
        body: Consumer(
            builder: (context, TransactionProvider provider, Widget child) {
          var count = provider.transactions.length; //นับจำนวนข้อมูล
          if (count <= 0) {
            return Center(
                child: Text(
              "ไม่พบข้อมูล",
              style: TextStyle(fontSize: 30),
            ));
          } else {
            return ListView.builder(
                itemCount: provider.transactions.length,
                itemBuilder: (context, int index) {
                  Transactions data = provider.transactions[index];
                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: FittedBox(
                          child: Text(data.amount.toString()),
                        ),
                      ),
                      title: Text(data.title),
                      subtitle:
                          Text(DateFormat("dd/MM/yyyy").format(data.date)),
                    ),
                  );
                });
          }
        }));
  }
}
