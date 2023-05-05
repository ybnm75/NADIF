import 'package:flutter/material.dart';
import 'package:nadif/provider/provider_auth.dart';
import 'package:nadif/screens/register_screen.dart';
import 'package:nadif/screens/typeof_user.dart';
import 'package:nadif/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage(
                    'assets/Images/images1.png',
                  ),
                  height: 300.0,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  "Let's get started",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  "Never better time than now to start ",
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    onPressed: () async {
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
                              builder: (context) => const RegisterScreen()),
                        );
                      }
                    },
                    text: "Get started",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
