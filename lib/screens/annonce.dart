import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nadif/screens/liste_des_annonces.dart';
import 'package:provider/provider.dart';
import '../modal/annonce_model.dart';
import '../modal/user_modal.dart';
import '../provider/provider_auth.dart';
import '../utils/utils.dart';
import '../widgets/custom_button.dart';


class Annonce extends StatefulWidget {

  const Annonce({Key? key}) : super(key: key);

  @override
  State<Annonce> createState() => _AnnonceState();
}

class _AnnonceState extends State<Annonce> {
  File? image;
  final dechetTypeController = TextEditingController();
  final descriptionController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();

  final locationController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    dechetTypeController.dispose();
    dechetTypeController.dispose();
    emailController.dispose();
    nameController.dispose();
    locationController.dispose();
    super.dispose();
  }

  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return  SafeArea(child:
    Scaffold(
      appBar: AppBar(title: const Text("Vous pouver créer votre annoce ici",style: TextStyle(fontSize: 15.0),),backgroundColor: Colors.greenAccent,),
      body:
          SafeArea(
            child: isLoading == true
          ? const Center(
          child: CircularProgressIndicator(
            color: Colors.greenAccent,
          ),
    )
          :SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child:  CircleAvatar(
                            backgroundColor:  Colors.greenAccent,
                            backgroundImage: NetworkImage(ap.userModal.profilePic,),
                            radius: 50.0,
                          ),
                        ),
                        const SizedBox(width: 10.0,),
                        Column(
                          children: [
                            Text(ap.userModal.name!,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                            const SizedBox(height: 5.0,),
                            const Text('Annonce sur notre Marketplace',style: TextStyle(fontSize: 13.0),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: Colors.tealAccent),
                          ),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  selectImage();
                                },
                                child: image == null
                                    ? const CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: Colors.greenAccent,
                                  child: Icon(
                                    Icons.add_shopping_cart,
                                    size: 50.00,
                                    color: Colors.white,
                                  ),
                                )
                                    : CircleAvatar(
                                  backgroundImage: FileImage(image!),
                                  radius: 50.0,
                                ),
                              ),
                              const SizedBox(height: 5.0,),
                              const Text("Ajouter une photo"),
                            ],
                          ),

                        ),
                      ),
                    ],
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
                            hintText: 'Type de dechet',
                            icon: Icons.account_circle,
                            inputType: TextInputType.name,
                            controller: dechetTypeController),
                        textField(
                            hintText: 'Description',
                            icon: Icons.description,
                            inputType: TextInputType.name,
                            controller: descriptionController),
                        textField(
                            hintText: 'Localisation',
                            icon: Icons.location_on,
                            inputType: TextInputType.name,
                            controller: locationController),

                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                            height: 50.0,
                            width: MediaQuery.of(context).size.width,
                            child: CustomButton(
                                text: 'Créer Annonce',
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

  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModal userModal = UserModal(name: nameController.text.trim(),email: emailController.text.trim(), phoneNumber: '', userId: '', profilePic: '');
    AnnonceModel annonceModel = AnnonceModel(
        dechetType: dechetTypeController.text.trim(),
        description: descriptionController.text.trim(),
        location: locationController.text.trim(),
        annonceId: "",
        productPic: "");
    if (image != null) {
      ap.saveAnnonceDataToFirebase(
          context: context,
          userModal: userModal,
          annonceModel: annonceModel,
          productPic: image!,
          onSuccess: () {
            ap.saveAnnonceDataToSP().then(
                  (value) => ap.setSignIn().then(
                    (value) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AnnonceListe()),
                        (route) => false),
              ),
            );
          },);
    } else {
      showSnackBar(context, "Please upload your image profile");
    }
  }
}
