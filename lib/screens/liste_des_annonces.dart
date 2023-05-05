import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../controller/location_controller.dart';
import '../provider/provider_auth.dart';

class AnnonceListe extends StatefulWidget {
  const AnnonceListe({Key? key}) : super(key: key);

  @override
  State<AnnonceListe> createState() => _AnnonceListeState();
}

class _AnnonceListeState extends State<AnnonceListe> {
  var location = [];

  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return GetBuilder<LocationController>(
        init: LocationController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(title: const Text('Liste des annonce'),centerTitle: true,backgroundColor: Colors.tealAccent,),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300.0,
                      height: 100.0,
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(border: Border.all(color: Colors.teal),borderRadius: BorderRadius.circular(10.0)),
                      child: InkWell(
                        onTap: (){
                          showDialog(context: context, builder: (context){
                            return Container(
                              child:  Dialog(
                                child: Column(
                                  children: [
                                    const Text("Ici vous pouvez voir toute les infos concernat cette annonce:",textAlign: TextAlign.center,style: TextStyle (fontSize: 13.0,color: Colors.tealAccent),),
                                    SizedBox(height: 10.0,),
                                    Column(
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.symmetric(horizontal: 16.0),
                                          child: Text(
                                            controller.currentLocation == null
                                                ? 'No location found'
                                                : controller.currentLocation!,
                                            style: const TextStyle(fontSize: 10.0,backgroundColor: Colors.transparent,color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(height: 10.0,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(width: 10.0,),
                                            Column(
                                              children: [
                                                Text('User Name:  ${ap.userModal.name!}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                                                const SizedBox(height: 10.0,),
                                                Text('Phone Number:  ${ap.userModal.phoneNumber!}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 60.0,
                                          height: 60.0,
                                          child:  CircleAvatar(
                                            backgroundColor:  Colors.greenAccent,
                                            backgroundImage: NetworkImage(ap.annonceModel.productPic!,),
                                            radius: 50.0,
                                          ),
                                        ),
                                        const SizedBox(height: 10.0,),
                                        Text('Location: ${ap.annonceModel.location!}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                                        Text('Type de dechets: ${ap.annonceModel.dechetType!}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                                        Text('Description: ${ap.annonceModel.description!}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(onPressed: (){}, child: const Text("Accepter"),),
                                        ElevatedButton(onPressed: (){}, child: const Text("Annuler"),),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          );
                        },
                        child: Card(
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator()
                              : Column(
                            children: [

                              Row(
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
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Text(
                                          controller.currentLocation == null
                                              ? 'No location found'
                                              : controller.currentLocation!,
                                          style: const TextStyle(fontSize: 10.0,backgroundColor: Colors.transparent,color: Colors.black),
                                        ),
                                      ),
                                      Text('User Name:${ap.userModal.name!}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                                      const SizedBox(height: 10.0,),
                                      Text('Phone Number:${ap.userModal.phoneNumber!}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),),

                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
    );
  }
}

