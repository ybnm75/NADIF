import 'package:flutter/material.dart';
import 'package:nadif/provider/provider_auth.dart';
import 'package:nadif/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneController.text.length));
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 25.0),
          child: Column(
            children: [
              SizedBox(
                height: 200.0,
                width: 220.0,
                child: Image.asset('assets/Images/image2.png'),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Register',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Add your phone number we will send you a verification code',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: phoneController,
                cursorColor: Colors.greenAccent,
                onChanged: (value) {
                  setState(() {
                    phoneController.text = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter your phone number',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  suffixIcon: phoneController.text.length > 9
                      ? Container(
                    margin: const EdgeInsets.all(10.0),
                    height: 10.0,
                    width: 10.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child: const Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  )
                      : null,
                ),
              ),

             const SizedBox(height: 30.0,),
               SizedBox(width: double.infinity,height: 50.0,
                child: CustomButton(text: "Login", onPressed: ()=> sendPhoneNumber()),),

            ],
          ),
        ),
      )),
    );
  }
  void sendPhoneNumber () {
    final ap = Provider.of<AuthProvider>(context,listen: false);
    String phoneNumber = phoneController.text.trim();
    ap.signInWithPhone(context, phoneNumber);
  }
}
