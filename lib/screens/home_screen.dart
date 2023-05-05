import 'package:flutter/material.dart';
import 'package:nadif/modal/user_modal.dart';
import 'package:nadif/provider/provider_auth.dart';
import 'package:nadif/screens/cart_geolocalisaton.dart';
import 'package:nadif/screens/liste_des_annonces.dart';
import 'package:nadif/screens/qr_code_scanner.dart';
import 'package:nadif/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'annonce.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _name;

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String userCode = '${ap.userModal.phoneNumber}';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text('User Info'),
        actions: [
          IconButton(
            onPressed: () {
              ap.userSignOut().then(
                    (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomeScreen(),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.greenAccent,
              backgroundImage: NetworkImage(ap.userModal.profilePic),
              radius: 50.0,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(ap.userModal.name!),
            Text(ap.userModal.email),
            Text(ap.userModal.permis!),
            Text(ap.userModal.phoneNumber),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              child: QrImage(
                data: userCode,
                version: QrVersions.auto,
                size: 200.0,
                embeddedImage: NetworkImage(ap.userModal.profilePic),
                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: const Size(50, 50),
                ),
                errorCorrectionLevel: QrErrorCorrectLevel.Q,
                // Use a low error correction level to make the QR code less dense
                // and make the embedded image more visible
                // (increase this value if you need more error correction)
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyCard(),
                  ),
                );
              },
              child: const Text("Balayer vers la Map"),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QrCodeScanner(),
                  ),
                );
                setState(() {
                  _name = name;
                });
              },
              child: const Text("Scann QR code "),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Annonce(),
                  ),
                );
              },
              child: const Text("Créer une Annonce"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AnnonceListe(),
                  ),
                );
              },
              child: const Text("Voir les annonces:"),
            ),
          ],
        ),
      ),
    );
  }
}