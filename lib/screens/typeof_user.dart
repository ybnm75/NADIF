import 'package:flutter/material.dart';
import 'package:nadif/provider/provider_auth.dart';
import 'package:nadif/screens/achteur_information.dart';
import 'package:nadif/screens/chauffeur_informations.dart';
import 'package:nadif/screens/home_screen.dart';
import 'package:nadif/screens/register_screen.dart';
import 'package:provider/provider.dart';
import '../screens/fournisseurr_informations.dart';

class TypeOfUser extends StatefulWidget {
  const TypeOfUser({Key? key}) : super(key: key);

  @override
  State<TypeOfUser> createState() => _TypeOfUserState();
}

class _TypeOfUserState extends State<TypeOfUser> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello User'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 80,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                  backgroundColor: Colors.greenAccent,
                  padding: const EdgeInsets.all(20.0),
                ),
                onPressed: () async{
                  if (ap.isSignedIn == true) {
                    await ap.getDataFromSP().whenComplete(
                          () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FournisseurInformations()),
                    );
                  }
                },
                label: const Text('Fournisseur'),
                icon: const Icon(Icons.recycling),

              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: 150,
              height: 80,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                  backgroundColor: Colors.greenAccent,
                  padding: const EdgeInsets.all(20.0),
                ),
                onPressed: () async{
                  if (ap.isSignedIn == true) {
                    await ap.getDataFromSP().whenComplete(
                          () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AchteurInformations(),),
                    );
                  }
                },
                icon: const Icon(Icons.monetization_on),
                label: const Text('Achteur'),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: 150,
              height: 80,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                  backgroundColor: Colors.greenAccent,
                  padding: const EdgeInsets.all(20.0),
                ),
                onPressed: () async{
                  if (ap.isSignedIn == true) {
                    await ap.getDataFromSP().whenComplete(
                          () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChaffeurInformations(),),
                    );
                  }
                },
                icon: const Icon(Icons.local_shipping),
                label: const Text('Chauffeur'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
