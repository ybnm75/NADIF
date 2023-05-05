import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nadif/modal/user_modal.dart';
import 'package:nadif/provider/provider_auth.dart';
import 'package:nadif/screens/home_screen.dart';
import 'package:nadif/utils/utils.dart';
import 'package:nadif/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class ChaffeurInformations extends StatefulWidget {
  const ChaffeurInformations({Key? key}) : super(key: key);

  @override
  State<ChaffeurInformations> createState() =>
      _ChaffeurInformationsState();
}

class _ChaffeurInformationsState extends State<ChaffeurInformations> {
  File? image;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final permisController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    permisController.dispose();
  }

  // select user image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello Chauffeur'),
      ),
      body: SafeArea(
        child: isLoading == true
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.greenAccent,
          ),
        )
            : SingleChildScrollView(
          padding:
          const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
          child: Center(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    selectImage();
                  },
                  child: image == null
                      ? const CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.greenAccent,
                    child: Icon(
                      Icons.account_circle,
                      size: 50.00,
                      color: Colors.white,
                    ),
                  )
                      : CircleAvatar(
                    backgroundImage: FileImage(image!),
                    radius: 50.0,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 15.0),
                  margin: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      //name
                      textField(
                          hintText: 'User name',
                          icon: Icons.account_circle,
                          inputType: TextInputType.name,
                          controller: nameController),
                      //email
                      textField(
                          hintText: 'exmaple@gmail.com',
                          icon: Icons.email_rounded,
                          inputType: TextInputType.emailAddress,
                          controller: emailController),
                      textField(
                          hintText: 'A',
                          icon: Icons.account_circle,
                          inputType: TextInputType.name,
                          controller: permisController),
                      //email
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                          height: 50.0,
                          width: MediaQuery.of(context).size.width,
                          child: CustomButton(
                              text: 'Continue',
                              onPressed: () {
                                storeData();
                              })),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textField(
      {required String hintText,
        required IconData icon,
        required TextInputType inputType,
        required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        cursorColor: Colors.greenAccent,
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.greenAccent.shade100,
          filled: true,
        ),
      ),
    );
  }

  // store user data from database
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModal userModal = UserModal(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        permis: permisController.text.trim(),
        phoneNumber: "",
        userId: "",
        profilePic: "");
    if (image != null) {
      ap.saveUserDataToFirebase(
          context: context,
          userModal: userModal,
          profilePic: image!,
          userType: "chauffeur",
          onSuccess: () {
            ap.saveUserDataToSP().then(
                  (value) => ap.setSignIn().then(
                    (value) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()),
                        (route) => false),
              ),
            );
          });
    } else {
      showSnackBar(context, "Please upload your image profile");
    }
  }
}