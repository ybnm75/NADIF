class AnnonceModel {
  String? dechetType;
  String? description;
  String annonceId;
  String? productPic;
  String? location;


  AnnonceModel({this.description,this.dechetType,required this.annonceId,this.productPic,this.location});

  //to map

  factory AnnonceModel.fromMap(Map<String, dynamic> map) {
    return AnnonceModel(
      dechetType: map['dechetType'] ?? '',
      description: map['description'] ?? '',
      annonceId:  map['annonceId'] ?? '',
      productPic: map['productPic'] ?? '',
      location: map['location'] ?? '',

    );
  }
  Map<String,dynamic> toMap1 () {
    return {
      'dechetType' : dechetType,
      'description' : description,
      'annonceId' : annonceId,
      'prodcutPic': productPic,
      'location': location,
    };

  }

}