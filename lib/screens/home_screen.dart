import 'package:flutter/material.dart';
import 'package:nadif/provider/provider_auth.dart';
import 'package:nadif/screens/cart_geolocalisaton.dart';
import 'package:nadif/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
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
            Text(ap.userModal.name),
            Text(ap.userModal.email),
            Text(ap.userModal.permis),
            Text(ap.userModal.phoneNumber),

            ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCard(),));}, child: const Text("Balayer vers la Map"))
          ],
        ),
      ),
    );
  }
}
