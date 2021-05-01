import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:url_launcher/url_launcher.dart';

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String scanresult;
  bool checkLineURL = false;
  //get setState => null;
  bool checkFacebookURL = false;
  bool checkYoutubeURL = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("สแกน"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: SizedBox(
                height: 200,
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          scanresult == null
                              ? "กรุณาเลือกการสแกน"
                              : "ผลการสแกน",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          scanresult ??= "",
                          style: TextStyle(fontSize: 15),
                        ),
                        Spacer(),
                        checkLineURL
                            ? SizedBox(
                                width: double.infinity,
                                child: RaisedButton(
                                  onPressed: () async {
                                    if (await canLaunch(scanresult)) {
                                      await launch(scanresult);
                                    }
                                  },
                                  color: Colors.green,
                                  child: Text(
                                    "เปิด LINE",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            : Container(),
                        Spacer(),
                        checkFacebookURL
                            ? SizedBox(
                                width: double.infinity,
                                child: RaisedButton(
                                  onPressed: () async {
                                    if (await canLaunch(scanresult)) {
                                      await launch(scanresult);
                                    }
                                  },
                                  color: Colors.blue[900],
                                  child: Text(
                                    "เปิด Facebook",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            : Container(),
                        Spacer(),
                        checkYoutubeURL
                            ? SizedBox(
                                width: double.infinity,
                                child: RaisedButton(
                                  onPressed: () async {
                                    if (await canLaunch(scanresult)) {
                                      await launch(scanresult);
                                    }
                                  },
                                  color: Colors.red[900],
                                  child: Text(
                                    "Subscribe on Youtube",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                )),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: startScan, child: Icon(Icons.qr_code_scanner_sharp)));
  }

  startScan() async {
    //อ่านข้อมูลจาก barcode / qrcode
    String cameraScanResult = await scanner.scan();
    setState(() {
      scanresult = cameraScanResult;
    });
    if (scanresult.contains("line.me")) {
      checkLineURL = true;
      checkFacebookURL = false;
      checkYoutubeURL = false;
    } else if (scanresult.contains("facebook.com") ||
        scanresult.contains("fb.com")) {
      checkFacebookURL = true;
      checkLineURL = false;
      checkYoutubeURL = false;
    } else if (scanresult.contains("youtube.com") ||
        scanresult.contains("youtu.be")) {
      checkYoutubeURL = true;
      checkFacebookURL = false;
      checkLineURL = false;
    }
  }
}
