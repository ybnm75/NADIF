import 'dart:convert';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({Key? key}) : super(key: key);
  @override
  _QrCodeScannerState createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  String? _name;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 300,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _name ?? 'Scan a QR code to get started',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      _scanQrCode(scanData.code!);
    });
  }

  Future<void> _scanQrCode(String qrCode) async {
    Map<String, dynamic> data = json.decode(qrCode);
    String phoneNumber = data['phoneNumber'];
    num? parsedPhoneNumber = num.tryParse(phoneNumber);
    if (parsedPhoneNumber == null) {
      // Handle invalid phone number here.
      return;
    }
    String name = data['name'];
    setState(() {
      _name = name;
    });
  }
}