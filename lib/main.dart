import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scan_zoom/scan_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Scan with Zoom',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'QR Scan with Zoom'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String qrData = 'Waiting to scan';

  updateQrData(String qrDataFromScan) {
    setState(() {
      qrData = qrDataFromScan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'QR Data:',
              ),
              Text(
                qrData,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: new EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              height: 80.0,
              width: 80.0,
              child: FloatingActionButton(
                heroTag: Text('scan qr code'),
                onPressed: () {
                  MaterialPageRoute<String> route = MaterialPageRoute(
                    builder: (context) => ScanView(),
                  );
                  Navigator.push(context, route).then((qrString) {
                    updateQrData(qrString!);
                    HapticFeedback.mediumImpact();
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.padded,
                child: Text(
                  'Scan\nCode',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 0.20,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
