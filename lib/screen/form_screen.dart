import 'package:flutter/material.dart';
import 'package:flutter_database/models/Transactions.dart';
import 'package:flutter_database/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  final titleContronller = TextEditingController(); //รับชื่อรายการ
  final amountContronller = TextEditingController(); //รับจำนวนเงิน

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("แบบฟอร์มบันทึกข้อมูล"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: new InputDecoration(labelText: "ชื่อรายการ"),
                    autofocus: false,
                    controller: titleContronller,
                    validator: (String str) {
                      if (str.isEmpty) {
                        return "กรุณาป้อนชื่อรายการ";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: new InputDecoration(labelText: "จำนวนเงิน"),
                    keyboardType: TextInputType.number,
                    controller: amountContronller,
                    validator: (String str) {
                      if (str.isEmpty) {
                        return "กรุณาป้อนจำนวนเงิน";
                      }
                      if (double.parse(str) <= 0) {
                        return "กรุณาป้อนตัวเลขมากกว่า 0";
                      }
                      return null;
                    },
                  ),
                  FlatButton(
                    child: Text("เพิ่มข้อมูล"),
                    color: Colors.blue,
                    onPressed: () {
                      if (formkey.currentState.validate()) {
                        var title = titleContronller.text;
                        var amount = amountContronller.text;
                        //เตรียมข้อมูล
                        Transactions statement = Transactions(
                            title: title,
                            amount: double.parse(amount),
                            date: DateTime.now());

                        //เรียก provider
                        var provider = Provider.of<TransactionProvider>(context,
                            listen: false);
                        provider.addTransaction(statement);
                        FocusScope.of(context).unfocus();

                        DefaultTabController.of(context).animateTo(0);
                        /* push(
                            context,
                            MaterialPageRoute(
                                fullscreenDialog: false,
                                builder: (context) {
                                  return MyHomePage();
                                })); */
                      }
                    },
                  )
                ],
              )),
        ));
  }
}
