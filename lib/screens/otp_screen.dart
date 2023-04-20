import 'package:flutter/material.dart';
import 'package:nadif/provider/provider_auth.dart';
import 'package:nadif/screens/fournisseurr_informations.dart';
import 'package:nadif/screens/home_screen.dart';
import 'package:nadif/utils/utils.dart';
import 'package:nadif/widgets/custom_button.dart';
import 'package:nadif/widgets/custom_text.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'typeof_user.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;
  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.greenAccent,
              ))
            : Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 35.0, vertical: 25.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      SizedBox(
                        height: 220.0,
                        width: 250.0,
                        child: Image.asset('assets/Images/image3.png'),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'Verification',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const CustomText(
                        text: "Enter the OTP send to your phone number",
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.greenAccent)),
                        ),
                        onCompleted: (value) {
                          setState(() {
                            otpCode = value;
                          });
                        },
                      ),
                      const SizedBox(height: 25.0),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50.0,
                        child: CustomButton(
                          text: "Verify",
                          onPressed: () {
                            if (otpCode != null) {
                              verifyOtp(context, otpCode!);
                            } else {
                              showSnackBar(context, "Enter 6-Digits code");
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const CustomText(
                        text: "Didn't receive any code?",
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const CustomText(
                        text: "Resend new code",
                        color: Colors.greenAccent,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
        context: context,
        userOtp: userOtp,
        verificationId: widget.verificationId,
        onSuccess: () {
          ap.checkExistingUser().then((value) {
            if (value == true) {
              //user exists on our app
              ap.getDataFromFirestore().then(
                    (value) => ap.saveUserDataToSP().then(
                          (value) => ap.setSignIn().then(
                                (value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen(),
                                    ),
                                    (route) => false),
                              ),
                        ),
                  );
            } else {
              //new user
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const TypeOfUser(),
                ),
                  (route) => false,
              );
            }
          });
        });
  }
}
